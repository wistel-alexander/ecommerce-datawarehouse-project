"""
===========================================================
Project : Ecommerce Data Warehouse
File    : execute_procedure.py
Purpose : Execute SQL Server Stored Procedures
===========================================================
"""

from sqlalchemy import text

from etl.config.database import engine


def execute_procedure(procedure_name: str) -> None:
    """
    Execute a SQL Server stored procedure.

    Parameters
    ----------
    procedure_name : str
        Stored procedure name (Example: dw.usp_Load_DimCustomer)
    """

    print("\n" + "=" * 60)
    print(f"Executing: {procedure_name}")
    print("=" * 60)

    try:

        with engine.begin() as connection:

            connection.execute(
                text(f"EXEC {procedure_name}")
            )

        print(f"SUCCESS: {procedure_name}")

    except Exception as error:

        print(f"ERROR executing {procedure_name}")
        print(error)

        raise