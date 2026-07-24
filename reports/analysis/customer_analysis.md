# Análisis del Dataset de Clientes


## Objetivo

Analizar el conjunto de datos de clientes para comprender su estructura,
su calidad de datos y el papel que desempeñará dentro del futuro
Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de registros | 99,441 |
| customer_id únicos | 99,441 |
| customer_unique_id únicos | 96,096 |
| customer_id duplicados | 0 |
| customer_unique_id duplicados | 3,345 |
| Clientes con múltiples compras | 2,997 |

---

## Hallazgos del análisis

- Cada **customer_id** identifica de forma única un registro del dataset.
- El campo **customer_unique_id** representa al cliente real dentro del negocio.
- Un mismo cliente puede realizar múltiples compras a lo largo del tiempo.
- Se identificaron clientes recurrentes, lo que permitirá analizar indicadores de fidelización.

---

## Calidad de los datos

- No se encontraron registros duplicados en **customer_id**.
- No se encontraron valores nulos en las columnas del dataset.
- La calidad de los datos es adecuada para construir una dimensión dentro del Data Warehouse.

---

## Decisión para el Data Warehouse

Con base en el análisis realizado, este conjunto de datos será utilizado para construir la dimensión **DimCustomer**.

**Clave de negocio (Business Key):**

- customer_unique_id

**Clave sustituta (Surrogate Key):**

- customer_key (generada durante el proceso ETL)

La utilización de una clave sustituta permitirá optimizar las relaciones dentro del modelo dimensional y facilitar la administración histórica de los datos.

---

## Conclusiones

El conjunto de datos presenta una excelente calidad de información y permite identificar de manera correcta a los clientes de la plataforma de comercio electrónico.

El análisis confirmó que un mismo cliente puede realizar múltiples compras, razón por la cual la dimensión **DimCustomer** se construirá utilizando **customer_unique_id** como clave de negocio y una **clave sustituta** como llave primaria dentro del Data Warehouse.

Esta decisión facilitará la integración con la tabla de hechos y permitirá desarrollar indicadores relacionados con clientes, recurrencia de compra, ubicación geográfica y comportamiento comercial.
