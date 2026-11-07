from pathlib import Path
import duckdb

# -----------------------------------------------------
# Paths
# -----------------------------------------------------

ROOT = Path(__file__).resolve().parent.parent

DB_PATH = ROOT / "db" / "dump.duckdb"
DATA_PATH = ROOT / "resources" / "data"

# -----------------------------------------------------
# Connect
# -----------------------------------------------------

print(f"Connecting to: {DB_PATH}")

conn = duckdb.connect(str(DB_PATH))

tables = [
    "patients",
    "providers",
    "appointments",
    "claims",
    "diagnoses",
    "migrations"
]

# -----------------------------------------------------
# Drop Existing Tables
# -----------------------------------------------------

print("\nDropping existing tables...")

for table in tables:
    conn.execute(f"DROP TABLE IF EXISTS {table}")

# -----------------------------------------------------
# Load CSVs
# -----------------------------------------------------

print("\nLoading CSV files...")

for table in tables:

    csv_path = DATA_PATH / f"{table}.csv"

    print(f"Loading {table}...")

    conn.execute(f"""
        CREATE TABLE {table} AS
        SELECT *
        FROM read_csv_auto('{csv_path.as_posix()}')
    """)

# -----------------------------------------------------
# Validation
# -----------------------------------------------------

print("\nRow Counts")
print("-" * 40)

for table in tables:

    count = conn.execute(
        f"SELECT COUNT(*) FROM {table}"
    ).fetchone()[0]

    print(f"{table:<15} {count:>10}")

# -----------------------------------------------------
# Data Quality Checks
# -----------------------------------------------------

print("\nData Quality Summary")
print("-" * 40)

duplicate_emails = conn.execute("""
SELECT COUNT(*)
FROM (
    SELECT email
    FROM patients
    GROUP BY email
    HAVING COUNT(*) > 1
)
""").fetchone()[0]

missing_phone_numbers = conn.execute("""
SELECT COUNT(*)
FROM patients
WHERE phone IS NULL
""").fetchone()[0]

cancelled_appointments = conn.execute("""
SELECT COUNT(*)
FROM appointments
WHERE status = 'Cancelled'
""").fetchone()[0]

failed_migrations = conn.execute("""
SELECT COUNT(*)
FROM migrations
WHERE status = 'FAILED'
""").fetchone()[0]

print(f"Duplicate Emails      : {duplicate_emails}")
print(f"Missing Phone Numbers : {missing_phone_numbers}")
print(f"Cancelled Appointments: {cancelled_appointments}")
print(f"Failed Migrations     : {failed_migrations}")

# -----------------------------------------------------
# Sample Join Validation
# -----------------------------------------------------

print("\nSample Join Validation")
print("-" * 40)

result = conn.execute("""
SELECT
    p.patient_id,
    p.first_name,
    COUNT(a.appointment_id) AS appointment_count
FROM patients p
LEFT JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id,
    p.first_name
ORDER BY appointment_count DESC
LIMIT 5
""").fetchall()

for row in result:
    print(row)

conn.close()

print("\nLoad completed successfully.")
