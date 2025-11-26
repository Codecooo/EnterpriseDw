-- The helper SQL for auto load the data from other SQL scripts. Make sure to use psql client

\echo Truncating tables...

TRUNCATE silver.crm_cust_info, silver.crm_sales_details, silver.crm_prd_info, silver.erp_px_cat_g1v2, silver.erp_loc_a101, silver.erp_cust_az12;

\echo Loading and cleansing data into crm_cust_info
\i load_silver_cust_info.sql
\echo Load complete for crm_cust_info

\echo Loading and cleansing data into crm_sales_details
\i load_silver_sales_details.sql
\echo Load complete for crm_sales_details

\echo Loading and cleansing data into crm_prd_info
\i load_silver_prd_info.sql
\echo Load complete for crm_prd_info

\echo Loading and cleansing data into erp_px_cat_g1v2
\i load_silver_px_cat_g1v2.sql
\echo Load complete for erp_px_cat_g1v2

\echo Loading and cleansing data into erp_cust_az12
\i load_silver_cust_az12.sql
\echo Load complete for erp_cust_az12

\echo Loading and cleansing data into erp_loc_a101
\i load_silver_loc_a101.sql
\echo Load complete for erp_loc_a101

\echo Load and cleansing for silver layer has completed