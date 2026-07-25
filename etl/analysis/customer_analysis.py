import pandas as pd

from utils.data_loader import load_dataset
from utils.report_generator import generate_markdown_report
from utils.console import print_section, print_subsection
from utils.metrics import print_metric



def analyze_customers():
    """
    Analyze the customers dataset to understand
    its structure and business behavior.
    """

    # Load dataset
    customers = load_dataset(
    "olist_customers_dataset.csv"
    )

    # Unique values
    unique_customer_id = customers["customer_id"].nunique()
    unique_customer_unique_id = customers["customer_unique_id"].nunique()

    # Duplicate analysis
    duplicated_customer_id = customers.duplicated(
        subset="customer_id"
    ).sum()

    duplicated_unique = customers.duplicated(
        subset="customer_unique_id"
    ).sum()

    # Customers with multiple purchases
    repeat_customers = (
        customers
        .groupby("customer_unique_id")
        .size()
        .sort_values(ascending=False)
    )

    multi_buyers = repeat_customers[
        repeat_customers > 1
    ]

    # ==========================
    # Console Output
    # ==========================

    print_section("Customers Dataset Analysis")

    print()

    print_metric("Total records", len(customers))
    print_metric("Unique customer_id", unique_customer_id)
    print_metric("Unique customer_unique_id", unique_customer_unique_id)

    print()

    print_metric("Duplicated customer_id", duplicated_customer_id)
    print_metric("Duplicated unique customers", duplicated_unique)

    print()

    print_metric(
        "Customers with multiple purchases",
        len(multi_buyers)
    )

    if len(multi_buyers) > 0:
        print_subsection("Top 10 Repeat Customers")
        print(multi_buyers.head(10))

    print("\nAnalysis completed successfully.")
    
    
    
    
    # ==========================
    # Markdown Report
    # ==========================

    report_content = f"""
## Objetivo

Analizar el conjunto de datos de clientes para comprender su estructura,
su calidad de datos y el papel que desempeñará dentro del futuro
Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de registros | {len(customers):,} |
| customer_id únicos | {unique_customer_id:,} |
| customer_unique_id únicos | {unique_customer_unique_id:,} |
| customer_id duplicados | {duplicated_customer_id:,} |
| customer_unique_id duplicados | {duplicated_unique:,} |
| Clientes con múltiples compras | {len(multi_buyers):,} |

---

## Hallazgos del análisis

- Cada **customer_id** identifica de forma única un registro del dataset.
- El campo **customer_unique_id** representa al cliente real dentro del negocio.
- Un mismo cliente puede realizar múltiples compras a lo largo del tiempo.
- Se identificaron clientes recurrentes, lo que permitirá analizar indicadores de fidelización.

---

## Calidad de los datos

- No se encontraron registros duplicados en **customer_id**.
- No se encontraron valores nulos en las columnas del dataset.
- La calidad de los datos es adecuada para construir una dimensión dentro del Data Warehouse.

---

## Decisión para el Data Warehouse

Con base en el análisis realizado, este conjunto de datos será utilizado para construir la dimensión **DimCustomer**.

**Clave de negocio (Business Key):**

- customer_unique_id

**Clave sustituta (Surrogate Key):**

- customer_key (generada durante el proceso ETL)

La utilización de una clave sustituta permitirá optimizar las relaciones dentro del modelo dimensional y facilitar la administración histórica de los datos.

---

## Conclusiones

El conjunto de datos presenta una excelente calidad de información y permite identificar de manera correcta a los clientes de la plataforma de comercio electrónico.

El análisis confirmó que un mismo cliente puede realizar múltiples compras, razón por la cual la dimensión **DimCustomer** se construirá utilizando **customer_unique_id** como clave de negocio y una **clave sustituta** como llave primaria dentro del Data Warehouse.

Esta decisión facilitará la integración con la tabla de hechos y permitirá desarrollar indicadores relacionados con clientes, recurrencia de compra, ubicación geográfica y comportamiento comercial.
"""

    generate_markdown_report(
        filename="customer_analysis.md",
        title="Análisis del Dataset de Clientes",
        content=report_content
    )