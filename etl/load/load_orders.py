"""
===========================================================
Project : Ecommerce Data Warehouse
File    : load_orders.py
Author  : Wistel Alexander
Purpose : Load orders dataset into SQL Server staging
===========================================================
"""

import pandas as pd

from config import RAW_DATA_DIR
from etl.load.load_to_staging import load_dataframe


def load_orders() -> None:
    """
    Load orders dataset into staging table.
    """

    print("\n" + "=" * 60)
    print("ORDERS ETL")
    print("=" * 60)

    file_path = RAW_DATA_DIR / "olist_orders_dataset.csv"

    print(f"Reading file:\n{file_path}")

    orders = pd.read_csv(
        file_path,
        parse_dates=[
            "order_purchase_timestamp",
            "order_approved_at",
            "order_delivered_carrier_date",
            "order_delivered_customer_date",
            "order_estimated_delivery_date"
        ]
    )

    print(f"Rows found : {len(orders):,}")
    print(f"Columns    : {len(orders.columns)}")

    load_dataframe(
        df=orders,
        table_name="stg_orders"
    )

    print("Orders dataset loaded successfully.")


if __name__ == "__main__":
    load_orders()