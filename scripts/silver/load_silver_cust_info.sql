EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF)

INSERT INTO silver.crm_cust_info (
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gender,
    cst_create_date
)

SELECT 
    cst_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,

    CASE
        WHEN LOWER(TRIM(cst_marital_status)) = 's' THEN 'Single'
        WHEN LOWER(TRIM(cst_marital_status)) = 'm' THEN 'Married'
        ELSE 'n/a'
    END AS cst_marital_status,
    CASE
        WHEN LOWER(TRIM(cst_gender)) = 'f' THEN 'Female'
        WHEN LOWER(TRIM(cst_gender)) = 'm' THEN 'Male'
        ELSE 'n/a'
    END AS cst_gender,
    cst_create_date

FROM (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_latest
    FROM bronze.crm_cust_info
    WHERE cst_id IS NOT NULL
) t
WHERE flag_latest = 1;

-- Quality check

-- Check duplicates
SELECT cst_id, COUNT(*) AS instances
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check trailing characters
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

-- Standardization Data
SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info;

SELECT DISTINCT cst_gender
FROM silver.crm_cust_info;

-- Final
SELECT * FROM silver.crm_cust_info LIMIT 10;