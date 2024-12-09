{{ config(materialized='view') }}

SELECT
    email,
    twitterusername,
    maritalstatus,
    householdincome,
    ownhome,
    education,
    favoritedepartment
FROM {{ source('fudgemart', 'fm_customer_survey') }}
