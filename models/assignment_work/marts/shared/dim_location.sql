{{ config(schema='nyc_transit_restaurants_marts') }}

WITH locs AS (
  SELECT DISTINCT
    COALESCE(borough, 'UNKNOWN or CITYWIDE') AS borough,
    incident_zip
  FROM {{ ref('stg_nyc_311_dot') }}
)

SELECT
  TO_HEX(MD5(CONCAT(COALESCE(borough, ''), '|', COALESCE(incident_zip, '')))) AS location_key,
  borough,
  incident_zip
FROM locs