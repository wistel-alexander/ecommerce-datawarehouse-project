"""
===========================================================
Project : Ecommerce Data Warehouse
File    : load_payments.py
Author  : Wistel Alexander
Purpose : Load payments dataset into SQL Server staging
===========================================================
"""

import pandas as pd

from config import RAW_DATA_DIR
from etl.load.load_to_staging import load_dataframe


def load_payments() -> None:
    """
    Load payments dataset into staging table.
    """

    print("\n" + "=" * 60)
    print("PAYMENTS ETL")
    print("=" * 60)

    file_path = RAW_DATA_DIR / "olist_order_payments_dataset.csv"

    print(f"Reading file:\n{file_path}")

    payments = pd.read_csv(file_path)

    print(f"Rows found : {len(payments):,}")
    print(f"Columns    : {len(payments.columns)}")

    load_dataframe(
        df=payments,
        table_name="stg_payments"
    )

    print("Payments dataset loaded successfully.")


if __name__ == "__main__":
    load_payments()