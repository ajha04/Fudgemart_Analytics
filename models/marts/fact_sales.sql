{{ config(materialized='table') }}

SELECT
    o.order_id,
    o.customer_id,
    c.customer_firstname || ' ' || c.customer_lastname AS customer_name,
    od.product_id,
    p.product_name,
    SUM(od.order_qty * p.product_retail_price) AS total_sales,
    SUM(od.order_qty) AS total_quantity,
    o.order_date
FROM {{ ref('stg_fm_orders') }} o
JOIN {{ ref('stg_fm_order_details') }} od
    ON o.order_id = od.order_id
JOIN {{ ref('stg_fm_products') }} p
    ON od.product_id = p.product_id
JOIN {{ ref('stg_fm_customers') }} c
    ON o.customer_id = c.customer_id
GROUP BY
    o.order_id, o.customer_id, c.customer_firstname, c.customer_lastname,
    od.product_id, p.product_name, o.order_date
