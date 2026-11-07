import duckdb

conn = duckdb.connect("db/dump.duckdb")

print("Database created successfully")

conn.close()
