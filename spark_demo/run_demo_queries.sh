#!/usr/bin/env bash
# Check that Iceberg table returns one row
$SPARK_HOME/bin/spark-sql -e "SELECT count(*) FROM demo.default.customer;" | grep -q 1
