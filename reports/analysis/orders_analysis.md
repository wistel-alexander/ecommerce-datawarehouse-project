# Análisis del Dataset de Pedidos


## Objetivo

Analizar el conjunto de datos de pedidos para comprender su estructura,
su calidad de datos y su importancia dentro del futuro Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de pedidos | 99,441 |
| order_id únicos | 99,441 |
| order_id duplicados | 0 |
| Fechas de aprobación nulas | 160 |
| Fechas de entrega al transportista nulas | 1,783 |
| Fechas de entrega al cliente nulas | 2,965 |

---

## Distribución de Estados

| order_status   |   count |
|:---------------|--------:|
| delivered      |   96478 |
| shipped        |    1107 |
| canceled       |     625 |
| unavailable    |     609 |
| invoiced       |     314 |
| processing     |     301 |
| created        |       5 |
| approved       |       2 |

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
