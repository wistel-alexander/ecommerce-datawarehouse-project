"""
===========================================================
Project : Ecommerce Data Warehouse
File    : load_to_staging.py
Author  : Wistel Alexander
Purpose : Generic loader for SQL Server staging tables
===========================================================
"""

import pandas as pd

from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError

from etl.config.database import engine
from etl.config.settings import (
    BATCH_SIZE,
    SCHEMA_STAGING
)


def load_dataframe(
    df: pd.DataFrame,
    table_name: str,
    schema: str = SCHEMA_STAGING,
    truncate: bool = True
) -> None:
    """
    Load a pandas DataFrame into a SQL Server staging table.

    Parameters
    ----------
    df : pandas.DataFrame
        DataFrame to load.

    table_name : str
        Destination table name.

    schema : str
        Destination schema.

    truncate : bool
        If True, the destination table is truncated before loading.
    """

    print("\n" + "=" * 60)
    print(f"LOADING TABLE: {schema}.{table_name}")
    print("=" * 60)

    if df.empty:
        print("The DataFrame is empty. No data was loaded.")
        return

    try:

        if truncate:

            with engine.begin() as conn:

                print(f"Truncating table: {schema}.{table_name}")

                conn.execute(
                    text(f"TRUNCATE TABLE {schema}.{table_name}")
                )

                print("Table truncated successfully.")

        print(f"Loading {len(df):,} rows...")

        df.to_sql(
            name=table_name,
            con=engine,
            schema=schema,
            if_exists="append",
            index=False,
            chunksize=BATCH_SIZE
        )

        print(f"Rows loaded successfully : {len(df):,}")

    except SQLAlchemyError as ex:

        print("\nERROR loading data into SQL Server.")
        print(ex)

        raise

    print("=" * 60)
    print("LOAD COMPLETED SUCCESSFULLY")
    print("=" * 60)