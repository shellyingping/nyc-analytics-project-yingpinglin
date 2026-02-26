{{ config(schema='nyc_transit_restaurants_marts') }}

WITH apps AS (
  SELECT *
  FROM {{ ref('stg_nyc_open_restaurant_apps') }}
)

SELECT
  CAST(FARM_FINGERPRINT(TO_JSON_STRING(apps)) AS STRING) AS restaurant_application_sk,
  CAST(NULL AS STRING) AS date_key,
  CAST(NULL AS STRING) AS location_key,
  apps.*
FROM apps