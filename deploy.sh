#!/bin/bash
# QuikTrip Expansion Intelligence - Deployment Script
# This script deploys the application to Neon + Render (Free Tier)

set -e

echo "🚀 QuikTrip Expansion Intelligence - Deployment"
echo "================================================"
echo ""

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo "❌ ERROR: DATABASE_URL not set"
    echo ""
    echo "Please set your Neon database connection string:"
    echo "export DATABASE_URL='postgresql://user:pass@ep-xxx.neon.tech/dbname?sslmode=require'"
    echo ""
    echo "You can:"
    echo "1. Create a new database at https://neon.tech (Free Tier)"
    echo "2. Or use your existing Neon project and create a new database"
    exit 1
fi

echo "✅ DATABASE_URL is set"
echo ""

# Check if ANTHROPIC_API_KEY is set
if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "❌ ERROR: ANTHROPIC_API_KEY not set"
    echo ""
    echo "Please set your Anthropic API key:"
    echo "export ANTHROPIC_API_KEY='sk-ant-...'"
    exit 1
fi

echo "✅ ANTHROPIC_API_KEY is set"
echo ""

# Step 1: Create database schema
echo "📊 Step 1: Creating database schema..."
psql "$DATABASE_URL" -f backend/sql/001_schema.sql
echo "✅ Schema created"
echo ""

# Step 2: Create analytics views
echo "📈 Step 2: Creating analytics views..."
psql "$DATABASE_URL" -f backend/sql/002_views.sql
echo "✅ Views created"
echo ""

# Step 3: Seed stores data
echo "🏪 Step 3: Seeding 50 QuikTrip stores..."
psql "$DATABASE_URL" -f backend/sql/003_seed_stores.sql
echo "✅ Stores seeded"
echo ""

# Step 4: Seed candidate sites
echo "📍 Step 4: Seeding 20 candidate sites..."
psql "$DATABASE_URL" -f backend/sql/004_seed_candidates.sql
echo "✅ Candidates seeded"
echo ""

# Step 5: Generate performance data
echo "💰 Step 5: Generating 24 months of performance data..."
psql "$DATABASE_URL" -f backend/sql/005_seed_performance.sql
echo "✅ Performance data generated"
echo ""

# Verify data
echo "🔍 Verifying database..."
STORE_COUNT=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM quiktrip.stores;")
CANDIDATE_COUNT=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM quiktrip.candidate_sites;")
PERFORMANCE_COUNT=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM quiktrip.store_performance;")

echo "   Stores: $STORE_COUNT"
echo "   Candidates: $CANDIDATE_COUNT"
echo "   Performance records: $PERFORMANCE_COUNT"
echo ""

if [ "$STORE_COUNT" -lt 50 ]; then
    echo "⚠️  Warning: Expected 50 stores, got $STORE_COUNT"
fi

echo "✅ Database setup complete!"
echo ""
echo "================================================"
echo "📦 Next: Deploy to Render"
echo "================================================"
echo ""
echo "Option 1: Use Render Dashboard (Recommended)"
echo "--------------------------------------------"
echo "1. Go to https://dashboard.render.com"
echo "2. Click 'New +' → 'Web Service'"
echo "3. Connect repo: github.com/chadlmc1970/quiktrip-expansion-intelligence"
echo ""
echo "Backend Service:"
echo "  Name: quiktrip-expansion-api"
echo "  Root Dir: backend"
echo "  Build: pip install -r requirements.txt"
echo "  Start: uvicorn src.quiktrip.api.main:app --host 0.0.0.0 --port \$PORT"
echo "  Env Vars:"
echo "    DATABASE_URL=$DATABASE_URL"
echo "    ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY"
echo "    AI_MODEL=claude-opus-4-6"
echo ""
echo "Frontend Service:"
echo "  Name: quiktrip-expansion-frontend"
echo "  Root Dir: frontend"
echo "  Build: npm install && npm run build"
echo "  Start: npm start"
echo "  Env Vars:"
echo "    NEXT_PUBLIC_API_URL=https://quiktrip-expansion-api.onrender.com"
echo ""
echo "Option 2: Use Render CLI (if installed)"
echo "----------------------------------------"
echo "render deploy"
echo ""
echo "🎉 Database is ready! Complete Render setup to go live."
