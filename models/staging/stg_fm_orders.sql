{{ config(materialized='view') }}

SELECT
    order_id,
    customer_id,
    -- Safely handle microsecond timestamps to convert them to DATE
    CASE
        WHEN TRY_TO_TIMESTAMP_NTZ(CAST(ROUND(order_date) AS BIGINT) / 1000000) IS NOT NULL THEN
            CAST(TO_TIMESTAMP_NTZ(CAST(ROUND(order_date) AS BIGINT) / 1000000) AS DATE)
        ELSE NULL
    END AS order_date,
    CASE
        WHEN TRY_TO_TIMESTAMP_NTZ(CAST(ROUND(shipped_date) AS BIGINT) / 1000000) IS NOT NULL THEN
            CAST(TO_TIMESTAMP_NTZ(CAST(ROUND(shipped_date) AS BIGINT) / 1000000) AS DATE)
        ELSE NULL
    END AS shipped_date,
    ship_via,
    creditcard_id
FROM {{ source('fudgemart', 'fm_orders') }}
