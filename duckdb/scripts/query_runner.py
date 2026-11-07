from pathlib import Path
import duckdb
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent

DB_PATH = ROOT / "db" / "dump.duckdb"

conn = duckdb.connect(str(DB_PATH))

query = """
SELECT * FROM
claims
"""

df = conn.execute(query).df()

print(df)

conn.close()
