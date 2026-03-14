from fastapi import APIRouter
from src.quiktrip.db import get_connection

router = APIRouter()

@router.get("/dashboard-kpis")
def get_dashboard_kpis():
    """Get executive dashboard KPIs"""
    with get_connection() as conn:
        row = conn.execute("SELECT * FROM v_dashboard_kpis").fetchone()

    if not row:
        return {
            "total_stores": 0,
            "candidates_in_pipeline": 0,
            "avg_candidate_score": 0.0,
            "projected_new_revenue": 0.0,
            "avg_store_revenue_12mo": 0.0,
            "total_revenue_last_month": 0.0
        }

    return {
        "total_stores": row[0],
        "candidates_in_pipeline": row[1],
        "avg_candidate_score": float(row[2] or 0),
        "projected_new_revenue": float(row[3] or 0),
        "avg_store_revenue_12mo": float(row[4] or 0),
        "total_revenue_last_month": float(row[5] or 0)
    }

@router.get("/top-performers")
def get_top_performers(limit: int = 20):
    """Get top performing stores"""
    with get_connection() as conn:
        rows = conn.execute(
            "SELECT * FROM v_top_performers LIMIT %s", (limit,)
        ).fetchall()
    return [
        {
            "store_id": r[0],
            "store_name": r[1],
            "city": r[2],
            "state": r[3],
            "avg_revenue": float(r[4]),
            "avg_margin": float(r[5])
        }
        for r in rows
    ]

@router.get("/stores")
def get_all_stores(limit: int = 100):
    """Get list of all stores"""
    with get_connection() as conn:
        rows = conn.execute("""
            SELECT store_id, store_name, city, state, store_type,
                   population_5mi, median_income_5mi, avg_daily_traffic
            FROM stores
            WHERE status = 'active'
            ORDER BY store_id
            LIMIT %s
        """, (limit,)).fetchall()

    return [
        {
            "store_id": r[0],
            "store_name": r[1],
            "city": r[2],
            "state": r[3],
            "store_type": r[4],
            "population_5mi": r[5],
            "median_income_5mi": float(r[6]) if r[6] else 0,
            "avg_daily_traffic": r[7]
        }
        for r in rows
    ]
