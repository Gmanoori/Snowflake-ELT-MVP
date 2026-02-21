CREATE OR REPLACE TABLE CURATED.FACT_ORDERS AS
SELECT
  order_id,
  customer_id,
  order_date,
  amount,
  status,
  CURRENT_TIMESTAMP() AS loaded_at
FROM RAW.ORDERS_RAW;