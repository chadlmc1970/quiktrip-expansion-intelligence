# 🚀 QuikTrip Expansion Intelligence - Quick Deploy (Free Tier)

**Total Time: ~10 minutes**

---

## Step 1: Database Setup (3 minutes)

### Option A: Use Existing Neon Database (Fastest)
If you already have a Neon database (like your CatchWeight one):

```bash
cd ~/quiktrip-expansion-intelligence

# Use your existing Neon connection
export DATABASE_URL="postgresql://neondb_owner:YOUR_PASSWORD@ep-dark-hill-aiwdm4cf-pooler.c-4.us-east-1.aws.neon.tech/neondb?sslmode=require"

# Run migrations (creates separate 'quiktrip' schema)
psql "$DATABASE_URL" -f backend/sql/001_schema.sql
psql "$DATABASE_URL" -f backend/sql/002_views.sql
psql "$DATABASE_URL" -f backend/sql/003_seed_stores.sql
psql "$DATABASE_URL" -f backend/sql/004_seed_candidates.sql
psql "$DATABASE_URL" -f backend/sql/005_seed_performance.sql

# Verify
psql "$DATABASE_URL" -c "SELECT COUNT(*) FROM quiktrip.stores;"
# Should show: 50
```

### Option B: Create New Neon Database (Free Tier)
1. Go to https://console.neon.tech
2. Click "Create Project"
3. Name: `quiktrip-expansion`
4. Region: `US East (Ohio)`
5. Click "Create Project"
6. Copy the connection string
7. Run the same commands above with your new connection string

---

## Step 2: Deploy Backend to Render (3 minutes)

1. Go to https://dashboard.render.com/new/web
2. Connect GitHub repo: `chadlmc1970/quiktrip-expansion-intelligence`
3. Configure:

**Settings:**
- Name: `quiktrip-expansion-api`
- Region: `Oregon (US West)`
- Branch: `main`
- Root Directory: `backend`
- Runtime: `Python 3`
- Build Command: `pip install -r requirements.txt`
- Start Command: `uvicorn src.quiktrip.api.main:app --host 0.0.0.0 --port $PORT`
- Instance Type: `Free`

**Environment Variables** (click "Add Environment Variable"):
```
DATABASE_URL = postgresql://your-neon-connection-string
ANTHROPIC_API_KEY = sk-ant-api03-YOUR-KEY
AI_MODEL = claude-opus-4-6
```

4. Click "Create Web Service"
5. Wait 5 minutes for deployment
6. Copy the URL: `https://quiktrip-expansion-api.onrender.com`
7. Test: `curl https://quiktrip-expansion-api.onrender.com/health`

---

## Step 3: Deploy Frontend to Render (3 minutes)

1. Go to https://dashboard.render.com/new/web
2. Select same repo: `chadlmc1970/quiktrip-expansion-intelligence`
3. Configure:

**Settings:**
- Name: `quiktrip-expansion-frontend`
- Region: `Oregon (US West)`
- Branch: `main`
- Root Directory: `frontend`
- Runtime: `Node`
- Build Command: `npm install && npm run build`
- Start Command: `npm start`
- Instance Type: `Free`

**Environment Variables:**
```
NEXT_PUBLIC_API_URL = https://quiktrip-expansion-api.onrender.com
```

4. Click "Create Web Service"
5. Wait 5 minutes for deployment
6. Your dashboard will be live at: `https://quiktrip-expansion-frontend.onrender.com`

---

## Step 4: Test Production (1 minute)

1. **Test Backend API:**
```bash
curl https://quiktrip-expansion-api.onrender.com/health
curl https://quiktrip-expansion-api.onrender.com/v1/analytics/dashboard-kpis
```

2. **Test Frontend:**
Open browser: `https://quiktrip-expansion-frontend.onrender.com`

Should see:
- ✅ QuikTrip Expansion Intelligence dashboard
- ✅ 50 active stores KPI
- ✅ 20 candidates in pipeline KPI
- ✅ Top performing stores list
- ✅ Red QuikTrip branding

3. **Test AI Scoring:**
- Click "Candidate Sites" in nav
- Click "Score This Site" on any candidate
- Should see AI-generated score (0-100) appear

---

## Troubleshooting

### Database Connection Issues
```bash
# Test connection
psql "$DATABASE_URL" -c "SELECT 1;"

# Check if quiktrip schema exists
psql "$DATABASE_URL" -c "\dn"
```

### Backend Not Starting
- Check Render logs: Dashboard → quiktrip-expansion-api → Logs
- Verify DATABASE_URL is set correctly
- Verify ANTHROPIC_API_KEY is set

### Frontend Can't Connect to Backend
- Verify `NEXT_PUBLIC_API_URL` matches backend URL
- Check backend is deployed and healthy: `/health` endpoint

### AI Scoring Not Working
- Verify ANTHROPIC_API_KEY is valid
- Check backend logs for API errors
- System falls back to heuristic scoring if AI unavailable

---

## Free Tier Limits

**Neon (Free):**
- ✅ 3 GB storage (plenty for this POC)
- ✅ 300 compute hours/month
- ✅ Auto-suspend after inactivity

**Render (Free):**
- ✅ 750 free hours/month per service
- ✅ Auto-sleep after 15 min inactivity
- ✅ Cold start ~30 seconds

**Anthropic (Free Trial):**
- ✅ $5 free credit
- ✅ ~150-200 site scores with Claude Opus

---

## Next Steps After Deployment

1. **Update MEMORY.md** with production URLs
2. **Test all features**:
   - Dashboard loads
   - Store list displays
   - Candidate scoring works
   - AI analysis generates
3. **Share demo** with stakeholders
4. **Monitor usage** (Render Dashboard → Metrics)

---

## Production URLs

After deployment, update these in your notes:

- **Frontend**: https://quiktrip-expansion-frontend.onrender.com
- **Backend API**: https://quiktrip-expansion-api.onrender.com
- **API Docs**: https://quiktrip-expansion-api.onrender.com/docs
- **GitHub**: https://github.com/chadlmc1970/quiktrip-expansion-intelligence

---

## Quick Commands Reference

```bash
# Navigate to project
cd ~/quiktrip-expansion-intelligence

# Run database setup
export DATABASE_URL="postgresql://..."
export ANTHROPIC_API_KEY="sk-ant-..."
./deploy.sh

# Test locally
cd backend && uvicorn src.quiktrip.api.main:app --reload
cd frontend && npm run dev

# Push updates
git add -A
git commit -m "Update QuikTrip dashboard"
git push origin main
# Render auto-deploys in ~5 minutes

# Check deployment status
curl https://quiktrip-expansion-api.onrender.com/health
```

---

**🎉 You're ready to deploy!** Follow Steps 1-4 above and you'll have a live QuikTrip Expansion Intelligence dashboard in ~10 minutes.
