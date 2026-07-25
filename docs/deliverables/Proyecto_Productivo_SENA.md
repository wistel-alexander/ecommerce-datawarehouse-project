**Proyecto Productivo ADSO -- SENA**

**DISEÑO E IMPLEMENTACIÓN DE UN PIPELINE ETL Y UN DATA WAREHOUSE PARA EL
ANÁLISIS DE DATOS DE COMERCIO ELECTRÓNICO, UTILIZANDO PYTHON, PANDAS Y
SQL SERVER.**

**Wistel Alexander Niño Gil**

**CC. 1012400066**

**Aprendiz -- Tecnólogo en Análisis y Desarrollo de Software**

**Ficha: 2879700**

**Modalidad Virtual**

**Servicio Nacional de Aprendizaje SENA**

**Centro Nacional de Hotelería, Turismo y Alimentos**

**Programa Tecnólogo en Análisis y Desarrollo de Software (ADSO)**

**2026**

**TABLA DE CONTENIDO**

1.  Introducción

2.  Planteamiento del problema

3.  Justificación

4.  Objetivo general

5.  Objetivos específicos

6.  Alcance del proyecto

7.  Marco teórico

8.  Arquitectura del proyecto

9.  Diseño del Data Warehouse

10. Flujo ETL

11. Tecnologías utilizadas

12. KPIs e indicadores analíticos

13. Metodología de desarrollo

14. Cronograma

15. Resultados esperados

16. Conclusiones

17. Implementación técnica del proyecto

18. Bibliografía

    1.  **INTRODUCCIÓN**

Actualmente las organizaciones generan grandes volúmenes de información
provenientes de múltiples fuentes de datos, especialmente en entornos de
comercio electrónico donde diariamente se registran transacciones,
pagos, entregas y comportamiento de clientes. Sin embargo, en muchos
casos esta información no se encuentra integrada ni estructurada
adecuadamente para facilitar procesos de análisis y toma de decisiones.

La ingeniería de datos y los procesos ETL (Extract, Transform and Load)
permiten automatizar la integración, transformación y almacenamiento de
datos, garantizando mayor calidad de la información y facilitando la
construcción de soluciones analíticas empresariales.

El presente proyecto tiene como propósito diseñar e implementar un
pipeline ETL y un Data Warehouse utilizando Python, Pandas y SQL Server
para el procesamiento y análisis de información proveniente del dataset
Brazilian E-Commerce Public Dataset.

El proyecto busca aplicar conceptos de bases de datos, modelado
dimensional, procesamiento de datos y análisis de información,
fortaleciendo competencias relacionadas con el desarrollo de software y
la ingeniería de datos.

2.  **PLANTEAMIENTO DEL PROBLEMA**

Las empresas de comercio electrónico generan diariamente grandes
cantidades de información relacionada con clientes, ventas, productos,
pagos y procesos logísticos. En muchos casos esta información se
encuentra distribuida en diferentes fuentes y formatos, dificultando su
integración y análisis.

La ausencia de procesos automatizados de extracción, transformación y
carga de datos provoca inconsistencias, duplicidad de información y
retrasos en la generación de reportes analíticos. Asimismo, la falta de
un sistema centralizado de almacenamiento limita la capacidad de
realizar análisis históricos y obtener indicadores estratégicos que
apoyen la toma de decisiones.

Debido a esta problemática, surge la necesidad de implementar una
solución de ingeniería de datos que permita integrar, transformar y
almacenar información comercial mediante un Data Warehouse, optimizando
el procesamiento de datos y facilitando el análisis de indicadores
empresariales.

3.  **JUSTIFICACIÓN**

El desarrollo de un pipeline ETL y un Data Warehouse representa una
solución eficiente para la integración y análisis de datos empresariales
dentro de entornos de comercio electrónico.

Mediante el uso de Python, Pandas y SQL Server es posible automatizar
procesos de limpieza, transformación y consolidación de información,
reduciendo errores manuales y mejorando la calidad de los datos.

Este proyecto permite aplicar conocimientos relacionados con:

-   Bases de datos.

-   Ingeniería de datos.

-   Procesos ETL.

-   SQL avanzado.

-   Modelado dimensional.

-   Automatización de procesamiento de datos.

-   Análisis de información.

Adicionalmente, el proyecto fortalece competencias técnicas alineadas
con áreas de alta demanda laboral como Data Engineering, Data Analytics
y Business Intelligence.

La implementación de esta solución permitirá centralizar la información
del negocio y facilitar la generación de indicadores estratégicos para
el análisis comercial y la toma de decisiones.

1.  **OBJETIVO GENERAL**

Diseñar e implementar un pipeline ETL y un Data Warehouse para integrar,
transformar y analizar datos de comercio electrónico utilizando Python,
Pandas y SQL Server.

2.  **OBJETIVOS ESPECÍFICOS**

-   Analizar la estructura y calidad de los datos provenientes del
    dataset de comercio electrónico.

-   Diseñar un modelo dimensional para el almacenamiento de información
    en un Data Warehouse.

-   Desarrollar procesos ETL para la extracción, transformación y carga
    de datos utilizando Python y Pandas.

-   Implementar el Data Warehouse en SQL Server para centralizar la
    información procesada.

-   Generar indicadores y análisis de datos que apoyen la toma de
    decisiones mediante consultas y reportes analíticos.

    1.  **ALCANCE DEL PROYECTO**

El proyecto contempla el desarrollo de un pipeline ETL para procesar
información proveniente del dataset Brazilian E-Commerce Public Dataset,
realizando tareas de extracción, limpieza, transformación y carga de
datos hacia un Data Warehouse implementado en SQL Server.

El sistema incluirá:

-   Procesos automatizados de integración de datos.

-   Validaciones básicas de calidad de información.

-   Almacenamiento estructurado mediante modelo dimensional.

-   Generación de consultas analíticas e indicadores clave de negocio.

-   Registro de logs y control de procesos ETL.

El proyecto no contempla:

-   Desarrollo de aplicaciones web.

-   Procesamiento en tiempo real.

-   Implementación en infraestructura cloud.

-   Integración con APIs externas.

-   Dashboards avanzados en herramientas empresariales BI.

    1.  **MARCO TEÓRICO**

**Ingeniería de Datos**

La ingeniería de datos es una disciplina enfocada en el diseño,
construcción y mantenimiento de sistemas para el procesamiento y
almacenamiento de grandes volúmenes de información.

**ETL (Extract, Transform, Load)**

**Los procesos ETL permiten:**

-   Extraer datos desde diferentes fuentes.

-   Transformar la información mediante reglas de negocio.

-   Cargar los datos en sistemas analíticos.

**Data Warehouse**

Un Data Warehouse es un sistema de almacenamiento diseñado para
facilitar consultas analíticas y generación de reportes empresariales.

**Modelo Estrella**

El modelo estrella es un esquema utilizado en Data Warehousing compuesto
por:

-   Tablas dimensión.

-   Tabla de hechos.

**SQL Server**

Sistema de gestión de bases de datos relacional desarrollado por
Microsoft.

**Python y Pandas**

Herramientas ampliamente utilizadas para procesamiento y análisis de
datos.

1.  **ARQUITECTURA DEL PROYECTO**

**Fuente de datos (CSV Kaggle)**

**↓**

**Capa Raw**

**↓**

**Proceso ETL (Python + Pandas)**

**↓**

**Capa Staging (SQL Server)**

**↓**

**Transformaciones y validaciones**

**↓**

**Data Warehouse**

**↓**

**Consultas analíticas y KPIs**

2.  **DISEÑO DEL DATA WAREHOUSE**

El Data Warehouse será implementado mediante un modelo estrella
compuesto por tablas de dimensiones, y una tabla de hechos.

**Tabla de hechos**

**fact_sales**

Contendrá:

-   ventas,

-   pagos,

-   cantidades,

-   costos de envío,

-   reviews,

-   métricas comerciales.

**Tablas dimensión**

-   dim_customer

-   dim_product

-   dim_seller

-   dim_date

-   dim_payment

    1.  **FLUJO ETL**

**Extract**

Lectura de archivos CSV provenientes del dataset.

**Transform**

Aplicación de reglas de negocio y limpieza de datos:

-   eliminación de duplicados,

-   manejo de nulos,

-   conversión de tipos,

-   normalización,

-   validaciones,

-   creación de columnas derivadas.

**Load**

Carga de información hacia:

-   tablas staging,

-   dimensiones,

-   tabla fact.

    1.  **TECNOLOGÍAS UTILIZADAS**

  -----------------------------------------------------------------------
  **Tecnología**       **Uso**
  -------------------- --------------------------------------------------
  **Python**           Desarrollo ETL (**Lenguaje de Programación**)

  **Pandas**           Procesamiento datos

  **SQL Server**       Data Warehouse

  **SQLAlchemy**       Conexión BD

  **PyODBC**           Driver SQL Server

  **KaggleHub**        Descarga dataset

  **CSV**              Fuente de datos

  **GitHub**           Control versiones
  -----------------------------------------------------------------------

2.  **KPIs E INDICADORES ANALÍTICOS**

El sistema permitirá generar indicadores como:

-   Ventas totales.

-   Ventas mensuales.

-   Ticket promedio.

-   Productos más vendidos.

-   Categorías más rentables.

-   Clientes recurrentes.

-   Tiempo promedio de entrega.

-   Métodos de pago más utilizados.

-   Promedio de reviews.

    1.  **METODOLOGÍA DE DESARROLLO**

**Fase 1**

Análisis del dataset y requerimientos.

**Fase 2**

Diseño arquitectura y DW.

**Fase 3**

Construcción SQL Server.

**Fase 4**

Desarrollo ETL Python.

**Fase 5**

Carga DW.

**Fase 6**

KPIs y consultas.

**Fase 7**

Pruebas y documentación.

2.  **CRONOGRAMA**

  -----------------------------------------------------------------------
  **Fase**     **Actividad**
  ------------ ----------------------------------------------------------
  **1**        Investigación dataset

  **2**        Diseño arquitectura

  **3**        Diseño DW

  **4**        Construcción SQL Server

  **5**        Desarrollo ETL

  **6**        KPIs

  **7**        Validaciones

  **8**        Documentación

  **9**        Sustentación
  -----------------------------------------------------------------------

3.  **RESULTADOS ESPERADOS**

-   Automatizar procesos ETL.

-   Centralizar información comercial.

-   Mejorar calidad de datos.

-   Facilitar análisis estratégicos.

-   Implementar buenas prácticas de ingeniería de datos.

-   Fortalecer competencias técnicas relacionadas con Data Engineering y
    BI.

    1.  **CONCLUSIONES**

La implementación de un pipeline ETL y un Data Warehouse permite
transformar datos dispersos en información estructurada y útil para
análisis empresarial.

El proyecto fortalece conocimientos relacionados con:

-   bases de datos,

-   automatización,

-   SQL,

-   ingeniería de datos,

-   análisis de información.

Asimismo, representa una solución alineada con buenas prácticas
utilizadas en entornos profesionales.

1.  **IMPLEMENTACIÓN TÉCNICA DEL PROYECTO**

**Estructura general**

project/\
│\
├── datasets/\
├── etl/\
├── sql/\
├── notebooks/\
├── reports/\
├── docs/\
├── tests/\
│\
├── config.py\
├── main.py\
├── requirements.txt\
└── README.md

**Dataset**

El proyecto utilizará el:\
Brazilian E-Commerce Public Dataset.

La extracción podrá realizarse:

-   mediante KaggleHub,

-   o mediante archivos CSV descargados localmente.

**Tecnologías principales**

-   Python

-   Pandas

-   SQL Server

-   SQLAlchemy

-   PyODBC

    18. **BIBLIOGRAFÍA**

```{=html}
<!-- -->
```
-   Kimball, R. Data Warehouse Toolkit.

Microsoft Documentation -- SQL Server. (Microsoft, s.f.)

-   Python Documentation. (https://docs.python.org, s.f.)

-   Pandas Documentation. (https://pandas.pydata.org, s.f.)

-   Brazilian E-Commerce Public Dataset -- Kaggle.
    (https://www.kaggle.com, s.f.)

-   SQLAlchemy Documentation. (https://docs.sqlalchemy.org, s.f.)

-   PyODBC Documentation. (https://pypi.org, s.f.)
