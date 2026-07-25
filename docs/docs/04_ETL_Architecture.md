# 01. Arquitectura del Proceso ETL

## 1. Introducción

El proceso ETL (Extract, Transform and Load) constituye el componente principal de este proyecto de Ingeniería de Datos. Su propósito es extraer la información del conjunto de datos **Brazilian E-Commerce Public Dataset by Olist**, transformarla mediante reglas de negocio previamente definidas y cargarla en un Data Warehouse implementado en SQL Server.

La arquitectura propuesta busca garantizar la calidad, consistencia e integridad de los datos antes de su almacenamiento, permitiendo posteriormente la construcción de indicadores de negocio y dashboards analíticos en Power BI.

El proceso fue diseñado siguiendo una arquitectura modular desarrollada en Python, donde cada etapa del ETL se encuentra separada en componentes independientes para facilitar su mantenimiento, reutilización y escalabilidad.

## 2. Objetivo del proceso ETL

El objetivo del proceso ETL es integrar la información proveniente de múltiples archivos CSV en un único modelo dimensional optimizado para el análisis de datos.

Durante este proceso se realizarán actividades de extracción, validación, limpieza, transformación y carga de la información, garantizando que los datos almacenados en el Data Warehouse sean consistentes, confiables y adecuados para apoyar la toma de decisiones.

Como resultado del proceso ETL se obtendrá una base de datos analítica organizada mediante un esquema estrella (Star Schema), facilitando la construcción de consultas, indicadores y reportes empresariales.

## 3. Arquitectura General

La arquitectura del proceso ETL sigue un flujo secuencial en el que los datos atraviesan diferentes etapas antes de llegar al Data Warehouse.

Cada fase tiene una responsabilidad específica dentro del proceso de integración de datos.

```

```text
            Archivos CSV (Raw Data)
                     │
                     ▼
            Extracción de Datos
                     │
                     ▼
           Validación y Perfilamiento
                     │
                     ▼
         Limpieza y Transformación
                     │
                     ▼
       Generación de Claves Sustitutas
                     │
                     ▼
          Carga de Dimensiones
                     │
                     ▼
        Carga de la Tabla FactSales
                     │
                     ▼
      SQL Server Data Warehouse
                     │
                     ▼
          Dashboards en Power BI
```

```markdown

Esta arquitectura permite mantener separadas las diferentes responsabilidades del proceso ETL, facilitando la detección de errores, la reutilización del código y el mantenimiento del sistema.

## 4. Fase de Extracción (Extract)

La fase de extracción corresponde al primer paso del proceso ETL y consiste en la lectura de los archivos CSV originales del dataset **Brazilian E-Commerce Public Dataset by Olist**.

Los archivos se almacenan en la carpeta `datasets/raw`, desde donde son leídos utilizando la biblioteca **Pandas** de Python.

Para facilitar el mantenimiento del proyecto, todas las rutas de acceso a los datos se encuentran centralizadas en el archivo `config.py`, evitando el uso de rutas fijas dentro del código.

Durante esta etapa no se realizan modificaciones sobre los datos; únicamente se cargan en memoria para su posterior validación y transformación.

Los archivos utilizados durante el proceso de extracción son:

- olist_customers_dataset.csv
- olist_orders_dataset.csv
- olist_order_items_dataset.csv
- olist_order_payments_dataset.csv
- olist_order_reviews_dataset.csv
- olist_products_dataset.csv
- olist_sellers_dataset.csv

La separación entre los datos originales y los datos procesados permite conservar una copia íntegra del dataset, garantizando la trazabilidad de la información durante todo el proceso ETL.

## 5. Fase de Transformación (Transform)

La fase de transformación tiene como objetivo preparar los datos antes de su carga al Data Warehouse.

Durante esta etapa se aplican diferentes reglas de negocio identificadas durante el análisis exploratorio de los datos (EDA) y el perfilamiento de los datasets.

Las principales transformaciones realizadas son:

- Validación de registros duplicados.
- Identificación de valores nulos.
- Estandarización de nombres de columnas.
- Conservación de las claves de negocio (Business Keys).
- Generación de claves sustitutas (Surrogate Keys) para las dimensiones.
- Preparación de los datos para el modelo dimensional.
- Validación de tipos de datos.
- Consolidación de la información proveniente de múltiples datasets.

Estas transformaciones garantizan la consistencia de la información antes de su almacenamiento en el Data Warehouse y permiten construir un modelo optimizado para consultas analíticas.

## 6. Fase de Carga (Load)

Una vez transformados los datos, se realiza la carga hacia el Data Warehouse implementado en SQL Server.

La carga sigue un orden específico para mantener la integridad referencial entre las tablas.

El proceso inicia con la carga de las dimensiones:

1. DimDate
2. DimCustomer
3. DimProduct
4. DimSeller

Posteriormente se carga la tabla de hechos **FactSales**, utilizando las claves sustitutas generadas previamente para establecer las relaciones con cada dimensión.

Esta estrategia garantiza que todas las referencias existan antes de insertar los registros de la tabla de hechos, evitando inconsistencias en el modelo dimensional.

## 7. Flujo General del ETL

El proceso ETL desarrollado en este proyecto sigue el siguiente flujo de ejecución:

```text
Datasets CSV
      │
      ▼
Extracción de Datos
      │
      ▼
Perfilamiento y Validación
      │
      ▼
Transformación
      │
      ▼
Carga de Dimensiones
      │
      ▼
Carga de FactSales
      │
      ▼
SQL Server Data Warehouse
      │
      ▼
Power BI
```

Cada una de estas etapas se implementa mediante módulos independientes en Python, permitiendo un desarrollo organizado, reutilizable y fácil de mantener.

## 8. Resultado Esperado

Al finalizar el proceso ETL se obtiene un Data Warehouse estructurado bajo un modelo dimensional tipo Star Schema, con información consistente, integrada y preparada para el análisis de datos.

La arquitectura implementada facilita la construcción de indicadores de negocio, consultas analíticas y dashboards interactivos en Power BI, permitiendo transformar los datos transaccionales en información útil para la toma de decisiones.

Además, el diseño modular del proceso ETL facilita futuras mejoras, como la incorporación de nuevos datasets, automatización de cargas o implementación de procesos incrementales.

