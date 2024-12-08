{{ config(materialized='view') }}

SELECT
    product_id,
    LOWER(product_name) AS product_name,
    product_department,
    product_retail_price,
    product_wholesale_price,
    product_is_active
FROM {{ source('fudgemart', 'fm_products') }}
WHERE product_is_active = 'Y';
