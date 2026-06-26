# Dataset Profiling Report

Reporte generado automáticamente por el proyecto ETL.

## olist_customers_dataset.csv

- Filas: 99441
- Columnas: 5
- Duplicados: 0
- Memoria: 26.59 MB

### Columnas

- **customer_id** | Tipo: `str` | Nulos: 0
- **customer_unique_id** | Tipo: `str` | Nulos: 0
- **customer_zip_code_prefix** | Tipo: `int64` | Nulos: 0
- **customer_city** | Tipo: `str` | Nulos: 0
- **customer_state** | Tipo: `str` | Nulos: 0

---

## olist_order_items_dataset.csv

- Filas: 112650
- Columnas: 7
- Duplicados: 0
- Memoria: 35.99 MB

### Columnas

- **order_id** | Tipo: `str` | Nulos: 0
- **order_item_id** | Tipo: `int64` | Nulos: 0
- **product_id** | Tipo: `str` | Nulos: 0
- **seller_id** | Tipo: `str` | Nulos: 0
- **shipping_limit_date** | Tipo: `str` | Nulos: 0
- **price** | Tipo: `float64` | Nulos: 0
- **freight_value** | Tipo: `float64` | Nulos: 0

---

## olist_order_payments_dataset.csv

- Filas: 103886
- Columnas: 5
- Duplicados: 0
- Memoria: 16.23 MB

### Columnas

- **order_id** | Tipo: `str` | Nulos: 0
- **payment_sequential** | Tipo: `int64` | Nulos: 0
- **payment_type** | Tipo: `str` | Nulos: 0
- **payment_installments** | Tipo: `int64` | Nulos: 0
- **payment_value** | Tipo: `float64` | Nulos: 0

---

## olist_order_reviews_dataset.csv

- Filas: 99224
- Columnas: 7
- Duplicados: 0
- Memoria: 39.12 MB

### Columnas

- **review_id** | Tipo: `str` | Nulos: 0
- **order_id** | Tipo: `str` | Nulos: 0
- **review_score** | Tipo: `int64` | Nulos: 0
- **review_comment_title** | Tipo: `str` | Nulos: 87656
- **review_comment_message** | Tipo: `str` | Nulos: 58247
- **review_creation_date** | Tipo: `str` | Nulos: 0
- **review_answer_timestamp** | Tipo: `str` | Nulos: 0

---

## olist_orders_dataset.csv

- Filas: 99441
- Columnas: 8
- Duplicados: 0
- Memoria: 52.94 MB

### Columnas

- **order_id** | Tipo: `str` | Nulos: 0
- **customer_id** | Tipo: `str` | Nulos: 0
- **order_status** | Tipo: `str` | Nulos: 0
- **order_purchase_timestamp** | Tipo: `str` | Nulos: 0
- **order_approved_at** | Tipo: `str` | Nulos: 160
- **order_delivered_carrier_date** | Tipo: `str` | Nulos: 1783
- **order_delivered_customer_date** | Tipo: `str` | Nulos: 2965
- **order_estimated_delivery_date** | Tipo: `str` | Nulos: 0

---

## olist_products_dataset.csv

- Filas: 32951
- Columnas: 9
- Duplicados: 0
- Memoria: 6.3 MB

### Columnas

- **product_id** | Tipo: `str` | Nulos: 0
- **product_category_name** | Tipo: `str` | Nulos: 610
- **product_name_lenght** | Tipo: `float64` | Nulos: 610
- **product_description_lenght** | Tipo: `float64` | Nulos: 610
- **product_photos_qty** | Tipo: `float64` | Nulos: 610
- **product_weight_g** | Tipo: `float64` | Nulos: 2
- **product_length_cm** | Tipo: `float64` | Nulos: 2
- **product_height_cm** | Tipo: `float64` | Nulos: 2
- **product_width_cm** | Tipo: `float64` | Nulos: 2

---

## olist_sellers_dataset.csv

- Filas: 3095
- Columnas: 4
- Duplicados: 0
- Memoria: 0.59 MB

### Columnas

- **seller_id** | Tipo: `str` | Nulos: 0
- **seller_zip_code_prefix** | Tipo: `int64` | Nulos: 0
- **seller_city** | Tipo: `str` | Nulos: 0
- **seller_state** | Tipo: `str` | Nulos: 0

---
