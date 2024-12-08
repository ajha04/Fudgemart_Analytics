{{ config(materialized='view') }}

SELECT
    order_id,
    customer_id,
    TRY_TO_DATE(CAST(TO_TIMESTAMP(order_date / 1000) AS DATE)) AS order_date, -- Cast to DATE
    TRY_TO_DATE(CAST(TO_TIMESTAMP(shipped_date / 1000) AS DATE)) AS shipped_date, -- Cast to DATE
    ship_via,
    creditcard_id
FROM {{ source('fudgemart', 'fm_orders') }}
