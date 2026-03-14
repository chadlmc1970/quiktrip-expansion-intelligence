-- QuikTrip Store Performance Seed Data
-- Generates 24 months of realistic performance data for all stores

SET search_path TO quiktrip, public;

-- Generate performance data for the last 24 months
-- This uses a function to create realistic revenue patterns by store type

DO $$
DECLARE
    store_rec RECORD;
    month_date DATE;
    base_revenue DECIMAL(15,2);
    seasonal_factor DECIMAL(5,2);
    fuel_pct DECIMAL(5,2);
    margin_pct DECIMAL(5,2);
BEGIN
    -- For each store
    FOR store_rec IN SELECT * FROM stores LOOP
        -- Base revenue by store type
        IF store_rec.store_type = 'urban' THEN
            base_revenue := 200000 + (RANDOM() * 20000);
            fuel_pct := 0.45;  -- 45% fuel, 55% in-store
        ELSIF store_rec.store_type = 'suburban' THEN
            base_revenue := 240000 + (RANDOM() * 40000);
            fuel_pct := 0.55;  -- 55% fuel, 45% in-store
        ELSE  -- highway
            base_revenue := 270000 + (RANDOM() * 50000);
            fuel_pct := 0.65;  -- 65% fuel, 35% in-store
        END IF;

        -- Generate last 24 months
        FOR i IN 0..23 LOOP
            month_date := DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month' * i);

            -- Seasonal factors
            IF EXTRACT(MONTH FROM month_date) IN (6,7,8) THEN
                seasonal_factor := 1.15;  -- Summer fuel spike
            ELSIF EXTRACT(MONTH FROM month_date) IN (11,12) THEN
                seasonal_factor := 1.20;  -- Holiday shopping spike
            ELSIF EXTRACT(MONTH FROM month_date) IN (1,2) THEN
                seasonal_factor := 0.90;  -- Winter slowdown
            ELSE
                seasonal_factor := 1.0;
            END IF;

            -- Add random variance
            seasonal_factor := seasonal_factor * (0.95 + RANDOM() * 0.10);

            -- Calculate revenues
            DECLARE
                total_rev DECIMAL(15,2);
                fuel_rev DECIMAL(15,2);
                instore_rev DECIMAL(15,2);
                fuel_volume DECIMAL(12,2);
            BEGIN
                total_rev := base_revenue * seasonal_factor;
                fuel_rev := total_rev * fuel_pct;
                instore_rev := total_rev - fuel_rev;
                fuel_volume := fuel_rev / 3.50;  -- $3.50/gallon avg

                -- Margin varies by type
                IF store_rec.store_type = 'urban' THEN
                    margin_pct := 9.0 + RANDOM() * 3.0;
                ELSIF store_rec.store_type = 'suburban' THEN
                    margin_pct := 10.0 + RANDOM() * 2.5;
                ELSE  -- highway
                    margin_pct := 8.5 + RANDOM() * 2.0;
                END IF;

                -- Insert performance record
                INSERT INTO store_performance (
                    store_id, month_year, total_revenue, in_store_revenue,
                    fuel_revenue, fuel_volume_gallons, avg_basket_size,
                    transaction_count, avg_daily_customers, labor_cost,
                    operating_margin_pct
                ) VALUES (
                    store_rec.store_id,
                    month_date,
                    total_rev,
                    instore_rev,
                    fuel_rev,
                    fuel_volume,
                    8.50 + RANDOM() * 3.50,  -- $8.50-$12 basket
                    (instore_rev / (8.50 + RANDOM() * 3.50))::INTEGER,
                    (total_rev / 30 / (8.50 + RANDOM() * 3.50))::INTEGER,
                    total_rev * 0.15 * (0.9 + RANDOM() * 0.2),  -- Labor ~15% of revenue
                    margin_pct
                )
                ON CONFLICT (store_id, month_year) DO NOTHING;
            END;
        END LOOP;
    END LOOP;
END $$;
