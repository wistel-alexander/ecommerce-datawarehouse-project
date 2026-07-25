from utils.console import print_section, print_subsection
from utils.metrics import print_metric
from utils.data_loader import load_dataset
from utils.report_generator import generate_markdown_report


def analyze_payments():
    """
    Analyze the Payments dataset and generate a technical report.
    """

    # ==========================================================
    # Load Dataset
    # ==========================================================

    payments = load_dataset("olist_order_payments_dataset.csv")

    # ==========================================================
    # Basic Metrics
    # ==========================================================

    total_rows = len(payments)

    unique_orders = payments["order_id"].nunique()

    duplicated_rows = payments.duplicated().sum()

    total_nulls = payments.isnull().sum().sum()

    # ==========================================================
    # Payment Statistics
    # ==========================================================

    min_payment = payments["payment_value"].min()

    avg_payment = payments["payment_value"].mean()

    max_payment = payments["payment_value"].max()

    max_installments = payments["payment_installments"].max()

    avg_installments = payments["payment_installments"].mean()

    # ==========================================================
    # Payment Types
    # ==========================================================

    payment_types = (
        payments["payment_type"]
        .value_counts()
    )

    payment_table = "| Tipo de pago | Cantidad |\n"
    payment_table += "|--------------|---------:|\n"

    for payment, count in payment_types.items():
        payment_table += f"| {payment} | {count:,} |\n"

    # ==========================================================
    # Console Output
    # ==========================================================

    print_section("PAYMENTS DATASET ANALYSIS")

    print()

    print_metric("Total records", total_rows)
    print_metric("Unique orders", unique_orders)
    print_metric("Duplicated rows", duplicated_rows)
    print_metric("Missing values", total_nulls)

    print_subsection("Payment Statistics")

    print_metric("Minimum payment", round(min_payment, 2))
    print_metric("Average payment", round(avg_payment, 2))
    print_metric("Maximum payment", round(max_payment, 2))
    print_metric("Average installments", round(avg_installments, 2))
    print_metric("Maximum installments", max_installments)

    # ==========================================================
    # Markdown Report
    # ==========================================================

    report = f"""
## Objetivo

Analizar el dataset de pagos para comprender el comportamiento de los métodos de pago utilizados por los clientes y su importancia dentro del futuro Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de registros | {total_rows:,} |
| Pedidos únicos | {unique_orders:,} |
| Filas duplicadas | {duplicated_rows:,} |
| Valores nulos | {total_nulls:,} |

---

## Calidad de los datos

No se identificaron registros duplicados ni valores nulos.

La estructura del dataset es consistente y adecuada para los procesos ETL.

---

## Distribución de Métodos de Pago

{payment_table}

---

## Estadísticas de Pago

| Métrica | Valor |
|---------|------:|
| Pago mínimo | {min_payment:.2f} |
| Pago promedio | {avg_payment:.2f} |
| Pago máximo | {max_payment:.2f} |
| Cuotas promedio | {avg_installments:.2f} |
| Máximo número de cuotas | {max_installments} |

---

## Hallazgos del análisis

- Cada registro representa un pago asociado a un pedido.
- Un pedido puede estar compuesto por uno o varios pagos.
- El método de pago más utilizado es la tarjeta de crédito.
- El dataset permitirá analizar el comportamiento de pago de los clientes.

---

## Reglas ETL identificadas

- Se conservará el identificador del pedido (**order_id**) como clave de negocio.
- Los valores monetarios mantendrán su precisión durante la carga al Data Warehouse.
- Los tipos de pago se normalizarán para garantizar consistencia analítica.
- El número de cuotas permitirá construir indicadores financieros.

---

## Decisiones para el Data Warehouse

Este dataset complementará la tabla de hechos **FactSales**.

Permitirá almacenar información relacionada con:

- Valor pagado.
- Método de pago.
- Número de cuotas.
- Secuencia de pago.
- Indicadores financieros asociados a cada venta.

---

## Conclusiones

El dataset proporciona la información financiera de las ventas y permitirá enriquecer la tabla de hechos del Data Warehouse con indicadores relacionados con los pagos realizados por los clientes.
"""

    generate_markdown_report(
        filename="payments_analysis.md",
        title="Análisis del Dataset de Pagos",
        content=report,
    )

    print("\nAnalysis completed successfully.")