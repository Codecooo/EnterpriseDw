EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF)

INSERT INTO silver.crm_sales_details (
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
)

SELECT 
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,

    -- For sales ord_dt, sls_ship_dt, sls_due_dt if they are not valid date the its null if not cast it to DATE
    CASE WHEN sls_order_dt = 0 OR LENGTH(sls_order_dt::TEXT) != 8 THEN NULL
        ELSE TO_DATE(sls_order_dt::VARCHAR, 'YYYYMMDD')
    END AS sls_order_dt,

    CASE WHEN sls_ship_dt = 0 OR LENGTH(sls_ship_dt::TEXT) != 8 THEN NULL
        ELSE TO_DATE(sls_ship_dt::VARCHAR, 'YYYYMMDD')
    END AS sls_ship_dt,

    CASE WHEN sls_due_dt = 0 OR LENGTH(sls_due_dt::TEXT) != 8 THEN NULL
        ELSE TO_DATE(sls_due_dt::VARCHAR, 'YYYYMMDD')
    END AS sls_due_dt,

    /* For sales and price if the sales is null or empty or wrong then calculate it by quantity times
        price with absolute number. for price if its null or zero find the value by divide the sales to quantity
        if the quantity is 0 then its null. Also if the price is negative turn it into positive
    */
    CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
        THEN sls_quantity * ABS(sls_price)
        ELSE sls_sales
    END AS sls_sales,

    sls_quantity,

    CASE WHEN sls_price IS NULL OR sls_price <= 0
        THEN sls_sales / NULLIF(sls_quantity, 0)
        ELSE sls_price
    END AS sls_price

FROM bronze.crm_sales_details;

-- Quality check

-- Final
SELECT * FROM silver.crm_sales_details LIMIT 10;