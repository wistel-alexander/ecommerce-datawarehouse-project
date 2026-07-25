import pandas as pd

from utils.console import print_section, print_subsection
from utils.metrics import print_metric
from utils.data_loader import load_dataset
from utils.report_generator import generate_markdown_report


def analyze_orders():
    """
    Analyze the orders dataset to understand
    its structure and business behavior.
    """

    # ==========================
    # Load dataset
    # ==========================

    orders = load_dataset(
        "olist_orders_dataset.csv"
    )

    # ==========================
    # Basic Metrics
    # ==========================

    total_orders = len(orders)

    unique_orders = orders["order_id"].nunique()

    duplicated_orders = orders.duplicated(
        subset="order_id"
    ).sum()

    # ==========================
    # Missing Values
    # ==========================

    missing_approved = orders["order_approved_at"].isna().sum()

    missing_carrier = (
        orders["order_delivered_carrier_date"]
        .isna()
        .sum()
    )

    missing_customer = (
        orders["order_delivered_customer_date"]
        .isna()
        .sum()
    )

    # ==========================
    # Order Status
    # ==========================

    status_counts = (
        orders["order_status"]
        .value_counts()
    )

    # ==========================
    # Console Output
    # ==========================

    print_section("Orders Dataset Analysis")

    print()

    print_metric("Total orders", total_orders)

    print_metric("Unique order_id", unique_orders)

    print_metric("Duplicated order_id", duplicated_orders)

    print()

    print_metric(
        "Missing approval dates",
        missing_approved
    )

    print_metric(
        "Missing carrier dates",
        missing_carrier
    )

    print_metric(
        "Missing delivery dates",
        missing_customer
    )

    print_subsection("Order Status Distribution")

    print(status_counts)

    # ==========================
    # Markdown Report
    # ==========================

    status_table = status_counts.to_markdown()

    report_content = f"""
## Objetivo

Analizar el conjunto de datos de pedidos para comprender su estructura,
su calidad de datos y su importancia dentro del futuro Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de pedidos | {total_orders:,} |
| order_id únicos | {unique_orders:,} |
| order_id duplicados | {duplicated_orders:,} |
| Fechas de aprobación nulas | {missing_approved:,} |
| Fechas de entrega al transportista nulas | {missing_carrier:,} |
| Fechas de entrega al cliente nulas | {missing_customer:,} |

---

## Distribución de Estados

{status_table}

---

## Hallazgos del análisis

- Cada pedido posee un identificador único.
- Existen pedidos con fechas nulas debido a estados como cancelado o no entregado.
- El estado del pedido será fundamental para el análisis del negocio.

---

## Calidad de los datos

El dataset presenta una estructura consistente y no contiene pedidos duplicados.

Los valores nulos encontrados corresponden al flujo normal del proceso logístico y no representan errores del dataset.

---

## Decisiones para el Data Warehouse

Este dataset será la principal fuente para construir la tabla de hechos (**FactSales**).

Además permitirá construir:

- DimDate
- Indicadores de cumplimiento
- Indicadores logísticos
- Indicadores de pedidos

---

## Conclusiones

El dataset representa el núcleo del proceso de ventas y constituye la base para el modelo dimensional del proyecto.
"""

    generate_markdown_report(
        filename="orders_analysis.md",
        title="Análisis del Dataset de Pedidos",
        content=report_content
    )

    print("\nAnalysis completed successfully.")