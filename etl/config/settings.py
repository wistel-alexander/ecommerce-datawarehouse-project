"""
===========================================================
Project : Ecommerce Data Warehouse
File    : settings.py
Author  : Wistel Alexander
Purpose : Project configuration settings
===========================================================
"""

# ==========================================
# SQL Server Configuration
# ==========================================

SERVER = "localhost"

DATABASE = "EcommerceDW"

DRIVER = "ODBC Driver 17 for SQL Server"

TRUSTED_CONNECTION = "yes"

# ==========================================
# ETL Configuration
# ==========================================

BATCH_SIZE = 1000

SCHEMA_STAGING = "stg"

SCHEMA_WAREHOUSE = "dw"

SCHEMA_ETL = "etl"