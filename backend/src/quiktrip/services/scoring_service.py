from anthropic import Anthropic
from src.quiktrip.config import ANTHROPIC_API_KEY, AI_MODEL, AI_ENABLED
from src.quiktrip.db import get_connection
import json

client = Anthropic(api_key=ANTHROPIC_API_KEY) if AI_ENABLED else None

async def score_candidate_site(candidate_id: str):
    """Score candidate site using AI analysis"""

    # Get candidate data
    with get_connection() as conn:
        candidate = conn.execute(
            "SELECT * FROM candidate_sites WHERE candidate_id = %s",
            (candidate_id,)
        ).fetchone()

        if not candidate:
            raise ValueError(f"Candidate {candidate_id} not found")

        # Get comparable stores
        comparables = conn.execute("""
            SELECT s.store_id, s.store_name, AVG(sp.total_revenue) as avg_revenue
            FROM stores s
            JOIN store_performance sp ON s.store_id = sp.store_id
            WHERE s.store_type = %s
              AND s.population_5mi BETWEEN %s * 0.9 AND %s * 1.1
              AND sp.month_year >= CURRENT_DATE - INTERVAL '12 months'
            GROUP BY s.store_id, s.store_name
            ORDER BY avg_revenue DESC
            LIMIT 10
        """, (candidate[8], candidate[13], candidate[13])).fetchall()

    if not AI_ENABLED:
        # Fallback heuristic scoring
        return heuristic_score(candidate, comparables)

    # AI-powered scoring
    comp_details = "\n".join([
        f"- {c[1]}: ${c[2]:,.0f}/month avg revenue"
        for c in comparables
    ]) if comparables else "No directly comparable stores found"

    avg_comp_revenue = (sum(c[2] for c in comparables) / len(comparables)) if comparables else 200000

    prompt = f"""Analyze this QuikTrip convenience store expansion candidate:

Location: {candidate[3]}, {candidate[4]} {candidate[5]}
Site Name: {candidate[2]}
Type: {candidate[8]}
Demographics:
- Population (5mi radius): {candidate[13]:,}
- Median Income (5mi): ${candidate[14]:,.2f}
- Daily Traffic: {candidate[15]:,} vehicles/day

Investment:
- Land Cost: ${candidate[16]:,.2f}
- Construction Cost: ${candidate[17]:,.2f}
- Total Investment: ${(candidate[16] + candidate[17]):,.2f}

Comparable Stores (within similar demographics):
{comp_details}
Average Comparable Revenue: ${avg_comp_revenue:,.0f}/month

Analyze this site and provide:
1. Site score (0-100, where 100 is excellent expansion opportunity)
2. Predicted first-year monthly revenue
3. Confidence score (0-1)
4. Brief 2-3 sentence analysis

Return ONLY valid JSON (no markdown):
{{
  "site_score": <number 0-100>,
  "predicted_revenue": <number>,
  "confidence": <number 0-1>,
  "analysis": "<text>"
}}"""

    try:
        message = client.messages.create(
            model=AI_MODEL,
            max_tokens=2048,
            messages=[{"role": "user", "content": prompt}]
        )

        response_text = message.content[0].text.strip()
        # Remove markdown code blocks if present
        if response_text.startswith("```"):
            response_text = response_text.split("\n", 1)[1]
            response_text = response_text.rsplit("```", 1)[0]

        result = json.loads(response_text)
        return result
    except Exception as e:
        print(f"AI scoring failed: {e}, falling back to heuristic")
        return heuristic_score(candidate, comparables)

def heuristic_score(candidate, comparables):
    """Fallback scoring without AI"""
    avg_comp_revenue = (sum(c[2] for c in comparables) / len(comparables)) if comparables else 200000

    # Simple scoring formula
    score = 50  # Base

    # Population factor (up to +20)
    if candidate[13]:
        score += min(20, (candidate[13] / 50000) * 20)

    # Income factor (up to +15)
    if candidate[14]:
        score += min(15, (float(candidate[14]) / 100000) * 15)

    # Traffic factor (up to +15)
    if candidate[15]:
        score += min(15, (candidate[15] / 30000) * 15)

    # Cap at 100
    score = min(100, score)

    return {
        "site_score": round(score, 2),
        "predicted_revenue": round(avg_comp_revenue * 0.85, 2),
        "confidence": 0.65,
        "analysis": "Heuristic score (AI unavailable). Based on demographics and traffic patterns compared to similar existing stores."
    }
