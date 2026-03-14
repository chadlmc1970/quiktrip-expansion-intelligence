# QuikTrip Expansion Intelligence Platform

AI-powered store expansion analytics and site selection intelligence for QuikTrip convenience stores.

**Powered by SAP Business Data Cloud + AI**

## Features

- 🏪 **Store Performance Analytics** - Track 1,000+ existing QuikTrip stores
- 📍 **AI-Powered Site Scoring** - Score candidate expansion sites (0-100)
- 💰 **Revenue Forecasting** - Predict first-year revenue with confidence intervals
- 🎯 **Strategic Insights** - Data-driven expansion recommendations
- 🗺️ **Geographic Analysis** - Demographics, traffic, and market analysis

## Tech Stack

- **Backend**: FastAPI + Python 3.11
- **Frontend**: Next.js 16 + React 19 + Tailwind CSS 4
- **Database**: PostgreSQL (Neon)
- **AI**: Claude Opus 4 via Anthropic SDK
- **Deployment**: Render (auto-deploy from GitHub)

## Project Structure

```
quiktrip-expansion-intelligence/
├── backend/                      # FastAPI backend
│   ├── src/quiktrip/
│   │   ├── api/                 # API routes
│   │   ├── services/            # Business logic
│   │   ├── db.py                # Database connection
│   │   └── config.py            # Configuration
│   ├── sql/                     # Database migrations & seed data
│   ├── requirements.txt
│   └── render.yaml
└── frontend/                     # Next.js frontend
    ├── app/                     # Pages (App Router)
    ├── components/              # Reusable components
    ├── lib/                     # Utilities
    └── package.json
```

## Local Development

### Backend Setup

```bash
cd backend
pip install -r requirements.txt

# Set environment variables
export DATABASE_URL="postgresql://..."
export ANTHROPIC_API_KEY="sk-ant-..."

# Run server
uvicorn src.quiktrip.api.main:app --reload

# API will be available at http://localhost:8000
# Docs: http://localhost:8000/docs
```

### Frontend Setup

```bash
cd frontend
npm install
npm run dev

# Frontend will be available at http://localhost:3000
```

### Database Setup

```bash
# Connect to Neon database
psql $DATABASE_URL

# Run migrations
\i backend/sql/001_schema.sql
\i backend/sql/002_views.sql
\i backend/sql/003_seed_stores.sql
\i backend/sql/004_seed_candidates.sql
\i backend/sql/005_seed_performance.sql
```

## Production Deployment

### Render Configuration

1. Connect GitHub repository to Render
2. Create two web services:
   - `quiktrip-expansion-api` (Python)
   - `quiktrip-expansion-frontend` (Node.js)
3. Set environment variables in Render dashboard:
   - `DATABASE_URL` (Neon PostgreSQL connection string)
   - `ANTHROPIC_API_KEY` (Claude API key)
   - `NEXT_PUBLIC_API_URL` (Backend API URL)

### Auto-Deploy Workflow

```bash
git add .
git commit -m "Update QuikTrip dashboard"
git push origin main

# Render automatically deploys to production (~5-10 minutes)
```

## Production URLs

- **Frontend**: https://quiktrip-expansion-frontend.onrender.com
- **Backend API**: https://quiktrip-expansion-api.onrender.com
- **API Docs**: https://quiktrip-expansion-api.onrender.com/docs

## API Endpoints

### Analytics
- `GET /v1/analytics/dashboard-kpis` - Executive dashboard KPIs
- `GET /v1/analytics/top-performers` - Top performing stores
- `GET /v1/analytics/stores` - List all stores

### Site Scoring
- `POST /v1/site-scoring/score/{candidate_id}` - Score a candidate site with AI
- `GET /v1/site-scoring/rankings` - Get ranked candidate sites
- `GET /v1/site-scoring/candidates` - List all candidates

### Health Check
- `GET /health` - Service health status

## AI Features

### Site Scoring Algorithm

Uses Claude Opus 4 to analyze:
- Demographics (population, income within 5-mile radius)
- Traffic patterns (daily vehicle counts)
- Investment costs (land + construction)
- Comparable store performance

Returns:
- Site score (0-100, where 100 is excellent)
- Predicted first-year revenue
- Confidence score (0-1)
- Natural language analysis

### Fallback Mode

If AI is unavailable, uses heuristic scoring based on:
- Population density factor
- Income level factor
- Traffic volume factor

## Database Schema

### Core Tables
- `stores` - Existing QuikTrip locations (50 seed stores)
- `candidate_sites` - Expansion opportunities (20 seed candidates)
- `store_performance` - Monthly performance metrics (24 months per store)

### Analytics Views
- `v_dashboard_kpis` - Executive dashboard metrics
- `v_top_performers` - Top 20 stores by revenue
- `v_candidate_rankings` - Ranked expansion sites

## QuikTrip Branding

- **Primary Color**: QuikTrip Red (#E70D30)
- **Secondary**: Dark Charcoal (#323232)
- **Accent**: Clean, modern convenience retail aesthetic

## Testing

### Backend Tests
```bash
cd backend
curl http://localhost:8000/health
curl http://localhost:8000/v1/analytics/dashboard-kpis
```

### Frontend Tests
```bash
# Visit http://localhost:3000
# Check dashboard loads with KPIs
# Check candidate sites page shows scoring functionality
```

## Development Notes

- Backend uses `psycopg` for direct SQL queries (no ORM)
- Frontend uses Next.js 16 App Router with RSC
- Tailwind CSS 4 for styling
- Recharts for data visualization
- Claude API for AI-powered site scoring

## Support

For issues or questions:
- Backend API: Check `/docs` endpoint for Swagger documentation
- Frontend: Check browser console for errors
- Database: Verify Neon connection string in environment variables

---

**Built with Claude Code by Anthropic**

