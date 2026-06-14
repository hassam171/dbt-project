{{
    config(
        materialized = 'table'
    )
}}

WITH date_spine AS (
    SELECT
        DATEADD(day, seq4(), '2024-01-01'::DATE) AS date_day
    FROM TABLE(GENERATOR(ROWCOUNT => 366))
)

SELECT
    date_day                              AS date_id,
    date_day                              AS full_date,
    DAYOFMONTH(date_day)                  AS day_of_month,
    DAYOFWEEK(date_day)                   AS day_of_week,
    DAYNAME(date_day)                     AS day_name,
    WEEKOFYEAR(date_day)                  AS week_number,
    MONTH(date_day)                       AS month_number,
    MONTHNAME(date_day)                   AS month_name,
    QUARTER(date_day)                     AS quarter,
    'Q' || QUARTER(date_day)              AS quarter_name,
    YEAR(date_day)                        AS year,
    CASE 
        WHEN DAYOFWEEK(date_day) IN (0, 6) THEN TRUE 
        ELSE FALSE 
    END                                    AS is_weekend

FROM date_spine
WHERE date_day <= '2024-12-31'::DATE