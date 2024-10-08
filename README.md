# Introduction
Code for the Wealingo language app we demoed during [Confluent Current 2024](https://www.confluent.io/resources/generic/current-2024-recap/).


# Prerequisites

1. A Kafka cluster (we used [Confluent Cloud](https://www.confluent.io/confluent-cloud/))
2. A Weaviate instance (sign up for a free 14-day [sandbox account](https://console.weaviate.cloud/) here)
3. A postgresql database (we used [AWS RDS](https://aws.amazon.com/rds/))
4. CDC set up between the postgresql database and a kafka topic (we used Debezium's [postgresql connector](https://debezium.io/documentation/reference/stable/connectors/postgresql.html))
5. A spark cluster with [spark-connector](https://github.com/weaviate/spark-connector) installed (we used [Databricks](https://www.databricks.com/spark/about))


# Setup

## Setup Backend

## Setup Frontend

## Setup Spark-Connector

Run the [notebook](./spark-connector/wealingo_stream_new_questions.ipynb) located in the spark-connector folder within your Spark cluster to set up streaming DataFrames that read from the Kafka topic and write to your Weaviate instance.