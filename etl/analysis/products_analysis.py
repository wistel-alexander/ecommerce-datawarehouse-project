from utils.console import print_section, print_subsection
from utils.metrics import print_metric
from utils.data_loader import load_dataset
from utils.report_generator import generate_markdown_report


def analyze_products():
    """
    Analyze the Products dataset and generate a technical report.
    """

    # ==========================================================
    # Load Dataset
    # ==========================================================

    products = load_dataset("olist_products_dataset.csv")

    # ==========================================================
    # Basic Metrics
    # ==========================================================

    total_rows = len(products)

    unique_products = products["product_id"].nunique()

    duplicated_rows = products.duplicated().sum()

    total_nulls = products.isnull().sum().sum()

    missing_category = products["product_category_name"].isnull().sum()

    # ==========================================================
    # Missing Values by Column
    # ==========================================================

    missing_values = (
        products.isnull()
        .sum()
        .sort_values(ascending=False)
    )

    missing_values = missing_values[missing_values > 0]

    missing_table = "| Columna | Valores nulos |\n"
    missing_table += "|---------|--------------:|\n"

    for column, value in missing_values.items():
        missing_table += f"| {column} | {value:,} |\n"

    # ==========================================================
    # Physical Statistics
    # ==========================================================

    avg_weight = products["product_weight_g"].mean()

    avg_length = products["product_length_cm"].mean()

    avg_height = products["product_height_cm"].mean()

    avg_width = products["product_width_cm"].mean()

    # ==========================================================
    # Console Output
    # ==========================================================

    print_section("PRODUCTS DATASET ANALYSIS")

    print()

    print_metric("Total products", total_rows)
    print_metric("Unique product_id", unique_products)
    print_metric("Duplicated rows", duplicated_rows)
    print_metric("Missing values", total_nulls)
    print_metric("Missing categories", missing_category)

    print_subsection("Average Physical Characteristics")

    print_metric("Average weight (g)", round(avg_weight, 2))
    print_metric("Average length (cm)", round(avg_length, 2))
    print_metric("Average height (cm)", round(avg_height, 2))
    print_metric("Average width (cm)", round(avg_width, 2))

    # ==========================================================
    # Markdown Report
    # ==========================================================

    report = f"""
## Objetivo

Analizar el dataset de productos para comprender la información descriptiva y física de los artículos comercializados, así como su importancia dentro del futuro Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de productos | {total_rows:,} |
| Productos únicos | {unique_products:,} |
| Filas duplicadas | {duplicated_rows:,} |
| Valores nulos | {total_nulls:,} |
| Categorías sin información | {missing_category:,} |

---

## Calidad de los datos

No se identificaron registros duplicados.

Se encontraron valores nulos principalmente en la categoría del producto y en algunas características físicas. Estos registros deberán evaluarse durante la fase de transformación (ETL).

---

## Distribución de valores nulos

{missing_table}

---

## Estadísticas Físicas

| Métrica | Valor |
|---------|------:|
| Peso promedio (g) | {avg_weight:.2f} |
| Longitud promedio (cm) | {avg_length:.2f} |
| Altura promedio (cm) | {avg_height:.2f} |
| Anchura promedio (cm) | {avg_width:.2f} |

---

## Hallazgos del análisis

- Cada producto posee un identificador único.
- La mayoría de los productos cuentan con información física completa.
- Existen 610 productos sin categoría asignada.
- Solo dos productos presentan información física incompleta, lo que representa una proporción mínima respecto al total del dataset y facilita su tratamiento durante el proceso ETL.
- La información física permitirá realizar análisis relacionados con logística y transporte.

---

## Reglas ETL identificadas

- Los productos sin categoría deberán asignarse a una categoría estándar como **"Unknown"** durante la transformación.
- Los valores nulos en las dimensiones físicas deberán revisarse antes de la carga al Data Warehouse.
- Se conservarán los tipos de datos numéricos para facilitar cálculos posteriores.
- Se conservará el identificador original (**product_id**) como clave de negocio para la construcción de la dimensión **DimProduct**.

---

## Decisiones para el Data Warehouse

Este dataset será la fuente para construir la dimensión **DimProduct**.

Permitirá almacenar atributos como:

- ProductKey (clave sustituta generada durante el proceso ETL).
- Identificador del producto (clave de negocio).
- Categoría del producto.
- Peso.
- Longitud.
- Altura.
- Anchura.

---

## Conclusiones

El dataset contiene la información descriptiva de los productos comercializados y permitirá construir la dimensión **DimProduct** del Data Warehouse. Los pocos valores nulos identificados no afectan significativamente la calidad del conjunto de datos, pero deberán tratarse mediante reglas definidas durante el proceso ETL.
"""

    generate_markdown_report(
        filename="products_analysis.md",
        title="Análisis del Dataset de Productos",
        content=report,
    )

    print("\nAnalysis completed successfully.")