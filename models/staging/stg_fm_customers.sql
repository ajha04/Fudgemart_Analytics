{{ config(materialized='view') }}

SELECT
    customer_id,
    LOWER(customer_firstname) AS customer_firstname,
    LOWER(customer_lastname) AS customer_lastname,
    customer_email,
    customer_address,
    customer_city,
    customer_state,
    customer_zip,
    customer_phone
FROM {{ source('fudgemart', 'fm_customers') }}
