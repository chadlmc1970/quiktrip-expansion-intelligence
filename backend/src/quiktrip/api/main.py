from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from src.quiktrip.api.v1 import analytics, site_scoring
from src.quiktrip.config import DASHBOARD_TITLE, DASHBOARD_SUBTITLE

app = FastAPI(
    title=DASHBOARD_TITLE,
    description=DASHBOARD_SUBTITLE,
    version="1.0.0"
)

# CORS for frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Health check
@app.get("/health")
def health():
    from src.quiktrip.db import get_connection
    status = {"service": "quiktrip-expansion-api", "version": "1.0.0"}
    try:
        with get_connection() as conn:
            conn.execute("SELECT 1")
            row = conn.execute(
                "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'quiktrip'"
            ).fetchone()
            status["database"] = "connected"
            status["tables"] = row[0] if row else 0
    except Exception as e:
        status["database"] = f"error: {e}"
    return status

# Mount routers
app.include_router(analytics.router, prefix="/v1/analytics", tags=["Analytics"])
app.include_router(site_scoring.router, prefix="/v1/site-scoring", tags=["Site Scoring"])

# Root redirect
@app.get("/")
def root():
    return {
        "message": DASHBOARD_TITLE,
        "docs": "/docs",
        "health": "/health"
    }
