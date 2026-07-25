# Análisis del Dataset de Ítems de Pedido


## Objetivo

Analizar el dataset de los ítems de pedido para comprender la estructura de las ventas, la relación entre pedidos, productos y vendedores, y su importancia dentro del futuro Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de registros | 112,650 |
| Pedidos únicos | 98,666 |
| Productos únicos | 32,951 |
| Vendedores únicos | 3,095 |
| Filas duplicadas | 0 |
| Valores nulos | 0 |

---

## Calidad de los datos

No se identificaron registros duplicados ni valores nulos.

La estructura del dataset es consistente y adecuada para los procesos ETL.

---

## Estadísticas de Precios

| Métrica | Valor |
|---------|------:|
| Precio mínimo | 0.85 |
| Precio promedio | 120.65 |
| Precio máximo | 6735.00 |

---

## Estadísticas del Flete

| Métrica | Valor |
|---------|------:|
| Flete mínimo | 0.00 |
| Flete promedio | 19.99 |
| Flete máximo | 409.68 |

---

## Hallazgos del análisis

- Cada registro representa un producto específico incluido dentro de un pedido.
- Un pedido puede contener uno o varios productos.
- Un vendedor puede participar en múltiples pedidos.
- El dataset contiene la información monetaria de cada producto vendido.
- Se identificó que existen **112,650 registros** para **98,666 pedidos**, lo que confirma que un pedido puede contener múltiples productos. Esta característica determinará la granularidad de la futura tabla de hechos del Data Warehouse.

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
