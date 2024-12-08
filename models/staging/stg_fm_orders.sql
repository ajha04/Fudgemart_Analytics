{{ config(materialized='view') }}

SELECT
    order_id,
    customer_id,
    TO_DATE(order_date, 'YYYY-MM-DD') AS order_date,
    TO_DATE(shipped_date, 'YYYY-MM-DD') AS shipped_date,
    ship_via,
    creditcard_id
FROM {{ source('fudgemart', 'fm_orders') }}
