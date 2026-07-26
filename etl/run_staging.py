"""
===========================================================
Project : Ecommerce Data Warehouse
File    : run_staging.py
Purpose : Load all staging tables
===========================================================
"""

import time

from etl.load.load_customers import load_customers
from etl.load.load_products import load_products
from etl.load.load_sellers import load_sellers
from etl.load.load_orders import load_orders
from etl.load.load_order_items import load_order_items
from etl.load.load_payments import load_payments
from etl.load.load_reviews import load_reviews


def run_staging():

    start_time = time.perf_counter()

    print("\n")
    print("=" * 60)
    print("LOADING STAGING LAYER")
    print("=" * 60)

    processes = [

        ("Customers", load_customers),

        ("Products", load_products),

        ("Sellers", load_sellers),

        ("Orders", load_orders),

        ("Order Items", load_order_items),

        ("Payments", load_payments),

        ("Reviews", load_reviews)

    ]

    for name, process in processes:

        print("\n")
        print("-" * 60)
        print(f"Starting {name}")
        print("-" * 60)

        process()

        print(f"{name} loaded successfully.")

    elapsed = time.perf_counter() - start_time

    print("\n")
    print("=" * 60)
    print("STAGING COMPLETED SUCCESSFULLY")
    print("=" * 60)
    print(f"Execution Time : {elapsed:.2f} seconds")
    print("=" * 60)


if __name__ == "__main__":
    run_staging()