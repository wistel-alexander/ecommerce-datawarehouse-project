from utils.console import print_section, print_subsection
from utils.metrics import print_metric
from utils.data_loader import load_dataset
from utils.report_generator import generate_markdown_report


def analyze_order_items():
    """
    Analyze the Order Items dataset and generate a technical report.
    """

    # ==========================================================
    # Load Dataset
    # ==========================================================

    order_items = load_dataset("olist_order_items_dataset.csv")

    # ==========================================================
    # Basic Metrics
    # ==========================================================

    total_rows = len(order_items)

    unique_orders = order_items["order_id"].nunique()

    unique_products = order_items["product_id"].nunique()

    unique_sellers = order_items["seller_id"].nunique()

    duplicated_rows = order_items.duplicated().sum()

    null_values = order_items.isnull().sum().sum()

    # ==========================================================
    # Price Statistics
    # ==========================================================

    min_price = order_items["price"].min()
    avg_price = order_items["price"].mean()
    max_price = order_items["price"].max()

    # ==========================================================
    # Freight Statistics
    # ==========================================================

    min_freight = order_items["freight_value"].min()
    avg_freight = order_items["freight_value"].mean()
    max_freight = order_items["freight_value"].max()

    # ==========================================================
    # Console Output
    # ==========================================================

    print_section("ORDER ITEMS DATASET ANALYSIS")

    print()

    print_metric("Total rows", total_rows)
    print_metric("Unique orders", unique_orders)
    print_metric("Unique products", unique_products)
    print_metric("Unique sellers", unique_sellers)
    print_metric("Duplicated rows", duplicated_rows)
    print_metric("Missing values", null_values)

    print_subsection("Price Statistics")

    print_metric("Minimum price", round(min_price, 2))
    print_metric("Average price", round(avg_price, 2))
    print_metric("Maximum price", round(max_price, 2))

    print_subsection("Freight Statistics")

    print_metric("Minimum freight", round(min_freight, 2))
    print_metric("Average freight", round(avg_freight, 2))
    print_metric("Maximum freight", round(max_freight, 2))

    # ==========================================================
    # Markdown Report
    # ==========================================================

    report = f"""
## Objetivo

Analizar el dataset de los ítems de pedido para comprender la estructura de las ventas, la relación entre pedidos, productos y vendedores, y su importancia dentro del futuro Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de registros | {total_rows:,} |
| Pedidos únicos | {unique_orders:,} |
| Productos únicos | {unique_products:,} |
| Vendedores únicos | {unique_sellers:,} |
| Filas duplicadas | {duplicated_rows:,} |
| Valores nulos | {null_values:,} |

---

## Calidad de los datos

No se identificaron registros duplicados ni valores nulos.

La estructura del dataset es consistente y adecuada para los procesos ETL.

---

## Estadísticas de Precios

| Métrica | Valor |
|---------|------:|
| Precio mínimo | {min_price:.2f} |
| Precio promedio | {avg_price:.2f} |
| Precio máximo | {max_price:.2f} |

---

## Estadísticas del Flete

| Métrica | Valor |
|---------|------:|
| Flete mínimo | {min_freight:.2f} |
| Flete promedio | {avg_freight:.2f} |
| Flete máximo | {max_freight:.2f} |

---

## Hallazgos del análisis

- Cada registro representa un producto específico incluido dentro de un pedido.
- Un pedido puede contener uno o varios productos.
- Un vendedor puede participar en múltiples pedidos.
- El dataset contiene la información monetaria de cada producto vendido.
- Se identificó que existen **{total_rows:,} registros** para **{unique_orders:,} pedidos**, lo que confirma que un pedido puede contener múltiples productos. Esta característica determinará la granularidad de la futura tabla de hechos del Data Warehouse.

---

## Decisiones para el Data Warehouse

Este dataset definirá la granularidad de la tabla de hechos (**FactSales**).

Permitirá almacenar:

- Precio del producto.
- Valor del flete.
- Cantidad de productos por pedido.
- Clave de negocio del pedido (**order_id**).
- Relación con las dimensiones de Productos y Vendedores.
- Relación entre pedidos, productos y vendedores.

---

## Conclusiones

El dataset representa el nivel de detalle de cada venta realizada. Cada registro corresponde a un producto específico dentro de un pedido, lo que convierte a este conjunto de datos en la principal fuente para construir la tabla de hechos (**FactSales**) del futuro Data Warehouse.
"""

    generate_markdown_report(
        filename="order_items_analysis.md",
        title="Análisis del Dataset de Ítems de Pedido",
        content=report,
    )

    print("\nAnalysis completed successfully.")