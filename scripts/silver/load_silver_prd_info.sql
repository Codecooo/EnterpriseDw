EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF)

INSERT INTO silver.crm_prd_info (
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)

SELECT 
    prd_id,
    -- Extract the id of the category from prd_key the length 1 to 5
    REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
    -- Extract the rest as prd_key
    SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key,
    prd_nm,

    COALESCE(prd_cost, 0) AS prd_cost,

    CASE LOWER(TRIM(prd_line))
        WHEN 'm' THEN 'Mountain'
        WHEN 'r' THEN 'Road'
        WHEN 's' THEN 'Other Sales'
        WHEN 't' THEN 'Touring'
        ELSE 'n/a'
    END AS prd_line,

    -- Cast the timestamp to Date and chose the end_date based on the next start date - 1
    prd_start_dt::DATE AS prd_start_dt,
    CAST(
        LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)
        - INTERVAL '1 day'
    AS DATE) AS prd_end_dt

FROM bronze.crm_prd_info;

-- Quality check

-- Final
SELECT * FROM silver.crm_prd_info LIMIT 10;