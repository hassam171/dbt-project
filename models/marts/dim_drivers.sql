SELECT
    d.driver_id,
    d.driver_name,
    d.tier,
    d.vehicle_type,
    d.join_date,
    d.is_active            AS is_active_driver,

    -- Enriched from cities
    c.city_name,
    c.country,
    c.region,
    c.timezone

FROM {{ ref('stg_drivers') }} d
LEFT JOIN {{ ref('stg_cities') }} c
    ON d.city_id = c.city_id