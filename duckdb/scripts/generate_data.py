from pathlib import Path
from faker import Faker
import pandas as pd
import random
from datetime import datetime, timedelta

fake = Faker()

# -----------------------------------------------------
# Paths
# -----------------------------------------------------

ROOT = Path(__file__).resolve().parent.parent

DATA_DIR = ROOT / "resources" / "data"

DATA_DIR.mkdir(parents=True, exist_ok=True)

random.seed(42)

# -----------------------------------------------------
# Patients
# -----------------------------------------------------

patients = []

for pid in range(1, 101):

    gender = random.choice(["Male", "Female"])

    patients.append({
        "patient_id": pid,
        "first_name": fake.first_name(),
        "last_name": fake.last_name(),
        "gender": gender,
        "dob": fake.date_between(
            start_date="-80y",
            end_date="-18y"
        ),
        "email": fake.email(),
        "phone": fake.msisdn()[:10],
        "city": fake.city(),
        "created_date": fake.date_between(
            start_date="-3y",
            end_date="today"
        )
    })

# introduce duplicates

patients[95]["email"] = patients[10]["email"]
patients[96]["email"] = patients[10]["email"]

# missing values

patients[97]["phone"] = None
patients[98]["phone"] = None

patients_df = pd.DataFrame(patients)

# -----------------------------------------------------
# Providers
# -----------------------------------------------------

specialties = [
    "Cardiology",
    "Dermatology",
    "Neurology",
    "Orthopedics",
    "Pediatrics",
    "Family Medicine",
    "Internal Medicine"
]

providers = []

for provider_id in range(1, 21):

    providers.append({
        "provider_id": provider_id,
        "provider_name": fake.name(),
        "specialty": random.choice(specialties),
        "location": fake.city()
    })

providers_df = pd.DataFrame(providers)

# -----------------------------------------------------
# Appointments
# -----------------------------------------------------

statuses = [
    "Completed",
    "Cancelled",
    "Scheduled",
    "No Show"
]

appointments = []

for appointment_id in range(1, 1001):

    appointments.append({
        "appointment_id": appointment_id,
        "patient_id": random.randint(1, 100),
        "provider_id": random.randint(1, 20),
        "appointment_date":
            datetime.today()
            - timedelta(days=random.randint(1, 730)),
        "status": random.choice(statuses),
        "duration_minutes": random.choice(
            [15, 30, 45, 60]
        )
    })

appointments_df = pd.DataFrame(appointments)

# -----------------------------------------------------
# Claims
# -----------------------------------------------------

claim_statuses = [
    "Paid",
    "Pending",
    "Rejected"
]

claims = []

for claim_id in range(1, 501):

    amount = round(random.uniform(100, 5000), 2)

    claims.append({
        "claim_id": claim_id,
        "patient_id": random.randint(1, 100),
        "appointment_id": random.randint(1, 1000),
        "claim_amount": amount,
        "paid_amount":
            amount
            if random.random() > 0.25
            else round(amount * random.uniform(0, 1), 2),
        "claim_status": random.choice(claim_statuses)
    })

claims_df = pd.DataFrame(claims)

# -----------------------------------------------------
# Diagnoses
# -----------------------------------------------------

icd_codes = [
    "I10",
    "E11",
    "J45",
    "M54",
    "K21",
    "F41"
]

diagnoses = []

for diagnosis_id in range(1, 801):

    diagnoses.append({
        "diagnosis_id": diagnosis_id,
        "patient_id": random.randint(1, 100),
        "icd_code": random.choice(icd_codes),
        "diagnosis_date":
            datetime.today()
            - timedelta(days=random.randint(1, 1000))
    })

diagnoses_df = pd.DataFrame(diagnoses)

# -----------------------------------------------------
# Migrations
# -----------------------------------------------------

migration_status = [
    "SUCCESS",
    "FAILED",
    "PARTIAL"
]

migrations = []

for migration_id in range(1, 151):

    source_count = random.randint(1000, 5000)

    target_count = source_count - random.randint(0, 50)

    migrations.append({
        "migration_id": migration_id,
        "source_system":
            random.choice(
                ["LegacyEHR", "PracticeFusion", "CustomEMR"]
            ),
        "source_record_count": source_count,
        "target_record_count": target_count,
        "status": random.choice(migration_status)
    })

migrations_df = pd.DataFrame(migrations)

# -----------------------------------------------------
# Write CSVs
# -----------------------------------------------------

patients_df.to_csv(
    DATA_DIR / "patients.csv",
    index=False
)

providers_df.to_csv(
    DATA_DIR / "providers.csv",
    index=False
)

appointments_df.to_csv(
    DATA_DIR / "appointments.csv",
    index=False
)

claims_df.to_csv(
    DATA_DIR / "claims.csv",
    index=False
)

diagnoses_df.to_csv(
    DATA_DIR / "diagnoses.csv",
    index=False
)

migrations_df.to_csv(
    DATA_DIR / "migrations.csv",
    index=False
)

print("CSV files generated successfully.")
