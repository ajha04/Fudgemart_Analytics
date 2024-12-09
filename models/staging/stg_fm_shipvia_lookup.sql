{{ config(materialized='view') }}

SELECT
    ship_via
FROM {{ source('fudgemart', 'fm_shipvia_lookup') }}
