"""
===========================================================
Project : Ecommerce Data Warehouse
File    : load_customers.py
Author  : Wistel Alexander
Purpose : Load customers dataset into SQL Server staging
===========================================================
"""

import pandas as pd

from config import RAW_DATA_DIR

from etl.load.load_to_staging import load_dataframe


def load_customers() -> None:
    """
    Load customers dataset into staging table.
    """

    print("\n" + "=" * 60)
    print("CUSTOMERS ETL")
    print("=" * 60)

    file_path = RAW_DATA_DIR / "olist_customers_dataset.csv"

    print(f"Reading file:\n{file_path}")

    customers = pd.read_csv(file_path)

    print(f"Rows found : {len(customers):,}")
    print(f"Columns    : {len(customers.columns)}")

    load_dataframe(
        df=customers,
        table_name="stg_customers"
    )

    print("Customers dataset loaded successfully.")


if __name__ == "__main__":
    load_customers()