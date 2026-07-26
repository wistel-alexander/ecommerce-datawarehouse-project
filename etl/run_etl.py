"""
===========================================================
Project : Ecommerce Data Warehouse
File    : run_etl.py
Purpose : Execute Complete ETL Process
===========================================================
"""

import time

from etl.run_staging import run_staging
from etl.execute_procedure import execute_procedure


def run_etl():

    start_time = time.perf_counter()

    print("\n")
    print("=" * 70)
    print("ECOMMERCE DATA WAREHOUSE ETL")
    print("=" * 70)

    # ---------------------------------------------------------
    # Load Staging Layer
    # ---------------------------------------------------------
    run_staging()

    # ---------------------------------------------------------
    # Load Data Warehouse
    # ---------------------------------------------------------
    warehouse_processes = [

        "dw.usp_Load_DimDate",

        "dw.usp_Load_DimCustomer",

    ]

    print("\n")
    print("=" * 70)
    print("LOADING DATA WAREHOUSE")
    print("=" * 70)

    for procedure in warehouse_processes:

        execute_procedure(procedure)

    elapsed = time.perf_counter() - start_time

    print("\n")
    print("=" * 70)
    print("ETL FINISHED SUCCESSFULLY")
    print("=" * 70)
    print(f"Execution Time : {elapsed:.2f} seconds")
    print("=" * 70)


if __name__ == "__main__":
    run_etl()