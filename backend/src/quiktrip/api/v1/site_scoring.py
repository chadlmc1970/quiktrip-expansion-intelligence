from fastapi import APIRouter, HTTPException
from src.quiktrip.services.scoring_service import score_candidate_site
from src.quiktrip.db import get_connection
import json

router = APIRouter()

@router.post("/score/{candidate_id}")
async def score_site(candidate_id: str):
    """Score a candidate site using AI"""
    try:
        result = await score_candidate_site(candidate_id)

        # Update database
        with get_connection() as conn:
            conn.execute("""
                UPDATE candidate_sites
                SET site_score = %s,
                    predicted_year1_revenue = %s,
                    confidence_score = %s,
                    ai_analysis = %s,
                    scored_at = CURRENT_TIMESTAMP
                WHERE candidate_id = %s
            """, (
                result["site_score"],
                result["predicted_revenue"],
                result["confidence"],
                json.dumps(result.get("analysis", {})),
                candidate_id
            ))
            conn.commit()

        return result
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/rankings")
def get_site_rankings():
    """Get ranked candidate sites"""
    with get_connection() as conn:
        rows = conn.execute("SELECT * FROM v_candidate_rankings").fetchall()
    return [
        {
            "candidate_id": r[0],
            "site_name": r[1],
            "city": r[2],
            "state": r[3],
            "site_score": float(r[4] or 0),
            "predicted_revenue": float(r[5] or 0),
            "confidence": float(r[6] or 0),
            "roi_estimate": float(r[7] or 0) if r[7] else 0,
            "status": r[8]
        }
        for r in rows
    ]

@router.get("/candidates")
def get_all_candidates():
    """Get all candidate sites"""
    with get_connection() as conn:
        rows = conn.execute("""
            SELECT candidate_id, site_name, city, state, proposed_type,
                   population_5mi, median_income_5mi, avg_daily_traffic,
                   land_cost, construction_cost, site_score, predicted_year1_revenue,
                   confidence_score, status
            FROM candidate_sites
            ORDER BY site_score DESC NULLS LAST
        """).fetchall()

    return [
        {
            "candidate_id": r[0],
            "site_name": r[1],
            "city": r[2],
            "state": r[3],
            "proposed_type": r[4],
            "population_5mi": r[5],
            "median_income_5mi": float(r[6]) if r[6] else 0,
            "avg_daily_traffic": r[7],
            "land_cost": float(r[8]) if r[8] else 0,
            "construction_cost": float(r[9]) if r[9] else 0,
            "site_score": float(r[10]) if r[10] else None,
            "predicted_revenue": float(r[11]) if r[11] else None,
            "confidence": float(r[12]) if r[12] else None,
            "status": r[13]
        }
        for r in rows
    ]
