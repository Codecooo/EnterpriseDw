/* Procedure to load datasets into bronze layer along with the timing logs. 
    Also this will delete all data on the tables. Make sure to have datasets
    in the server dir in this case /var/lib/postgresql/import/

    Example usage:
    CALL bronze.load_bronze();
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    op_start   timestamp;
    op_end     timestamp;
    total_start timestamp;
    total_end   timestamp;

    ms numeric(12,3);
BEGIN
    RAISE NOTICE 'Truncating tables...';

    TRUNCATE bronze.crm_cust_info,
             bronze.crm_sales_details,
             bronze.crm_prd_info,
             bronze.erp_px_cat_g1v2,
             bronze.erp_loc_a101,
             bronze.erp_cust_az12;

    total_start := clock_timestamp();

    RAISE NOTICE '-----------------------------';
    RAISE NOTICE '      Loading Bronze Data';
    RAISE NOTICE '-----------------------------';

    RAISE NOTICE '-----------------------------';
    RAISE NOTICE '      Loading CRM';

    -- crm_cust_info
    RAISE NOTICE 'Loading crm_cust_info';
    op_start := clock_timestamp();

    COPY bronze.crm_cust_info
        FROM '/var/lib/postgresql/import/EnterpriseDw/datasets/source_crm/cust_info.csv'
        WITH (FORMAT csv, HEADER true);

    op_end := clock_timestamp();
    ms := EXTRACT(EPOCH FROM (op_end - op_start)) * 1000;
    RAISE NOTICE 'crm_cust_info COPY took % ms', ms;

    -- crm_sales_details
    RAISE NOTICE 'Loading crm_sales_details';
    op_start := clock_timestamp();

    COPY bronze.crm_sales_details
        FROM '/var/lib/postgresql/import/EnterpriseDw/datasets/source_crm/sales_details.csv'
        WITH (FORMAT csv, HEADER true);

    op_end := clock_timestamp();
    ms := EXTRACT(EPOCH FROM (op_end - op_start)) * 1000;
    RAISE NOTICE 'crm_sales_details COPY took % ms', ms;

    -- crm_prd_info
    RAISE NOTICE 'Loading crm_prd_info';
    op_start := clock_timestamp();

    COPY bronze.crm_prd_info
        FROM '/var/lib/postgresql/import/EnterpriseDw/datasets/source_crm/prd_info.csv'
        WITH (FORMAT csv, HEADER true);

    op_end := clock_timestamp();
    ms := EXTRACT(EPOCH FROM (op_end - op_start)) * 1000;
    RAISE NOTICE 'crm_prd_info COPY took % ms', ms;

    RAISE NOTICE '-----------------------------';
    RAISE NOTICE '      Loading ERP Data';

    -- erp_px_cat_g1v2
    RAISE NOTICE 'Loading erp_px_cat_g1v2';
    op_start := clock_timestamp();

    COPY bronze.erp_px_cat_g1v2
        FROM '/var/lib/postgresql/import/EnterpriseDw/datasets/source_erp/PX_CAT_G1V2.csv'
        WITH (FORMAT csv, HEADER true);

    op_end := clock_timestamp();
    ms := EXTRACT(EPOCH FROM (op_end - op_start)) * 1000;
    RAISE NOTICE 'erp_px_cat_g1v2 COPY took % ms', ms;

    -- erp_loc_a101
    RAISE NOTICE 'Loading erp_loc_a101';
    op_start := clock_timestamp();

    COPY bronze.erp_loc_a101
        FROM '/var/lib/postgresql/import/EnterpriseDw/datasets/source_erp/LOC_A101.csv'
        WITH (FORMAT csv, HEADER true);

    op_end := clock_timestamp();
    ms := EXTRACT(EPOCH FROM (op_end - op_start)) * 1000;
    RAISE NOTICE 'erp_loc_a101 COPY took % ms', ms;

    -- erp_cust_az12
    RAISE NOTICE 'Loading erp_cust_az12';
    op_start := clock_timestamp();

    COPY bronze.erp_cust_az12
        FROM '/var/lib/postgresql/import/EnterpriseDw/datasets/source_erp/CUST_AZ12.csv'
        WITH (FORMAT csv, HEADER true);

    op_end := clock_timestamp();
    ms := EXTRACT(EPOCH FROM (op_end - op_start)) * 1000;
    RAISE NOTICE 'erp_cust_az12 COPY took % ms', ms;

    -- TOTAL TIME
    total_end := clock_timestamp();
    ms := EXTRACT(EPOCH FROM (total_end - total_start)) * 1000;

    RAISE NOTICE 'Total bronze load time: % ms', ms;

END;
$$;
