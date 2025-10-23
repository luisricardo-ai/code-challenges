-- # =================================================================
-- # 13. Find COVID Recovery Patients
-- # Diff: medium
-- # link: https://leetcode.com/problems/find-covid-recovery-patients/description/
-- # =================================================================

WITH cte_first_positive AS (
    SELECT patient_id, MIN(test_date) AS first_positive_date
    FROM covid_tests
    WHERE result = "Positive"
    GROUP BY patient_id
), cte_first_negative_after_positive AS (
    SELECT ct.patient_id, MIN(test_date) AS first_negative_date
    FROM covid_tests AS ct
    INNER JOIN cte_first_positive AS fp
        ON fp.patient_id = ct.patient_id
        AND fp.first_positive_date < ct.test_date
    WHERE ct.result = "Negative"
    GROUP BY ct.patient_id
)SELECT
    p.patient_id,
    p.patient_name,
    p.age,
    DATEDIFF(fn.first_negative_date ,fp.first_positive_date) AS recovery_time
FROM cte_first_positive AS fp
INNER JOIN cte_first_negative_after_positive AS fn
    ON fp.patient_id = fn.patient_id
INNER JOIN patients AS p
    ON p.patient_id = fp.patient_id
ORDER BY 
    recovery_time ASC,
    p.patient_name ASC
;