"""
===========================================================
Project : Ecommerce Data Warehouse
File    : database.py
Author  : Wistel Alexander
Purpose : SQL Server connection
===========================================================
"""

from urllib.parse import quote_plus

from sqlalchemy import create_engine

from etl.config.settings import (
    SERVER,
    DATABASE,
    DRIVER,
    TRUSTED_CONNECTION
)

# ==========================================
# Connection String
# ==========================================

connection_string = (
    f"DRIVER={{{DRIVER}}};"
    f"SERVER={SERVER};"
    f"DATABASE={DATABASE};"
    f"Trusted_Connection={TRUSTED_CONNECTION};"
)

engine = create_engine(
    f"mssql+pyodbc:///?odbc_connect={quote_plus(connection_string)}",
    fast_executemany=True
)