{{ config(materialized='view') }}

SELECT
    order_id,
    customer_id,
    -- Convert valid numeric timestamps to DATE
    CASE
        WHEN TRY_TO_TIMESTAMP(CAST(ROUND(order_date, 0) AS BIGINT) / 1000) IS NOT NULL THEN
            TRY_TO_DATE(TO_TIMESTAMP_NTZ(CAST(ROUND(order_date, 0) AS BIGINT) / 1000))
        ELSE NULL -- Replace invalid or non-numeric values with NULL
    END AS order_date,
    CASE
        WHEN TRY_TO_TIMESTAMP(CAST(ROUND(shipped_date, 0) AS BIGINT) / 1000) IS NOT NULL THEN
            TRY_TO_DATE(TO_TIMESTAMP_NTZ(CAST(ROUND(shipped_date, 0) AS BIGINT) / 1000))
        ELSE NULL
    END AS shipped_date,
    ship_via,
    creditcard_id
FROM {{ source('fudgemart', 'fm_orders') }}
