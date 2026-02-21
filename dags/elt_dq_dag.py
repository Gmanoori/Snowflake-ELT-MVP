from airflow import DAG
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
from datetime import datetime

with DAG(
    dag_id="snowflake_elt_dq",
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False
) as dag:

    create_tables = SnowflakeOperator(
        task_id="create_tables",
        sql="/opt/airflow/sql/create_tables.sql",
        snowflake_conn_id="snowflake_default"
    )

    transform = SnowflakeOperator(
        task_id="transform",
        sql="/opt/airflow/sql/transform.sql",
        snowflake_conn_id="snowflake_default"
    )

    create_tables >> transform