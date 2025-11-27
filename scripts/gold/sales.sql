CREATE VIEW gold.fact_sales AS
    SELECT 
        s.sls_ord_num order_number,
        p.product_key,
        c.customer_key,
        s.sls_order_dt order_date,
        s.sls_ship_dt shipping_date,
        s.sls_due_dt due_date,
        s.sls_sales sales_amount,
        s.sls_quantity quantity,
        s.sls_price price
    FROM silver.crm_sales_details_columnar AS s
        LEFT JOIN gold.dim_products AS p
            ON s.sls_prd_key = p.product_number
        LEFT JOIN gold.dim_customers AS c
            ON s.sls_cust_id = c.customer_id;