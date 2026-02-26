-- Fact table: Open Restaurant Applications
-- Grain: one row per application

WITH apps AS (
  SELECT *
  FROM {{ ref('stg_nyc_open_restaurant_apps') }}
)

SELECT
  -- Surrogate key
  TO_HEX(MD5(TO_JSON_STRING(STRUCT(apps.*)))) AS restaurant_application_sk,

  
  NULL AS date_key,
  NULL AS location_key,

  apps.*
FROM apps