{{ config(materialized='view') }}

SELECT
    employee_id,
    LOWER(employee_firstname) AS employee_firstname, -- Normalize names to lowercase
    LOWER(employee_lastname) AS employee_lastname,
    employee_jobtitle,
    employee_department,
    employee_birthdate,
    CAST(employee_hiredate AS DATE) AS employee_hiredate, -- Ensure proper date format
    CAST(employee_termdate AS DATE) AS employee_termdate,
    employee_hourlywage,
    employee_fulltime,
    employee_supervisor
FROM {{ source('fudgemart', 'fm_employees') }}
