SELECT
    -- Foreign keys (link to dimensions)
    pickup_zone_id,
    dropoff_zone_id,
    payment_type_id,

    -- Time fields
    pickup_datetime,
    dropoff_datetime,
    CAST(pickup_datetime AS DATE)      AS trip_date,
    HOUR(pickup_datetime)              AS hour_of_day,

    -- Calculated measures
    DATEDIFF('minute', pickup_datetime, dropoff_datetime) 
                                        AS trip_duration_mins,
    ROUND(distance_miles * 1.60934, 2) AS distance_km,
    distance_miles,
    passenger_count,

    -- Financial measures
    fare_amount,
    tip_amount,
    tolls_amount,
    total_amount,

    -- Business logic: status
    CASE 
        WHEN total_amount > 0 THEN 'completed'
        ELSE 'cancelled'
    END AS status

FROM {{ ref('stg_trips') }}