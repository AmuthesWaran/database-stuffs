-- Tables:
appointments
claims
diagnoses
migrations
patients
providers

-- Find all patients whose phone number is missing:
SELECT patient_id, first_name, last_name, phone
FROM patients 
WHERE phone is NULL


-- Find all duplicate email addresses.
SELECT email, COUNT(*) as email_count
FROM patients
GROUP BY email
HAVING COUNT(*)  > 1

-- Find the Top 5 patients with the highest number of appointments.
SELECT patient_id, count(*) AS appointment_count
FROM appointments
GROUP BY patient_id
ORDER BY appointment_count desc
LIMIT 5

-- Find the number of appointments handled by each provider.
SELECT p.provider_id, p.provider_name, count(appointment_id) as appointment_count
FROM providers p 
JOIN appointments a ON a.provider_id = p.provider_id
GROUP BY p.provider_id, p.provider_name
ORDER BY appointment_count DESC

-- Find all claims where the patient still owes money.
WITH claim_balance AS (
    SELECT claim_id,
           patient_id,
           claim_amount,
           paid_amount,
           claim_amount - paid_amount AS outstanding_amount
    FROM claims
)
SELECT *
FROM claim_balance
WHERE outstanding_amount > 0
ORDER BY outstanding_amount DESC;

-- or

SELECT claim_id, patient_id, claim_amount, paid_amount, (claim_amount - paid_amount) AS outstanding_amount
FROM claims
WHERE (claim_amount - paid_amount) > 0
ORDER BY outstanding_amount DESC

-- For each patient, return only their most recent diagnosis.
WITH ranked_diagnoses AS (
    SELECT
    *,
    ROW_NUMBER() OVER (
        PARTITION BY patient_id
        ORDER BY diagnosis_date DESC
    ) AS rn
FROM diagnoses
)
SELECT
    patient_id,
    diagnosis_id,
    icd_code,
    diagnosis_date
FROM ranked_diagnoses
WHERE rn = 1;

-- Find the patient with the second highest total claim amount.
