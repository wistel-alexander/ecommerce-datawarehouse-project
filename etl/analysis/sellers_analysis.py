from utils.console import print_section
from utils.metrics import print_metric
from utils.data_loader import load_dataset
from utils.report_generator import generate_markdown_report


def analyze_sellers():
    """
    Analyze the Sellers dataset and generate a technical report.
    """

    # ==========================================================
    # Load Dataset
    # ==========================================================

    sellers = load_dataset("olist_sellers_dataset.csv")

    # ==========================================================
    # Basic Metrics
    # ==========================================================

    total_rows = len(sellers)

    unique_sellers = sellers["seller_id"].nunique()

    duplicated_rows = sellers.duplicated().sum()

    total_nulls = sellers.isnull().sum().sum()

    unique_cities = sellers["seller_city"].nunique()

    unique_states = sellers["seller_state"].nunique()

    # ==========================================================
    # Missing Values
    # ==========================================================

    missing_values = (
        sellers.isnull()
        .sum()
        .sort_values(ascending=False)
    )

    missing_values = missing_values[missing_values > 0]

    if len(missing_values) == 0:
        missing_table = "No se encontraron valores nulos."
    else:
        missing_table = "| Columna | Valores nulos |\n"
        missing_table += "|---------|--------------:|\n"

        for column, value in missing_values.items():
            missing_table += f"| {column} | {value:,} |\n"

    # ==========================================================
    # Top States
    # ==========================================================

    top_states = (
        sellers["seller_state"]
        .value_counts()
        .head(10)
    )

    states_table = "| Estado | Cantidad |\n"
    states_table += "|---------|---------:|\n"

    for state, count in top_states.items():
        states_table += f"| {state} | {count:,} |\n"

    # ==========================================================
    # Console
    # ==========================================================

    print_section("SELLERS DATASET ANALYSIS")

    print()

    print_metric("Total sellers", total_rows)
    print_metric("Unique seller_id", unique_sellers)
    print_metric("Duplicated rows", duplicated_rows)
    print_metric("Missing values", total_nulls)
    print_metric("Cities", unique_cities)
    print_metric("States", unique_states)

    # ==========================================================
    # Markdown Report
    # ==========================================================

    report = f"""
## Objetivo

Analizar el dataset de vendedores para comprender su distribución geográfica y su importancia dentro del futuro Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de vendedores | {total_rows:,} |
| Vendedores únicos | {unique_sellers:,} |
| Filas duplicadas | {duplicated_rows:,} |
| Valores nulos | {total_nulls:,} |
| Ciudades | {unique_cities:,} |
| Estados | {unique_states:,} |

---

## Calidad de los datos

No se identificaron registros duplicados ni valores nulos.

La estructura del dataset presenta una alta calidad y no requiere procesos de limpieza antes de la transformación.

---

## Distribución de valores nulos

{missing_table}

---

## Distribución geográfica de vendedores

{states_table}

---

## Observaciones del negocio

- Los vendedores se encuentran distribuidos en diferentes estados de Brasil.
- La concentración de vendedores por estado permitirá realizar análisis geográficos de las ventas.
- La información de ubicación facilitará la construcción de indicadores regionales.

---

## Hallazgos técnicos

- Cada vendedor posee un identificador único.
- No existen registros duplicados.
- No existen valores nulos.
- El dataset será utilizado para construir la dimensión de vendedores.

---

## Reglas ETL identificadas

- Se conservará el identificador original (**seller_id**) como clave de negocio.
- Se generará una clave sustituta (**SellerKey**) durante el proceso ETL.
- Los nombres de ciudades se estandarizarán para evitar diferencias por mayúsculas o espacios.
- Los estados conservarán su abreviatura oficial.

---

## Decisiones para el Data Warehouse

Este dataset será la fuente principal para construir la dimensión **DimSeller**.

Permitirá almacenar atributos como:

- SellerKey.
- seller_id.
- Ciudad.
- Estado.

Además permitirá construir indicadores como:

- Ventas por estado.
- Ventas por ciudad.
- Participación de vendedores por región.
- Distribución geográfica de las ventas.

---

## Conclusiones

El dataset de vendedores presenta una excelente calidad de datos y permitirá construir la dimensión **DimSeller**, facilitando análisis geográficos y regionales dentro del Data Warehouse.
"""

    generate_markdown_report(
        filename="sellers_analysis.md",
        title="Análisis del Dataset de Vendedores",
        content=report,
    )

    print("\nAnalysis completed successfully.")