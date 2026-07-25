# Análisis del Dataset de Productos


## Objetivo

Analizar el dataset de productos para comprender la información descriptiva y física de los artículos comercializados, así como su importancia dentro del futuro Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de productos | 32,951 |
| Productos únicos | 32,951 |
| Filas duplicadas | 0 |
| Valores nulos | 2,448 |
| Categorías sin información | 610 |

---

## Calidad de los datos

No se identificaron registros duplicados.

Se encontraron valores nulos principalmente en la categoría del producto y en algunas características físicas. Estos registros deberán evaluarse durante la fase de transformación (ETL).

---

## Distribución de valores nulos

| Columna | Valores nulos |
|---------|--------------:|
| product_category_name | 610 |
| product_name_lenght | 610 |
| product_description_lenght | 610 |
| product_photos_qty | 610 |
| product_weight_g | 2 |
| product_length_cm | 2 |
| product_height_cm | 2 |
| product_width_cm | 2 |


---

## Estadísticas Físicas

| Métrica | Valor |
|---------|------:|
| Peso promedio (g) | 2276.47 |
| Longitud promedio (cm) | 30.82 |
| Altura promedio (cm) | 16.94 |
| Anchura promedio (cm) | 23.20 |

---

## Hallazgos del análisis

- Cada producto posee un identificador único.
- La mayoría de los productos cuentan con información física completa.
- Existen 610 productos sin categoría asignada.
- Solo dos productos presentan información física incompleta, lo que representa una proporción mínima respecto al total del dataset y facilita su tratamiento durante el proceso ETL.
- La información física permitirá realizar análisis relacionados con logística y transporte.

---

## Reglas ETL identificadas

- Los productos sin categoría deberán asignarse a una categoría estándar como **"Unknown"** durante la transformación.
- Los valores nulos en las dimensiones físicas deberán revisarse antes de la carga al Data Warehouse.
- Se conservarán los tipos de datos numéricos para facilitar cálculos posteriores.
- Se conservará el identificador original (**product_id**) como clave de negocio para la construcción de la dimensión **DimProduct**.

---

## Decisiones para el Data Warehouse

Este dataset será la fuente para construir la dimensión **DimProduct**.

Permitirá almacenar atributos como:

- ProductKey (clave sustituta generada durante el proceso ETL).
- Identificador del producto (clave de negocio).
- Categoría del producto.
- Peso.
- Longitud.
- Altura.
- Anchura.

---

## Conclusiones

El dataset contiene la información descriptiva de los productos comercializados y permitirá construir la dimensión **DimProduct** del Data Warehouse. Los pocos valores nulos identificados no afectan significativamente la calidad del conjunto de datos, pero deberán tratarse mediante reglas definidas durante el proceso ETL.
