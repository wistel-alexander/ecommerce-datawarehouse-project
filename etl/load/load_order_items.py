"""
===========================================================
Project : Ecommerce Data Warehouse
File    : load_order_items.py
Author  : Wistel Alexander
Purpose : Load order items dataset into SQL Server staging
===========================================================
"""

import pandas as pd

from config import RAW_DATA_DIR
from etl.load.load_to_staging import load_dataframe


def load_order_items() -> None:
    """
    Load order items dataset into staging table.
    """

    print("\n" + "=" * 60)
    print("ORDER ITEMS ETL")
    print("=" * 60)

    file_path = RAW_DATA_DIR / "olist_order_items_dataset.csv"

    print(f"Reading file:\n{file_path}")

    order_items = pd.read_csv(
        file_path,
        parse_dates=[
            "shipping_limit_date"
        ]
    )

    print(f"Rows found : {len(order_items):,}")
    print(f"Columns    : {len(order_items.columns)}")

    load_dataframe(
        df=order_items,
        table_name="stg_order_items"
    )

    print("Order Items dataset loaded successfully.")


if __name__ == "__main__":
    load_order_items()