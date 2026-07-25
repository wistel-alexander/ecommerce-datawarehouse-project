"""
===========================================================
Project : Ecommerce Data Warehouse
File    : load_sellers.py
Author  : Wistel Alexander
Purpose : Load sellers dataset into SQL Server staging
===========================================================
"""

import pandas as pd

from config import RAW_DATA_DIR

from etl.load.load_to_staging import load_dataframe


def load_sellers() -> None:
    """
    Load sellers dataset into staging table.
    """

    print("\n" + "=" * 60)
    print("SELLERS ETL")
    print("=" * 60)

    file_path = RAW_DATA_DIR / "olist_sellers_dataset.csv"

    print(f"Reading file:\n{file_path}")

    sellers = pd.read_csv(file_path)

    print(f"Rows found : {len(sellers):,}")
    print(f"Columns    : {len(sellers.columns)}")

    load_dataframe(
        df=sellers,
        table_name="stg_sellers"
    )

    print("Sellers dataset loaded successfully.")


if __name__ == "__main__":
    load_sellers()