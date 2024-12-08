{{ config(materialized='view') }}

SELECT
    order_id,
    customer_id,
    -- Convert microsecond timestamps to DATE
    CASE
        WHEN order_date >= 0 THEN
            CAST(TO_TIMESTAMP_NTZ(CAST(order_date / 1000000 AS BIGINT)) AS DATE)
        ELSE NULL -- Replace invalid or negative values with NULL
    END AS order_date,
    CASE
        WHEN shipped_date >= 0 THEN
            CAST(TO_TIMESTAMP_NTZ(CAST(shipped_date / 1000000 AS BIGINT)) AS DATE)
        ELSE NULL
    END AS shipped_date,
    ship_via,
    creditcard_id
FROM {{ source('fudgemart', 'fm_orders') }}
