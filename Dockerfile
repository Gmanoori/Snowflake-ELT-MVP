FROM apache/airflow:2.8.1

USER airflow

RUN pip install --no-cache-dir apache-airflow-providers-snowflake

COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

# USER airflow