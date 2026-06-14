SELECT
    city_id,
    city_name,
    country,
    region,
    timezone,
    is_active,
    launched_date

FROM {{ source('raw', 'cities') }}

WHERE city_id IS NOT NULL