# Guía para la Sustentación del Proyecto Productivo

## Ecommerce Data Warehouse

Esta guía sirve como apoyo para preparar y realizar la sustentación del proyecto ante el SENA. El objetivo es explicar con claridad el problema, la solución desarrollada, las tecnologías utilizadas, el funcionamiento del proceso y los resultados obtenidos.

La sustentación no consiste en leer todos los archivos del proyecto. Consiste en demostrar que se comprende la necesidad de negocio, que se sabe explicar la arquitectura y que se puede mostrar el funcionamiento de la solución.

## 1. Objetivo de la sustentación

Durante la presentación se debe demostrar que el proyecto:

- Resuelve una necesidad relacionada con el análisis de información de un comercio electrónico.
- Integra diferentes fuentes de datos.
- Aplica un proceso de extracción, transformación y carga.
- Organiza la información en un Data Warehouse.
- Permite consultar indicadores de negocio.
- Presenta los resultados mediante dashboards en Power BI.
- Fue desarrollado aplicando los conocimientos adquiridos durante la formación ADSO.

## 2. Duración sugerida

Una presentación de entre 15 y 25 minutos puede organizarse así:

| Tiempo | Tema |
|---:|---|
| 2 minutos | Presentación personal y contexto del proyecto. |
| 3 minutos | Problema, justificación y objetivos. |
| 4 minutos | Fuentes de datos y proceso ETL. |
| 4 minutos | Modelo dimensional y Data Warehouse. |
| 6 minutos | Demostración de los dashboards. |
| 3 minutos | Resultados, aprendizajes y cierre. |
|

La duración puede adaptarse a las indicaciones del instructor o del jurado.

## 3. Presentación inicial

Puedes comenzar con un discurso similar al siguiente:

> Buenos días/tardes. Mi nombre es [nombre del aprendiz] y presentaré mi proyecto productivo denominado Ecommerce Data Warehouse. El proyecto fue desarrollado como una solución de ingeniería de datos para integrar y analizar información de comercio electrónico. Para su construcción utilicé Python, Pandas, SQL Server y Power BI, aplicando conceptos de bases de datos, procesos ETL, modelado dimensional y visualización de información.

Después, presenta brevemente el contexto:

> La fuente utilizada es el Brazilian E-Commerce Public Dataset by Olist, que contiene información de clientes, pedidos, productos, vendedores, pagos y reseñas. El reto consistió en transformar estos archivos independientes en información organizada y útil para el análisis del negocio.

## 4. Explicación del problema

El problema puede explicarse de forma sencilla:

> Los datos originales se encuentran distribuidos en varios archivos CSV. Consultar la información directamente desde esos archivos dificulta realizar análisis históricos, comparar resultados y construir indicadores. Por esta razón fue necesario diseñar un proceso que integrara los datos y los organizara para facilitar la toma de decisiones.

Puedes mencionar las principales dificultades del escenario original:

- La información está separada en diferentes archivos.
- Las entidades tienen relaciones entre sí.
- Los datos operacionales no están preparados para consultas analíticas.
- La elaboración de reportes manuales requiere consultar varias fuentes.
- Es necesario contar con indicadores consolidados para interpretar el comportamiento de las ventas.

## 5. Objetivo general y objetivos específicos

### Objetivo general

> Diseñar e implementar un proceso ETL para integrar la información del comercio electrónico Olist en un Data Warehouse dimensional y presentar indicadores de negocio mediante dashboards en Power BI.

### Objetivos específicos

- Analizar y perfilar los archivos originales.
- Identificar las entidades, relaciones y reglas principales del negocio.
- Construir una capa de staging en SQL Server.
- Diseñar un modelo dimensional tipo estrella.
- Cargar las dimensiones y la tabla de hechos de ventas.
- Crear vistas analíticas para facilitar las consultas.
- Construir dashboards para visualizar los principales indicadores.
- Documentar el desarrollo y el funcionamiento de la solución.

## 6. Explicación de las fuentes de datos

El proyecto utiliza siete archivos CSV principales:

| Archivo | Información |
|---|---|
| `olist_customers_dataset.csv` | Clientes y ubicación. |
| `olist_orders_dataset.csv` | Pedidos, estados y fechas. |
| `olist_order_items_dataset.csv` | Productos incluidos en cada pedido. |
| `olist_products_dataset.csv` | Catálogo y características de productos. |
| `olist_sellers_dataset.csv` | Vendedores y ubicación. |
| `olist_order_payments_dataset.csv` | Métodos y valores de pago. |
| `olist_order_reviews_dataset.csv` | Calificaciones y comentarios. |

Una forma clara de explicarlo es:

> Cada archivo representa una parte del proceso comercial. Los clientes realizan pedidos; los pedidos contienen productos; los productos son vendidos por vendedores; además existen datos complementarios de pagos y reseñas. La integración de estas fuentes permite obtener una visión más completa del negocio.

## 7. Explicación de la arquitectura

Presenta la arquitectura en el siguiente orden:

```text
Archivos CSV
    |
    v
Python y Pandas
    |
    v
Staging en SQL Server
    |
    v
Dimensiones y tabla de hechos
    |
    v
Vistas analíticas
    |
    v
Dashboards en Power BI
```

Puedes explicarla así:

> Primero se toman los archivos CSV originales. Python y Pandas permiten leer, revisar y analizar los datos. Después, la información se carga en tablas staging de SQL Server. A partir de staging se cargan las dimensiones y la tabla de hechos del Data Warehouse. Finalmente, se crean vistas analíticas que son utilizadas por Power BI para mostrar los resultados.

## 8. Explicación del proceso ETL

### Extract

> En la fase de extracción se leen los archivos ubicados en `datasets/raw/`. El proyecto utiliza Pandas para cargar la información y trabajar con ella en forma de DataFrames.

### Transform

> En la fase de transformación se revisan los tipos de datos, los valores nulos, los duplicados y la estructura de las columnas. También se preparan los datos para relacionarlos correctamente y se estandarizan algunos valores, como el estado de los pedidos.

### Load

> En la fase de carga, los datos se llevan primero a las tablas staging de SQL Server. Luego se cargan las dimensiones y finalmente la tabla `FactSales`, que concentra el detalle de los productos vendidos.

El flujo de ejecución puede mostrarse con estos comandos:

```powershell
python main.py
python etl/run_staging.py
python etl/run_etl.py
```

Explicación de cada comando:

- `python main.py`: genera el perfilamiento y los reportes de análisis.
- `python etl/run_staging.py`: carga los siete datasets en la capa staging.
- `python etl/run_etl.py`: ejecuta staging y carga el Data Warehouse mediante procedimientos almacenados.

## 9. Explicación del modelo dimensional

El modelo utiliza un esquema estrella. En el centro se encuentra `dw.FactSales` y alrededor están las dimensiones.

```text
              DimDate
                 |
DimCustomer -- FactSales -- DimProduct
                 |
              DimSeller
```

### Tabla de hechos

La granularidad de `FactSales` es:

> Una fila representa un producto vendido dentro de un pedido.

Esta decisión permite analizar:

- Ventas por producto.
- Ventas por categoría.
- Ventas por cliente.
- Ventas por vendedor.
- Ventas por estado.
- Ventas por período.
- Valor del flete.
- Estado de los pedidos.

### Dimensiones

- `DimDate`: permite analizar las ventas por día, mes, trimestre y año.
- `DimCustomer`: contiene la información de los clientes y su ubicación.
- `DimProduct`: contiene el catálogo y la categoría de los productos.
- `DimSeller`: contiene la información de los vendedores y su ubicación.

### Medidas principales

- `Quantity`: cantidad de unidades registradas.
- `Price`: precio del producto.
- `FreightValue`: valor del flete.
- `SalesAmount`: cantidad multiplicada por precio.
- `TotalAmount`: ventas más flete.

## 10. Demostración recomendada

Antes de iniciar la demostración, verifica que SQL Server esté disponible y que Power BI pueda abrir el archivo del proyecto.

### Paso 1: mostrar la estructura del proyecto

En el explorador de archivos muestra brevemente:

- `datasets/raw/`.
- `etl/`.
- `sql/`.
- `reports/`.
- `powerbi/`.
- `docs/`.

No es necesario abrir todos los archivos. La finalidad es demostrar que existe una organización por capas y responsabilidades.

### Paso 2: mostrar el perfilamiento

Abre `reports/dataset_profile_report.md` y explica que contiene:

- Número de filas.
- Número de columnas.
- Tipos de datos.
- Valores nulos.
- Duplicados.
- Uso de memoria.

Puedes decir:

> El perfilamiento permitió conocer la calidad y estructura de cada dataset antes de cargarlo. Esto ayuda a tomar decisiones sobre tipos de datos, relaciones y tratamiento de la información.

### Paso 3: mostrar el Data Warehouse

En SQL Server muestra las tablas principales:

- `stg.stg_customers`.
- `stg.stg_orders`.
- `stg.stg_order_items`.
- `stg.stg_products`.
- `stg.stg_sellers`.
- `dw.DimDate`.
- `dw.DimCustomer`.
- `dw.DimProduct`.
- `dw.DimSeller`.
- `dw.FactSales`.

Explica que staging conserva los datos preparados para la integración y que el esquema `dw` está orientado al análisis.

### Paso 4: mostrar una consulta de validación

Puedes utilizar una consulta como esta:

```sql
SELECT
    COUNT(*) AS TotalRows,
    SUM(Quantity) AS TotalUnits,
    SUM(Price * Quantity) AS TotalSales,
    SUM(FreightValue) AS TotalFreight
FROM dw.FactSales;
```

Luego muestra una consulta por estado:

```sql
SELECT
    OrderStatus,
    COUNT(DISTINCT OrderID) AS TotalOrders
FROM dw.vw_FactSales
GROUP BY OrderStatus
ORDER BY TotalOrders DESC;
```

### Paso 5: presentar el dashboard

Abre el archivo [DataFlow_Analytics_Dashboard.pbix](../../powerbi/DataFlow_Analytics_Dashboard.pbix) y presenta las páginas en este orden:

1. **Resumen Ejecutivo:** explica los indicadores generales y la evolución de las ventas.
2. **Análisis de Productos:** muestra categorías y productos con mejor desempeño.
3. **Clientes y Geografía:** explica la distribución de ventas y clientes por estado.
4. **Análisis de Vendedores:** muestra el rendimiento de vendedores y regiones.

En cada página responde tres preguntas:

- ¿Qué información muestra?
- ¿Qué indicador es importante?
- ¿Qué decisión podría apoyar ese indicador?

Ejemplo:

> En esta página se observan las ventas por categoría. El indicador permite identificar cuáles categorías tienen mayor participación y puede apoyar decisiones relacionadas con inventario, promoción y estrategia comercial.

## 11. Guion para explicar los dashboards

### Resumen Ejecutivo

> Esta página presenta una visión general del negocio. Permite observar las ventas totales, los pedidos, las unidades vendidas, los clientes y el valor promedio de los pedidos. También muestra la evolución mensual y facilita la identificación de períodos con mayor actividad.

### Análisis de Productos

> Esta página permite comparar el comportamiento de las categorías y conocer cuáles productos tienen mayor volumen de ventas. Esta información puede ser útil para priorizar productos, planear promociones y analizar la participación de cada categoría.

### Clientes y Geografía

> En esta página se analiza la distribución de clientes y ventas por estado. Los filtros permiten observar regiones específicas y el mapa facilita la interpretación geográfica de los resultados.

### Análisis de Vendedores

> Esta página permite identificar los vendedores con mayor participación en las ventas y comparar su desempeño por región. Es útil para analizar la contribución comercial de cada vendedor.

## 12. Preguntas posibles del jurado

### ¿Por qué escogió este proyecto?

> Escogí este proyecto porque permite aplicar de manera integrada conocimientos de análisis de datos, bases de datos, programación, ETL, modelado dimensional y visualización. Además, el comercio electrónico genera información suficiente para construir una solución analítica completa.

### ¿Por qué utilizó un Data Warehouse?

> Porque un Data Warehouse organiza la información histórica para facilitar consultas analíticas, comparar períodos y calcular indicadores sin depender directamente de los archivos transaccionales originales.

### ¿Por qué utilizó un esquema estrella?

> Porque es sencillo de entender, facilita las consultas analíticas y separa las medidas de ventas de los atributos descriptivos de clientes, productos, vendedores y fechas.

### ¿Cuál es la granularidad de `FactSales`?

> Una fila representa un producto vendido dentro de un pedido. Esta granularidad conserva el detalle necesario para analizar productos, categorías, vendedores y valores de venta.

### ¿Qué función cumple staging?

> Staging es una capa intermedia donde se reciben los datos de los archivos originales antes de cargarlos al modelo dimensional. Ayuda a separar la fuente de los datos analíticos y facilita la organización del proceso ETL.

### ¿Qué indicadores presenta el proyecto?

> Presenta ventas totales, pedidos, clientes, productos, vendedores, unidades vendidas, flete, ingreso total y valor promedio del pedido, además de análisis por categoría, período, estado, cliente y vendedor.

### ¿Qué papel cumple Python?

> Python se utiliza para leer los archivos, realizar el perfilamiento, generar reportes de análisis y cargar los datos a staging mediante Pandas y SQLAlchemy.

### ¿Qué papel cumple SQL Server?

> SQL Server almacena la capa staging, las dimensiones, la tabla de hechos, los procedimientos almacenados y las vistas analíticas.

### ¿Qué papel cumple Power BI?

> Power BI es la capa de visualización. Consume la información preparada en SQL Server y la presenta mediante indicadores, gráficos, filtros y mapas.

### ¿Cómo se valida que los datos fueron cargados?

> Se validan los conteos de filas, las relaciones entre tablas, los resultados de las consultas analíticas y la coherencia entre las métricas mostradas en SQL Server y Power BI.

### ¿Qué aprendió durante el proyecto?

> Aprendí a organizar un proyecto de datos por capas, analizar fuentes reales, diseñar un modelo dimensional, construir procesos ETL, utilizar SQL Server para integrar información y crear dashboards para comunicar resultados.

## 13. Resultados que debes destacar

Durante el cierre, menciona los resultados más importantes:

- Se integraron siete datasets relacionados con comercio electrónico.
- Se generaron reportes de perfilamiento y análisis.
- Se construyó una capa staging en SQL Server.
- Se implementó un modelo dimensional tipo estrella.
- Se creó la tabla de hechos `FactSales`.
- Se desarrollaron vistas analíticas para ventas, productos, clientes y vendedores.
- Se crearon dashboards interactivos en Power BI.
- Se documentó el proyecto desde la comprensión del negocio hasta la visualización.

## 14. Recomendaciones para la exposición

- Ensaya la presentación completa al menos dos veces.
- Explica con tus propias palabras y evita leer las diapositivas.
- Mantén visible un diagrama simple de la arquitectura.
- Ten preparado el proyecto antes de iniciar la sustentación.
- Abre previamente el archivo `.pbix` para evitar esperas.
- Usa ejemplos concretos de pedidos, productos y ventas.
- Relaciona cada indicador con una posible decisión de negocio.
- No intentes mostrar todos los archivos; muestra los más representativos.
- Si surge un error técnico durante la demostración, explica el flujo y continúa con capturas o resultados previamente preparados.
- Habla primero del problema y del valor de la solución, y después de los detalles técnicos.

## 15. Cierre sugerido

Puedes finalizar con el siguiente mensaje:

> Como resultado, desarrollé una solución completa para integrar, organizar y analizar información de comercio electrónico. El proyecto demuestra la aplicación práctica de los conocimientos adquiridos en ADSO, desde el análisis de los datos y la construcción del proceso ETL hasta el diseño del Data Warehouse y la creación de dashboards en Power BI. Esta solución facilita la interpretación de las ventas y puede servir como base para apoyar la toma de decisiones del negocio.

Después puedes agregar:

> Muchas gracias por su atención. Estoy dispuesto a responder sus preguntas.

## 16. Lista de verificación antes de sustentar

### Proyecto

- [ ] Los archivos CSV están disponibles en `datasets/raw/`.
- [ ] Las dependencias de Python están instaladas.
- [ ] SQL Server está iniciado.
- [ ] La base `EcommerceDW` está disponible.
- [ ] Las tablas y procedimientos SQL están creados.
- [ ] El ETL fue ejecutado previamente.
- [ ] El archivo `.pbix` abre correctamente.
- [ ] Los dashboards muestran información.

### Presentación

- [ ] El problema está explicado claramente.
- [ ] El objetivo general está memorizado.
- [ ] La arquitectura puede explicarse sin leer.
- [ ] La granularidad de `FactSales` está clara.
- [ ] Se conocen los principales indicadores.
- [ ] Se practicó la demostración de cada página.
- [ ] Se prepararon respuestas para preguntas técnicas.
- [ ] Se preparó una alternativa con capturas o reportes.

## Conclusión

La sustentación debe mostrar que el proyecto es una solución funcional de principio a fin: recibe datos, los analiza, los organiza mediante un proceso ETL, los almacena en un Data Warehouse y los convierte en información visual para apoyar el análisis del negocio.

La idea principal que debe quedar en el jurado es la siguiente:

> El proyecto transforma datos dispersos de comercio electrónico en información organizada, consultable y visualmente útil para la toma de decisiones.
