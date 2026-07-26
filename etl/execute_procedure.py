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


def execute_procedure(procedure_name, parameters=None):
    """
    Execute a SQL Server Stored Procedure
    and display execution information.
    """

    parameters = parameters or {}

    placeholders = ", ".join(
        f"@{key}=:{key}"
        for key in parameters.keys()
    )

    sql = (
        f"EXEC {procedure_name} {placeholders}"
        if placeholders
        else f"EXEC {procedure_name}"
    )

    print("\n")
    print("=" * 60)
    print(f"Executing : {procedure_name}")
    print("=" * 60)

    start = time.perf_counter()

    try:

        with engine.begin() as connection:

            connection.execute(
                text(sql),
                parameters
            )

        elapsed = time.perf_counter() - start

        print(f"SUCCESS")
        print(f"Execution Time : {elapsed:.2f} seconds")

    except Exception as ex:

        elapsed = time.perf_counter() - start

        print("FAILED")
        print(f"Execution Time : {elapsed:.2f} seconds")
        print(f"Error : {ex}")

        raise