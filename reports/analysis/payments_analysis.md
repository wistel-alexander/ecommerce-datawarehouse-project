# Análisis del Dataset de Pagos


## Objetivo

Analizar el dataset de pagos para comprender el comportamiento de los métodos de pago utilizados por los clientes y su importancia dentro del futuro Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de registros | 103,886 |
| Pedidos únicos | 99,440 |
| Filas duplicadas | 0 |
| Valores nulos | 0 |

---

## Calidad de los datos

No se identificaron registros duplicados ni valores nulos.

La estructura del dataset es consistente y adecuada para los procesos ETL.

---

## Distribución de Métodos de Pago

| Tipo de pago | Cantidad |
|--------------|---------:|
| credit_card | 76,795 |
| boleto | 19,784 |
| voucher | 5,775 |
| debit_card | 1,529 |
| not_defined | 3 |


---

## Estadísticas de Pago

| Métrica | Valor |
|---------|------:|
| Pago mínimo | 0.00 |
| Pago promedio | 154.10 |
| Pago máximo | 13664.08 |
| Cuotas promedio | 2.85 |
| Máximo número de cuotas | 24 |

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
