"""
===========================================================
Project : Ecommerce Data Warehouse
File    : execute_procedure.py
Purpose : Execute SQL Server Stored Procedures
===========================================================
"""

import time

from sqlalchemy import text

from etl.config.database import engine


def execute_procedure(procedure_name: str) -> None:

    start = time.perf_counter()

    print("\n" + "=" * 60)
    print(f"Executing: {procedure_name}")
    print("=" * 60)

    try:

        with engine.begin() as connection:

            connection.execute(
                text(f"EXEC {procedure_name}")
            )

        elapsed = time.perf_counter() - start

        print(f"SUCCESS : {procedure_name}")
        print(f"Execution Time : {elapsed:.2f} seconds")

    except Exception as error:

        print(f"ERROR : {procedure_name}")
        print(error)

        raise