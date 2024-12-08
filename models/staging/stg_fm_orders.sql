{{ config(materialized='view') }}

SELECT
    order_id,
    customer_id,
    TRY_TO_DATE(TO_TIMESTAMP(order_date / 1000)) AS order_date, -- Converts timestamp to date
    TRY_TO_DATE(TO_TIMESTAMP(shipped_date / 1000)) AS shipped_date, -- Converts timestamp to date
    ship_via,
    creditcard_id
FROM {{ source('fudgemart', 'fm_orders') }}
