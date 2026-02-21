Architecture Overview:

- Apache Airflow orchestrates pipeline
- Snowflake serves as cloud-native data warehouse
- RAW schema stores landing data
- CURATED schema stores analytics-ready fact tables
- DQ schema logs validation metrics
- Warehouse configured with auto-suspend for cost optimization