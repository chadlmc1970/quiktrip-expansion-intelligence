-- QuikTrip Expansion Intelligence Database Schema

-- Set schema
CREATE SCHEMA IF NOT EXISTS quiktrip;
SET search_path TO quiktrip, public;

-- Existing stores
CREATE TABLE IF NOT EXISTS stores (
    store_id VARCHAR(20) PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(2),
    zip_code VARCHAR(10),
    latitude DECIMAL(10, 6),
    longitude DECIMAL(11, 6),
    store_type VARCHAR(20),  -- urban, suburban, highway
    square_footage INTEGER,
    fuel_pumps INTEGER,
    opened_date DATE,
    population_5mi INTEGER,
    median_income_5mi DECIMAL(12, 2),
    avg_daily_traffic INTEGER,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Candidate expansion sites
CREATE TABLE IF NOT EXISTS candidate_sites (
    candidate_id VARCHAR(20) PRIMARY KEY,
    site_name VARCHAR(100),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(2),
    zip_code VARCHAR(10),
    latitude DECIMAL(10, 6),
    longitude DECIMAL(11, 6),
    proposed_type VARCHAR(20),
    estimated_square_footage INTEGER,
    proposed_fuel_pumps INTEGER,
    population_5mi INTEGER,
    median_income_5mi DECIMAL(12, 2),
    avg_daily_traffic INTEGER,
    land_cost DECIMAL(15, 2),
    construction_cost DECIMAL(15, 2),
    -- AI scoring results
    site_score DECIMAL(5, 2),  -- 0-100
    predicted_year1_revenue DECIMAL(15, 2),
    predicted_year1_fuel_volume DECIMAL(12, 2),
    confidence_score DECIMAL(5, 4),
    ai_analysis JSONB,
    status VARCHAR(20) DEFAULT 'evaluation',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    scored_at TIMESTAMP
);

-- Store performance (monthly aggregates)
CREATE TABLE IF NOT EXISTS store_performance (
    id SERIAL PRIMARY KEY,
    store_id VARCHAR(20) REFERENCES stores(store_id) ON DELETE CASCADE,
    month_year DATE,  -- First day of month
    total_revenue DECIMAL(15, 2),
    in_store_revenue DECIMAL(15, 2),
    fuel_revenue DECIMAL(15, 2),
    fuel_volume_gallons DECIMAL(12, 2),
    avg_basket_size DECIMAL(10, 2),
    transaction_count INTEGER,
    avg_daily_customers INTEGER,
    labor_cost DECIMAL(12, 2),
    operating_margin_pct DECIMAL(5, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(store_id, month_year)
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_stores_state_city ON stores(state, city);
CREATE INDEX IF NOT EXISTS idx_stores_location ON stores(latitude, longitude);
CREATE INDEX IF NOT EXISTS idx_stores_type ON stores(store_type);
CREATE INDEX IF NOT EXISTS idx_candidates_status ON candidate_sites(status);
CREATE INDEX IF NOT EXISTS idx_candidates_score ON candidate_sites(site_score DESC);
CREATE INDEX IF NOT EXISTS idx_performance_store_month ON store_performance(store_id, month_year);
CREATE INDEX IF NOT EXISTS idx_performance_month ON store_performance(month_year);
