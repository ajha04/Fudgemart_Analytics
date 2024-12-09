{{ config(materialized='view') }}

SELECT
    product_id,
    LOWER(product_name) AS product_name, -- Normalize product name to lowercase
    product_department,
    product_retail_price,
    product_wholesale_price,
    product_is_active,
    CAST(product_add_date AS DATE) AS product_add_date, -- Ensure the date is in proper format
    product_vendor_id,
    product_description
FROM {{ source('fudgemart', 'fm_products') }}
