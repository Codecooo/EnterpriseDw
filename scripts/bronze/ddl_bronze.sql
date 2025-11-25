-- This is used to create the table for the CRM in bronze schema

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             VARCHAR(50),
    cst_firstname       VARCHAR(50),
    cst_lastname        VARCHAR(50),
    cst_material_status VARCHAR(50),
    cst_gender          VARCHAR(50),
    cst_create_date     DATE
);

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num     VARCHAR(50),
    sls_prd_key     VARCHAR(150),
    sls_cust_id     INT,
    sls_order_dt    INT,
    sls_ship_dt     INT,
    sls_due_dt      INT,
    sls_sales       INT,
    sls_quantity    INT,
    sls_price       INT
);

CREATE TABLE bronze.crm_prd_info (
    prd_id          INT,
    prd_key         VARCHAR(150),
    prd_nm          TEXT,
    prd_cost        INT,
    prd_line        CHAR(1),
    prd_start_dt    TIMESTAMP,
    prd_end_dt      TIMESTAMP
);

-- This is used to create the table for the ERP in bronze schema

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           VARCHAR(50),
    cat          VARCHAR(50),
    subcat       VARCHAR(50),
    maintenance  VARCHAR(50)
);

CREATE TABLE bronze.erp_loc_a101 (
    cid         TEXT,
    cntry       VARCHAR(150)
);

CREATE TABLE bronze.erp_cust_az12 (
    cid         TEXT,
    bdate       DATE,
    gen         VARCHAR(50)
);