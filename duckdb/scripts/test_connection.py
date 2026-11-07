import duckdb

conn = duckdb.connect("db/dump.duckdb")

result = conn.execute("""
SELECT
    'SQL Prep' AS project,
    2 + 2 AS result
""").fetchall()

print(result)

conn.close()
