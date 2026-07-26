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

    start = time.perf_counter()

    print("\n")
    print("=" * 70)
    print("ECOMMERCE DATA WAREHOUSE ETL")
    print("=" * 70)

    # --------------------------------------------------
    # Load Staging
    # --------------------------------------------------

    run_staging()

    # --------------------------------------------------
    # Load Data Warehouse
    # --------------------------------------------------

    warehouse_processes = [

        "etl.usp_Load_DimDate",

        "etl.usp_Load_DimCustomer",
        
        "etl.usp_Load_DimProduct",
        
        "etl.usp_Load_DimSeller"

    ]

    print("\n")
    print("=" * 70)
    print("LOADING DATA WAREHOUSE")
    print("=" * 70)

    for procedure in warehouse_processes:

        execute_procedure(procedure)

    elapsed = time.perf_counter() - start

    print("\n")
    print("=" * 70)
    print("ETL FINISHED SUCCESSFULLY")
    print("=" * 70)
    print(f"Execution Time : {elapsed:.2f} seconds")
    print("=" * 70)


if __name__ == "__main__":
    run_etl()