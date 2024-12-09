{{ config(materialized='view') }}

SELECT
    timesheet_id,
    CAST(timesheet_payrolldate AS DATE) AS timesheet_payrolldate, -- Normalize to DATE
    timesheet_hourlyrate,
    timesheet_employee_id,
    timesheet_hours
FROM {{ source('fudgemart', 'fm_employee_timesheets') }}
