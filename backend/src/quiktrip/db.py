import psycopg
from contextlib import contextmanager
from src.quiktrip.config import DATABASE_URL

@contextmanager
def get_connection():
    """Context manager for database connections"""
    conn = psycopg.connect(DATABASE_URL, connect_timeout=10)
    try:
        conn.execute("SET statement_timeout = '30s'")
        conn.execute("SET search_path TO quiktrip, public")
        yield conn
    finally:
        conn.close()
