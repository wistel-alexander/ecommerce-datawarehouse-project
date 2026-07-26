"""
===========================================================
Project : Ecommerce Data Warehouse
File    : execute_procedure.py
Purpose : Execute SQL Server Stored Procedures
===========================================================
"""

from sqlalchemy import text

from etl.config.database import engine


def execute_procedure(procedure_name, parameters=None):
    """
    Execute a SQL Server stored procedure.

    Parameters
    ----------
    procedure_name : str
        Stored procedure name.

    parameters : dict, optional
        Dictionary containing stored procedure parameters.
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

    with engine.begin() as connection:

        connection.execute(

            text(sql),

            parameters

        )