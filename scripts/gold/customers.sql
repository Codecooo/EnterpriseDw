CREATE VIEW gold.dim_customers AS
    SELECT 
        ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
        ci.cst_id customer_id,
        ci.cst_key customer_number,
        ci.cst_firstname firstname,
        ci.cst_lastname lastname,
        cl.cntry country,

        -- Took the gender data from CRM otherwise take from ERP
        CASE WHEN ci.cst_gender != 'n/a' THEN ci.cst_gender
            ELSE COALESCE(ca.gen, 'n/a')
        END AS gender,

        ci.cst_marital_status marital_status,
        ca.bdate birthdate,
        ci.cst_create_date create_date
    FROM silver.crm_cust_info_columnar AS ci 
            LEFT JOIN silver.erp_cust_az12_columnar AS ca 
                ON ca.cid = ci.cst_key
            LEFT JOIN silver.erp_loc_a101_columnar AS cl
                ON cl.cid = ci.cst_key;