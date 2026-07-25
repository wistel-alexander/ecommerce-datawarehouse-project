"""
===========================================================
Project : Ecommerce Data Warehouse
File    : test_connection.py
Author  : Wistel Alexander
Purpose : Test SQL Server connection
===========================================================
"""

from sqlalchemy import text

from etl.config.database import engine


def test_connection():

    try:

        with engine.connect() as conn:

            result = conn.execute(text("SELECT @@SERVERNAME"))

            server = result.scalar()

            print("=" * 50)
            print("SQL SERVER CONNECTION SUCCESSFUL")
            print("=" * 50)
            print(f"Connected Server : {server}")
            print("=" * 50)

    except Exception as ex:

        print("=" * 50)
        print("CONNECTION FAILED")
        print("=" * 50)
        print(ex)


if __name__ == "__main__":
    test_connection()