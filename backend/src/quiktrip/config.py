import os

DATABASE_URL = os.getenv("DATABASE_URL")
ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY", "")
AI_MODEL = os.getenv("AI_MODEL", "claude-opus-4-6")
AI_ENABLED = bool(ANTHROPIC_API_KEY)

# QuikTrip branding
BRAND_NAME = "QuikTrip"
DASHBOARD_TITLE = "QuikTrip Expansion Intelligence Platform"
DASHBOARD_SUBTITLE = "Powered by SAP Business Data Cloud + AI"
