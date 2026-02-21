#!/bin/bash

airflow db migrate

airflow users create \
  --username admin \
  --firstname admin \
  --lastname user \
  --role Admin \
  --email admin@example.com \
  --password admin || true

exec airflow webserver