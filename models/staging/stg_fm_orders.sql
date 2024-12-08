{{ config(materialized='view') }}

SELECT
    order_id,
    customer_id,
    -- Handle valid numeric timestamps, nulls, and invalid values
    CASE
        WHEN TRY_TO_TIMESTAMP(order_date / 1000) IS NOT NULL THEN
            TRY_TO_DATE(TO_TIMESTAMP_NTZ(order_date / 1000))
        ELSE NULL -- Replace invalid or non-numeric values with NULL
    END AS order_date,
    CASE
        WHEN TRY_TO_TIMESTAMP(shipped_date / 1000) IS NOT NULL THEN
            TRY_TO_DATE(TO_TIMESTAMP_NTZ(shipped_date / 1000))
        ELSE NULL
    END AS shipped_date,
    ship_via,
    creditcard_id
FROM {{ source('fudgemart', 'fm_orders') }}
