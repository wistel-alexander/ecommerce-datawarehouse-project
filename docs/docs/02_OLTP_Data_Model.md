# 02. Modelo de Datos Transaccional (OLTP)

## 1. Introducción

Antes de diseñar un Data Warehouse es necesario comprender el modelo de datos operacional (OLTP) del negocio.

El dataset Brazilian E-Commerce Public Dataset está compuesto por varios archivos CSV relacionados entre sí, los cuales representan el funcionamiento diario de una plataforma de comercio electrónico.

Cada archivo representa una entidad del negocio y mantiene relaciones con otras entidades mediante identificadores únicos.

El objetivo de este análisis es identificar dichas relaciones para construir posteriormente un modelo dimensional (Esquema Estrella).

---

# 2. Entidades del Sistema

Durante el análisis del dataset se identificaron las siguientes entidades principales.

| Entidad        | Archivo CSV                      | Descripción                                |
| -------------- | -------------------------------- | ------------------------------------------ |
| Customers      | olist_customers_dataset.csv      | Información de los clientes                |
| Orders         | olist_orders_dataset.csv         | Pedidos realizados                         |
| Order Items    | olist_order_items_dataset.csv    | Productos incluidos en cada pedido         |
| Products       | olist_products_dataset.csv       | Catálogo de productos                      |
| Sellers        | olist_sellers_dataset.csv        | Información de vendedores                  |
| Order Payments | olist_order_payments_dataset.csv | Información de pagos                       |
| Order Reviews  | olist_order_reviews_dataset.csv  | Calificaciones realizadas por los clientes |

---

# 3. Llaves Primarias

Las siguientes columnas identifican de forma única cada entidad.

| Tabla         | Llave Primaria |
| ------------- | -------------- |
| Customers     | customer_id    |
| Orders        | order_id       |
| Products      | product_id     |
| Sellers       | seller_id      |
| Order Reviews | review_id      |

### Caso especial

La tabla **Order Items** utiliza una llave primaria compuesta por:

* order_id
* order_item_id

Esto se debe a que un mismo pedido puede contener varios productos.

---

# 4. Llaves Foráneas

Las relaciones identificadas son las siguientes.

| Tabla          | Llave Foránea | Referencia |
| -------------- | ------------- | ---------- |
| Orders         | customer_id   | Customers  |
| Order Items    | order_id      | Orders     |
| Order Items    | product_id    | Products   |
| Order Items    | seller_id     | Sellers    |
| Order Payments | order_id      | Orders     |
| Order Reviews  | order_id      | Orders     |

---

# 5. Relaciones entre las Entidades

Las principales relaciones identificadas son:

Customers (1) -------- (N) Orders

Orders (1) -------- (N) Order Items

Products (1) -------- (N) Order Items

Sellers (1) -------- (N) Order Items

Orders (1) -------- (N) Order Payments

Orders (1) -------- (N) Order Reviews

---

# 6. Flujo del Negocio

El comportamiento del negocio puede representarse mediante el siguiente flujo:

Cliente

↓

Pedido

↓

Detalle del Pedido

↓

Producto

↓

Vendedor

↓

Pago

↓

Reseña

Este flujo representa el ciclo completo de una compra dentro de la plataforma.

---

# 7. Conclusiones

El modelo transaccional presenta una estructura altamente normalizada, donde cada entidad almacena información específica del proceso de compra.

Este diseño es adecuado para soportar las operaciones diarias del negocio, pero no resulta óptimo para realizar consultas analíticas complejas.

Por esta razón, en la siguiente fase del proyecto se diseñará un modelo dimensional (Data Warehouse) que facilite el análisis histórico de la información y el cálculo de indicadores de negocio (KPIs).

