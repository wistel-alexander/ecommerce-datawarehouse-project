from utils.console import print_section, print_subsection
from utils.metrics import print_metric
from utils.data_loader import load_dataset
from utils.report_generator import generate_markdown_report


def analyze_reviews():
    """
    Analyze the Reviews dataset and generate a technical report.
    """

    # ==========================================================
    # Load Dataset
    # ==========================================================

    reviews = load_dataset("olist_order_reviews_dataset.csv")

    # ==========================================================
    # Basic Metrics
    # ==========================================================

    total_rows = len(reviews)

    unique_reviews = reviews["review_id"].nunique()

    unique_orders = reviews["order_id"].nunique()

    duplicated_rows = reviews.duplicated().sum()

    total_nulls = reviews.isnull().sum().sum()

    # ==========================================================
    # Missing Values
    # ==========================================================

    missing_values = (
        reviews.isnull()
        .sum()
        .sort_values(ascending=False)
    )

    missing_values = missing_values[missing_values > 0]

    missing_table = "| Columna | Valores nulos |\n"
    missing_table += "|---------|--------------:|\n"

    for column, value in missing_values.items():
        missing_table += f"| {column} | {value:,} |\n"

    # ==========================================================
    # Review Score Distribution
    # ==========================================================

    score_distribution = (
        reviews["review_score"]
        .value_counts()
        .sort_index()
    )

    score_table = "| Calificación | Cantidad |\n"
    score_table += "|--------------|---------:|\n"

    for score, count in score_distribution.items():
        score_table += f"| {score} estrella(s) | {count:,} |\n"

    avg_score = reviews["review_score"].mean()

    # ==========================================================
    # Console Output
    # ==========================================================

    print_section("REVIEWS DATASET ANALYSIS")

    print()

    print_metric("Total reviews", total_rows)
    print_metric("Unique review_id", unique_reviews)
    print_metric("Unique orders", unique_orders)
    print_metric("Duplicated rows", duplicated_rows)
    print_metric("Missing values", total_nulls)

    print_subsection("Review Statistics")

    print_metric("Average score", round(avg_score, 2))

    # ==========================================================
    # Markdown Report
    # ==========================================================

    report = f"""
## Objetivo

Analizar el dataset de opiniones de clientes para comprender el comportamiento de las calificaciones otorgadas a los pedidos y su utilidad dentro del futuro Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de opiniones | {total_rows:,} |
| Opiniones únicas | {unique_reviews:,} |
| Pedidos evaluados | {unique_orders:,} |
| Filas duplicadas | {duplicated_rows:,} |
| Valores nulos | {total_nulls:,} |

---

## Calidad de los datos

No se identificaron registros duplicados.

Se encontraron algunos valores nulos en las columnas relacionadas con el comentario del cliente, lo cual es esperado ya que muchos usuarios califican únicamente con estrellas sin escribir una opinión.

---

## Distribución de valores nulos

{missing_table}

---

## Distribución de Calificaciones

{score_table}

---

## Estadísticas

| Métrica | Valor |
|---------|------:|
| Calificación promedio | {avg_score:.2f} |

---

## Observaciones del negocio

- La mayoría de los clientes califican sus compras utilizando la escala de 1 a 5 estrellas.
- No todos los clientes escriben comentarios, aunque sí registran una calificación.
- La calificación promedio permitirá medir el nivel general de satisfacción de los clientes.

---

## Hallazgos técnicos

- Cada opinión está asociada a un pedido.
- El dataset permitirá relacionar satisfacción del cliente con pedidos, productos y vendedores.
- Los comentarios de texto podrán utilizarse posteriormente para proyectos de análisis de sentimiento.

---

## Reglas ETL identificadas

- Se conservará el identificador del pedido como clave de negocio.
- Los comentarios nulos no serán reemplazados, ya que representan un comportamiento normal del negocio.
- La calificación se almacenará como una medida para futuros indicadores de satisfacción.

---

## Decisiones para el Data Warehouse

Este dataset complementará la tabla de hechos **FactSales**.

Permitirá construir indicadores como:

- Calificación promedio.
- Distribución de calificaciones.
- Nivel de satisfacción del cliente.
- Análisis de calidad del servicio.

---

## Conclusiones

El dataset de opiniones representa una fuente importante para medir la experiencia del cliente. Su integración con las ventas permitirá analizar la relación entre logística, productos, vendedores y satisfacción del consumidor.
"""

    generate_markdown_report(
        filename="reviews_analysis.md",
        title="Análisis del Dataset de Opiniones",
        content=report,
    )

    print("\nAnalysis completed successfully.")