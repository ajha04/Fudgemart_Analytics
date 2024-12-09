{{ config(materialized='view') }}

SELECT
    order_id,
    customer_id,
    -- Convert microsecond timestamps to DATE
    CASE
        WHEN TRY_TO_TIMESTAMP_NTZ(CAST(order_date AS BIGINT) / 1000000) IS NOT NULL THEN
            CAST(TO_TIMESTAMP_NTZ(CAST(order_date AS BIGINT) / 1000000) AS DATE)
        ELSE NULL
    END AS order_date,
    CASE
        WHEN TRY_TO_TIMESTAMP_NTZ(CAST(shipped_date AS BIGINT) / 1000000) IS NOT NULL THEN
            CAST(TO_TIMESTAMP_NTZ(CAST(shipped_date AS BIGINT) / 1000000) AS DATE)
        ELSE NULL
    END AS shipped_date,
    ship_via,
    creditcard_id
FROM {{ source('fudgemart', 'fm_orders') }}
