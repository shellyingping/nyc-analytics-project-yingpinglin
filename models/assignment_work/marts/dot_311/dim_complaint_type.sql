{{ config(schema='nyc_transit_restaurants_marts') }}

WITH c AS (
  SELECT DISTINCT
    COALESCE(complaint_type, 'UNKNOWN') AS complaint_type,
    COALESCE(descriptor, 'UNKNOWN') AS descriptor
  FROM {{ ref('stg_nyc_311_dot') }}
)

SELECT
  TO_HEX(MD5(CONCAT(complaint_type, '|', descriptor))) AS complaint_type_key,
  complaint_type,
  descriptor
FROM c