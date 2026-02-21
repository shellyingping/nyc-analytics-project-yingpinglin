
-- Staging model for NYC Open Restaurant Applications (v2)

WITH source_data AS (
    SELECT
        *
    FROM {{ source('raw', 'source_nyc_open_restaurant_apps_v2') }}
)

SELECT *
FROM source_data