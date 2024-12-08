{{ config(materialized='view') }}

SELECT
    order_id,
    product_id,
    order_qty
FROM {{ source('fudgemart', 'fm_order_details') }}
