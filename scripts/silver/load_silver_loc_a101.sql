EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF)

INSERT INTO silver.erp_loc_a101 (
    cid,
    cntry
)

SELECT 
    -- Replace the - so we could join the table later
    REPLACE(cid, '-', '') cid,

    -- Make sure the country names is consistent to the normal country names
    CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
         WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
         WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
         ELSE TRIM(cntry)
    END AS cntry

FROM bronze.erp_loc_a101;

-- Quality check

-- Check if there is dashes on the id
SELECT cid AS dashes FROM silver.erp_loc_a101
WHERE cid LIKE '%-%';

-- Check the consistency of country names
SELECT DISTINCT cntry FROM silver.erp_loc_a101;

-- Final
SELECT * FROM silver.erp_loc_a101 LIMIT 10;