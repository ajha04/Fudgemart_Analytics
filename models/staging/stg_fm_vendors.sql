{{ config(materialized='view') }}

SELECT
    vendor_id,
    LOWER(vendor_name) AS vendor_name, -- Normalize vendor name
    vendor_phone,
    vendor_website
FROM {{ source('fudgemart', 'fm_vendors') }}
