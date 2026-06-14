SELECT
    driver_id,
    driver_name,
    city_id,
    tier,
    join_date,
    is_active,
    vehicle_type

FROM {{ source('raw', 'drivers') }}

WHERE driver_id IS NOT NULL