-- This is used to create the table for the CRM in silver schema

CREATE TABLE silver.crm_cust_info (
    cst_id              INT,
    cst_key             VARCHAR(50),
    cst_firstname       VARCHAR(50),
    cst_lastname        VARCHAR(50),
    cst_marital_status  VARCHAR(50),
    cst_gender          VARCHAR(50),
    cst_create_date     DATE,
    dwh_created_at      TIMESTAMP DEFAULT now()
);

CALL mooncake.create_table('silver.crm_cust_info_columnar', 'silver.crm_cust_info');

CREATE TABLE silver.crm_sales_details (
    sls_ord_num     VARCHAR(50),
    sls_prd_key     VARCHAR(150),
    sls_cust_id     INT,
    sls_order_dt    DATE,
    sls_ship_dt     DATE,
    sls_due_dt      DATE,
    sls_sales       INT,
    sls_quantity    INT,
    sls_price       INT,
    dwh_created_at  TIMESTAMP DEFAULT now()
);

CALL mooncake.create_table('silver.crm_sales_details_columnar', 'silver.crm_sales_details');

CREATE TABLE silver.crm_prd_info (
    prd_id          INT,
    cat_id          VARCHAR(150),
    prd_key         VARCHAR(150),
    prd_nm          TEXT,
    prd_cost        INT,
    prd_line        VARCHAR(50),
    prd_start_dt    DATE,
    prd_end_dt      DATE,
    dwh_created_at  TIMESTAMP DEFAULT now()
);

CALL mooncake.create_table('silver.crm_prd_info_columnar', 'silver.crm_prd_info');

-- This is used to create the table for the ERP in silver schema

CREATE TABLE silver.erp_px_cat_g1v2 (
    id              VARCHAR(50),
    cat             VARCHAR(50),
    subcat          VARCHAR(50),
    maintenance     VARCHAR(50),
    dwh_created_at  TIMESTAMP DEFAULT now()
);

CALL mooncake.create_table('silver.erp_px_cat_g1v2_columnar', 'silver.erp_px_cat_g1v2');

CREATE TABLE silver.erp_loc_a101 (
    cid             TEXT,
    cntry           VARCHAR(150),
    dwh_created_at  TIMESTAMP DEFAULT now()
);

CALL mooncake.create_table('silver.erp_loc_a101_columnar', 'silver.erp_loc_a101');

CREATE TABLE silver.erp_cust_az12 (
    cid             TEXT,
    bdate           DATE,
    gen             VARCHAR(50),
    dwh_created_at  TIMESTAMP DEFAULT now()
);

CALL mooncake.create_table('silver.erp_cust_az12_columnar', 'silver.erp_cust_az12');