CREATE VIEW gold.dim_products AS
    SELECT 
        ROW_NUMBER() OVER (ORDER BY prd_id) AS product_key,
        pd.prd_id product_id,
        pd.prd_key product_number,
        pd.prd_nm product_name,
        pd.cat_id category_id,
        pc.cat category,
        pc.subcat subcategory,
        pc.maintenance maintenance,
        pd.prd_cost cost,
        pd.prd_line product_line,
        pd.prd_start_dt start_date
    FROM silver.crm_prd_info_columnar AS pd 
        LEFT JOIN silver.erp_px_cat_g1v2_columnar AS pc
            ON pd.cat_id = pc."id"
    WHERE pd.prd_end_dt IS NULL; -- Filter out the product that has ended