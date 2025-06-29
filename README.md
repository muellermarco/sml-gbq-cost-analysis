# 📊 AtScale Cost Analysis

This project integrates **AtScale** with **Google BigQuery** to enable enhanced analytics and querying capabilities based on consumptions on your data plattform. It includes extraction of AtScale query logs and BigQuery Information Schema exports.

---

## 🚀 Features

- Extracts AtScale Query logs and stores in GBQ as a table
- Extracts GBQ information schema records to allow connect to AtScale Query logs
- Supports environment-based configuration
- Uses secure service account integration
---

## 🐍 Notebooks


You will find two files in the Notebooks folder:

**Notebooks/Extract AtScale Logs.ipynb**

This is designed to read the AtScale logs via REST API and save them to a BigQuery table. The routine loads the entries incrementally so that only queries since the last load are reloaded. The notebook can thus be executed regularly in BigQuery using a scheduler.

**Notebooks/Extract GBQ Information Schema Logs.ipynb**

The second notebook is intended for use when there is no direct access to the Information Schema table. An extract via CSV can be imported into a BigQuery table using this notebook in order to proceed manually.

---

## 📁 Environment Variables (`.env`)

This project uses a `.env` file to configure access to AtScale and Google BigQuery. Create a file named `.env` in the project root and include the following variables:

```env
# This file contains environment variables for the AtScale and Google BigQuery integration.

# AtScale configuration
ATSCALE_URL=atscale.mycompany.com
ATSCALE_CLIENT_SECRET=you can find this in keycloak->Clients->atscale-modeler->Credentials->Client Secret
ATSCALE_USER=atscale_admin
ATSCALE_USER_PASSWORD=password

# Google BigQuery configuration
# Note: The service account file should be kept secure and not shared publicly.
GBQ_SERVICE_ACCOUNT_FILE=/path/to/credentials.json
GBQ_PROJECT_ID='gbq-project'
GBQ_DATASET_ID='atscale_aggregates'
GBQ_LOCATION='EU'

# BigQuery project and dataset configuration for the AtScale Query Log and Aggregates
GBQ_TABLE_ID_ATSCALE_QUERY_LOG='atsclae_query_log'

# BigQuery project and dataset configuration for exported GBQ Information Schema
GBQ_TABLE_ID_INFORMATION_SCHEMA='gbq_information_schema'
GBQ_INFORMATION_SCHEMA_EXTRACT_CSV='/path/to/information_schema_extract.csv'
