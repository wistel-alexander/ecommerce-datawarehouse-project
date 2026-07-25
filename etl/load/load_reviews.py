"""
===========================================================
Project : Ecommerce Data Warehouse
File    : load_reviews.py
Author  : Wistel Alexander
Purpose : Load reviews dataset into SQL Server staging
===========================================================
"""

import pandas as pd

from config import RAW_DATA_DIR
from etl.load.load_to_staging import load_dataframe


def load_reviews() -> None:
    """
    Load reviews dataset into staging table.
    """

    print("\n" + "=" * 60)
    print("REVIEWS ETL")
    print("=" * 60)

    file_path = RAW_DATA_DIR / "olist_order_reviews_dataset.csv"

    print(f"Reading file:\n{file_path}")

    reviews = pd.read_csv(
        file_path,
        parse_dates=[
            "review_creation_date",
            "review_answer_timestamp"
        ]
    )

    print(f"Rows found : {len(reviews):,}")
    print(f"Columns    : {len(reviews.columns)}")

    load_dataframe(
        df=reviews,
        table_name="stg_reviews"
    )

    print("Reviews dataset loaded successfully.")


if __name__ == "__main__":
    load_reviews()