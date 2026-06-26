# 01. Comprensión del Negocio (Business Understanding)

## 1. Introducción

El presente proyecto tiene como objetivo diseñar e implementar un proceso ETL (Extract, Transform and Load) utilizando Python (Pandas) y SQL Server para construir un Data Warehouse a partir del conjunto de datos **Brazilian E-Commerce Public Dataset by Olist**.

El proyecto se desarrolla como opción de **Proyecto Productivo** para la etapa práctica del programa **Tecnólogo en Análisis y Desarrollo de Software (ADSO)** del SENA.

El propósito principal es transformar datos transaccionales en información analítica que permita generar indicadores de negocio (KPIs) y facilitar la toma de decisiones.

---

# 2. Contexto del Negocio

Olist es una plataforma de comercio electrónico que conecta clientes, vendedores y productos dentro de un marketplace.

Durante el proceso de compra se generan diferentes tipos de información:

* Registro de clientes.
* Creación de pedidos.
* Productos comprados.
* Vendedores involucrados.
* Pagos realizados.
* Calificaciones posteriores a la compra.

Toda esta información representa el funcionamiento diario de una empresa de comercio electrónico.

---

# 3. Problema de Negocio

Los datos operacionales se encuentran distribuidos en múltiples archivos CSV independientes.

Aunque contienen información valiosa, no están organizados para realizar análisis históricos ni generar indicadores estratégicos de manera eficiente.

Como consecuencia:

* Es difícil responder preguntas de negocio.
* No existe una estructura analítica centralizada.
* La generación de reportes requiere consultar múltiples archivos.
* No hay un modelo dimensional para apoyar la toma de decisiones.

---

# 4. Objetivo del Proyecto

Construir un proceso ETL que permita extraer, transformar y cargar la información del dataset hacia un Data Warehouse diseñado bajo un modelo dimensional, facilitando el análisis de ventas, clientes, productos y vendedores.

---

# 5. Descripción General del Dataset

El proyecto utiliza el conjunto de datos **Brazilian E-Commerce Public Dataset**, el cual contiene información histórica de pedidos realizados en una plataforma de comercio electrónico brasileña.

El dataset está compuesto por diferentes archivos CSV que representan las entidades principales del negocio.

| Dataset                      | Descripción                                |
| ---------------------------- | ------------------------------------------ |
| olist_customers_dataset      | Información de los clientes                |
| olist_orders_dataset         | Información de los pedidos                 |
| olist_order_items_dataset    | Productos incluidos en cada pedido         |
| olist_products_dataset       | Catálogo de productos                      |
| olist_sellers_dataset        | Información de los vendedores              |
| olist_order_payments_dataset | Información de los pagos                   |
| olist_order_reviews_dataset  | Calificaciones realizadas por los clientes |

---

# 6. Flujo General del Negocio

El comportamiento del negocio puede resumirse de la siguiente manera:

1. Un cliente realiza un pedido.
2. El pedido puede contener uno o varios productos.
3. Cada producto pertenece a un vendedor.
4. El cliente realiza uno o varios pagos.
5. Una vez finalizada la compra, el cliente puede dejar una reseña calificando su experiencia.

Este flujo representa el proceso transaccional principal que posteriormente será transformado en un modelo analítico.

---

# 7. Entidades Principales Identificadas

Durante el análisis inicial se identificaron las siguientes entidades:

* Clientes (Customers)
* Pedidos (Orders)
* Productos (Products)
* Vendedores (Sellers)
* Detalle de pedidos (Order Items)
* Pagos (Order Payments)
* Reseñas (Order Reviews)

Estas entidades serán utilizadas posteriormente para diseñar el modelo relacional y el modelo dimensional del Data Warehouse.

---

# 8. Resultado Esperado

Al finalizar el proyecto se dispondrá de:

* Un proceso ETL automatizado desarrollado en Python.
* Una base de datos Data Warehouse implementada en SQL Server.
* Un modelo dimensional (Esquema Estrella).
* Indicadores de negocio (KPIs).
* Reportes analíticos basados en información consolidada.

Este proyecto busca aplicar buenas prácticas de ingeniería de datos, arquitectura de datos y análisis de información, simulando un entorno real de desarrollo empresarial.
491257163