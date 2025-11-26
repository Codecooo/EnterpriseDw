EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF)
INSERT INTO silver.erp_px_cat_g1v2 (
    id,
    cat,
    subcat,
    maintenance
)

SELECT * FROM bronze.erp_px_cat_g1v2;

-- Quality check

-- Final
SELECT * FROM silver.erp_px_cat_g1v2 LIMIT 10;