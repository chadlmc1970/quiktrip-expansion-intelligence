-- QuikTrip Analytics Views

SET search_path TO quiktrip, public;

-- Store performance summary
CREATE OR REPLACE VIEW v_store_summary AS
SELECT
    s.store_id,
    s.store_name,
    s.city,
    s.state,
    s.store_type,
    COUNT(sp.id) as months_data,
    AVG(sp.total_revenue) as avg_monthly_revenue,
    AVG(sp.fuel_volume_gallons) as avg_monthly_fuel_volume,
    AVG(sp.operating_margin_pct) as avg_margin_pct,
    STDDEV(sp.total_revenue) as revenue_volatility,
    s.population_5mi,
    s.median_income_5mi,
    s.avg_daily_traffic
FROM stores s
LEFT JOIN store_performance sp ON s.store_id = sp.store_id
WHERE sp.month_year >= CURRENT_DATE - INTERVAL '24 months'
GROUP BY s.store_id, s.store_name, s.city, s.state, s.store_type,
         s.population_5mi, s.median_income_5mi, s.avg_daily_traffic;

-- Dashboard KPIs
CREATE OR REPLACE VIEW v_dashboard_kpis AS
SELECT
    (SELECT COUNT(*) FROM stores WHERE status = 'active') as total_active_stores,
    (SELECT COUNT(*) FROM candidate_sites WHERE status IN ('evaluation', 'approved')) as candidates_in_pipeline,
    (SELECT COALESCE(AVG(site_score), 0) FROM candidate_sites WHERE site_score IS NOT NULL) as avg_candidate_score,
    (SELECT COALESCE(SUM(predicted_year1_revenue), 0) FROM candidate_sites WHERE status = 'approved') as projected_new_revenue,
    (SELECT COALESCE(AVG(total_revenue), 0) FROM store_performance WHERE month_year >= CURRENT_DATE - INTERVAL '12 months') as avg_store_revenue_12mo,
    (SELECT COALESCE(SUM(total_revenue), 0) FROM store_performance WHERE month_year >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')) as total_revenue_last_month;

-- Top performing stores
CREATE OR REPLACE VIEW v_top_performers AS
SELECT
    s.store_id,
    s.store_name,
    s.city,
    s.state,
    AVG(sp.total_revenue) as avg_revenue,
    AVG(sp.operating_margin_pct) as avg_margin
FROM stores s
JOIN store_performance sp ON s.store_id = sp.store_id
WHERE sp.month_year >= CURRENT_DATE - INTERVAL '12 months'
GROUP BY s.store_id, s.store_name, s.city, s.state
HAVING COUNT(sp.id) >= 6  -- At least 6 months of data
ORDER BY avg_revenue DESC
LIMIT 20;

-- Candidate site rankings
CREATE OR REPLACE VIEW v_candidate_rankings AS
SELECT
    candidate_id,
    site_name,
    city,
    state,
    site_score,
    predicted_year1_revenue,
    confidence_score,
    CASE
        WHEN (land_cost + construction_cost) > 0
        THEN (predicted_year1_revenue - (land_cost + construction_cost)) / (land_cost + construction_cost)
        ELSE NULL
    END as roi_estimate,
    status
FROM candidate_sites
WHERE status IN ('evaluation', 'approved')
ORDER BY site_score DESC NULLS LAST;
