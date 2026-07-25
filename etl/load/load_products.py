"""
===========================================================
Project : Ecommerce Data Warehouse
File    : load_products.py
Author  : Wistel Alexander
Purpose : Load products dataset into SQL Server staging
===========================================================
"""

import pandas as pd

from config import RAW_DATA_DIR

from etl.load.load_to_staging import load_dataframe


def load_products() -> None:
    """
    Load products dataset into staging table.
    """

    print("\n" + "=" * 60)
    print("PRODUCTS ETL")
    print("=" * 60)

    file_path = RAW_DATA_DIR / "olist_products_dataset.csv"

    print(f"Reading file:\n{file_path}")

    products = pd.read_csv(file_path)

    print(f"Rows found : {len(products):,}")
    print(f"Columns    : {len(products.columns)}")

    load_dataframe(
        df=products,
        table_name="stg_products"
    )

    print("Products dataset loaded successfully.")


if __name__ == "__main__":
    load_products()