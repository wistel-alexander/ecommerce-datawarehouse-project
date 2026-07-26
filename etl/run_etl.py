"""
===========================================================
Project : Ecommerce Data Warehouse
File    : run_etl.py
Purpose : Execute Complete ETL Process
===========================================================
"""

import uuid
import time

from etl.run_staging import run_staging
from etl.execute_procedure import execute_procedure


def run_etl():

    batch_id = str(uuid.uuid4())

    print("\n")
    print("=" * 70)
    print("ECOMMERCE DATA WAREHOUSE ETL")
    print("=" * 70)

    print(f"Batch ID : {batch_id}")

    start = time.perf_counter()

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

        "etl.usp_Load_DimSeller",

        # "etl.usp_Load_FactSales"

    ]

    print("\n")
    print("=" * 70)
    print("LOADING DATA WAREHOUSE")
    print("=" * 70)

    for procedure in warehouse_processes:

        execute_procedure(

            procedure,

            {

                "BatchID": batch_id

            }

        )

    elapsed = time.perf_counter() - start

    print("\n")
    print("=" * 70)
    print("ETL FINISHED SUCCESSFULLY")
    print("=" * 70)
    print(f"Execution Time : {elapsed:.2f} seconds")
    print("=" * 70)


if __name__ == "__main__":
    run_etl()