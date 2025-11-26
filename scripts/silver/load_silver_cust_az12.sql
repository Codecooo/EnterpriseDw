EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF)
INSERT INTO silver.erp_cust_az12 (
    cid,
    bdate,
    gen
)

SELECT 
    -- Remove the NAS in starting ID 
    CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LENGTH(cid))
        ELSE cid
    END AS cid,

    -- If bdate is in the future set it to null
    CASE WHEN bdate > now() THEN NULL
        ELSE bdate
    END AS bdate,

    CASE WHEN LOWER(TRIM(gen)) IN ('f', 'female') THEN 'Female'
         WHEN LOWER(TRIM(gen)) IN ('m', 'male') THEN 'Male'
         ELSE 'n/a'
    END AS gen

FROM bronze.erp_cust_az12;

-- Quality check

-- Check if there is more key staart with NAS
SELECT cid FROM silver.erp_cust_az12
WHERE cid LIKE 'NAS%';

-- Check if there is an invalid dates
SELECT bdate FROM silver.erp_cust_az12
WHERE bdate > now();

SELECT DISTINCT gen FROM silver.erp_cust_az12;

-- Final
SELECT * FROM silver.erp_cust_az12 LIMIT 10;