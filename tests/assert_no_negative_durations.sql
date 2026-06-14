-- This test PASSES if it returns ZERO rows
-- It FAILS if it finds any trips with 
-- negative duration (dropoff before pickup —
-- a data quality issue)

SELECT
    pickup_datetime,
    dropoff_datetime,
    trip_duration_mins
FROM {{ ref('fct_trips') }}
WHERE trip_duration_mins < 0