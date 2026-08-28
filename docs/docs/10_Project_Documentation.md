# Documentación Final del Proyecto

## 1. Identificación y propósito

**Proyecto:** Ecommerce Data Warehouse  
**Fuente principal:** Brazilian E-Commerce Public Dataset by Olist  
**Tecnologías:** Python, Pandas, SQL Server, SQLAlchemy, PyODBC y Power BI  
**Tipo de solución:** pipeline de perfilamiento/análisis y proceso ETL hacia un Data Warehouse dimensional.

El proyecto integra datos públicos de comercio electrónico brasileño para preparar información analítica sobre pedidos, productos, clientes y vendedores. La solución conserva los archivos originales, genera reportes de calidad y análisis exploratorio, carga una capa de staging en SQL Server, construye un esquema estrella y expone vistas para consumo analítico.

El alcance implementado corresponde a una solución académica funcional y reproducible en un entorno local con SQL Server. El dashboard Power BI completa la capa de visualización, aunque su actualización y conexión no pueden verificarse únicamente desde los archivos del repositorio.

## 2. Alcance funcional

La solución cubre las siguientes capacidades:

- Lectura y perfilamiento de los archivos CSV de Olist.
- Análisis exploratorio independiente por entidad de negocio.
- Carga completa de los siete archivos a tablas staging.
- Carga de dimensiones y de la tabla de hechos de ventas.
- Creación de vistas analíticas y consulta de KPIs.
- Consumo de la información mediante un archivo Power BI.

No se implementan en el modelo final una dimensión de pagos ni una dimensión o tabla de reseñas. Estos datasets sí forman parte de la fuente, del staging y del análisis Python, pero no se integran en `FactSales`.

## 3. Arquitectura implementada

```text
CSV en datasets/raw
	|
	v
Perfilamiento y análisis Python
	|
	v
Staging SQL Server (stg)
	|
	v
Dimensiones SQL Server (dw)
	|
	v
FactSales (dw)
	|
	v
Vistas analíticas (dw)
	|
	v
Power BI
```

El repositorio contiene dos flujos Python relacionados, pero independientes:

1. `python main.py` ejecuta el perfilamiento y los análisis de los datasets. Genera `reports/dataset_profile_report.md` y los documentos de `reports/analysis/`.
2. `python etl/run_etl.py` ejecuta la carga de staging y, posteriormente, los procedimientos almacenados de SQL Server para cargar el Data Warehouse.

Por tanto, el mensaje de finalización de `main.py` confirma el término del análisis Python, no la carga del Data Warehouse.

## 4. Estructura del repositorio

| Ubicación | Responsabilidad |
|---|---|
| `datasets/raw/` | Archivos CSV originales de Olist. |
| `datasets/processed/` | Directorio reservado para datos procesados; no es utilizado por el flujo verificado. |
| `etl/extract/` | Perfilamiento y extracción para los reportes Python. |
| `etl/analysis/` | Análisis por dataset. |
| `etl/load/` | Lectura de CSV y carga genérica a staging. |
| `etl/config/` | Configuración y conexión a SQL Server. |
| `etl/run_staging.py` | Orquestación de las siete cargas staging. |
| `etl/run_etl.py` | Orquestación de staging y procedimientos del warehouse. |
| `sql/staging/` | DDL de las tablas staging. |
| `sql/warehouse/` | DDL de dimensiones y `FactSales`. |
| `sql/procedures/` | Procedimientos de carga y registro de ejecución. |
| `sql/analytics/` | Vistas analíticas y consulta de KPIs. |
| `sql/queries/` | Consultas manuales de validación y exploración. |
| `reports/` | Perfilamiento y reportes de análisis generados. |
| `powerbi/` | Archivo `DataFlow_Analytics_Dashboard.pbix`. |
| `tests/` | Directorio reservado; no contiene pruebas automatizadas. |
| `docs/docs/` | Documentación técnica del proyecto. |

## 5. Fuentes de datos y perfilamiento

Los archivos disponibles en `datasets/raw/` son:

| Archivo | Filas reportadas | Función |
|---|---:|---|
| `olist_customers_dataset.csv` | 99,441 | Clientes y ubicación. |
| `olist_orders_dataset.csv` | 99,441 | Pedidos, estados y fechas. |
| `olist_order_items_dataset.csv` | 112,650 | Productos vendidos por pedido y vendedor. |
| `olist_order_payments_dataset.csv` | 103,886 | Métodos, cuotas y valores de pago. |
| `olist_order_reviews_dataset.csv` | 99,224 | Calificaciones y comentarios. |
| `olist_products_dataset.csv` | 32,951 | Catálogo y atributos físicos. |
| `olist_sellers_dataset.csv` | 3,095 | Vendedores y ubicación. |

El módulo `etl/extract/dataset_profiler.py` calcula filas, columnas, tipos, nulos, duplicados y uso de memoria, y escribe `reports/dataset_profile_report.md`. Los reportes muestran ausencia de filas duplicadas completas en los datasets perfilados y nulos esperables en fechas logísticas, comentarios de reseñas y atributos de productos.

## 6. Preparación y carga de staging

`etl/run_staging.py` ejecuta los loaders en este orden:

1. Customers
2. Products
3. Sellers
4. Orders
5. Order Items
6. Payments
7. Reviews

Cada loader lee su CSV mediante Pandas y llama a `etl.load.load_to_staging.load_dataframe()`. La carga es completa: por defecto se ejecuta `TRUNCATE TABLE` sobre la tabla de destino y después `DataFrame.to_sql(..., if_exists="append")`, usando lotes de 1,000 filas.

Las tablas pertenecen al esquema `stg` y conservan los nombres de negocio de los archivos. La definición SQL incorpora `LoadDate` en las tablas staging.

## 7. Modelo dimensional implementado

### 7.1 Granularidad de `FactSales`

Cada fila de `dw.FactSales` representa un producto vendido dentro de un pedido. La granularidad procede de `stg.stg_order_items`; por ello un pedido con varios productos genera varias filas.

### 7.2 Dimensiones

| Tabla | Clave sustituta | Atributos principales |
|---|---|---|
| `dw.DimDate` | `DateKey` | Fecha, día, mes, trimestre, año, día de semana y fin de semana. |
| `dw.DimCustomer` | `CustomerKey` | `CustomerID`, `CustomerUniqueID`, código postal, ciudad y estado. |
| `dw.DimProduct` | `ProductKey` | `ProductID`, categoría y dimensiones físicas. |
| `dw.DimSeller` | `SellerKey` | `SellerID`, código postal, ciudad y estado. |

Las dimensiones de cliente, producto y vendedor usan claves de negocio únicas basadas respectivamente en `CustomerID`, `ProductID` y `SellerID`. La fecha se genera mediante el procedimiento `etl.usp_Load_DimDate`; las otras dimensiones se cargan desde staging.

### 7.3 Tabla de hechos

`dw.FactSales` contiene:

- `SalesKey` como identidad y clave primaria.
- `OrderID` como dimensión degenerada para trazabilidad.
- `DateKey`, `CustomerKey`, `ProductKey` y `SellerKey` como claves foráneas.
- `Quantity`, `Price` y `FreightValue` como medidas.
- `OrderStatus` como atributo del pedido.
- `CreatedDate` y `ModifiedDate` como columnas técnicas.

La cantidad se carga como `1` porque cada fila de origen representa una unidad/item vendido. La carga une pedidos e ítems con las cuatro dimensiones mediante `INNER JOIN`, transforma el estado con `UPPER(LTRIM(RTRIM(...)))` y utiliza la fecha de compra para buscar `DateKey`.

## 8. Orquestación y procedimientos SQL

El flujo `etl/run_etl.py` genera un `BatchID`, ejecuta `run_staging()` y llama a los procedimientos en este orden:

1. `etl.usp_Load_DimDate`
2. `etl.usp_Load_DimCustomer`
3. `etl.usp_Load_DimProduct`
4. `etl.usp_Load_DimSeller`
5. `etl.usp_Load_FactSales`

Los procedimientos del warehouse utilizan transacciones, bloques `TRY...CATCH`, rollback ante error y propagación de la excepción. `usp_Load_FactSales` realiza una recarga completa de la tabla de hechos mediante `TRUNCATE` antes de insertar los datos.

Existe `etl.ExecutionLog` y el procedimiento `etl.usp_LogExecution`. En el flujo verificado, el registro detallado de éxito o error está implementado para `usp_Load_FactSales`; staging, dimensiones y el orquestador no registran actualmente el mismo nivel de detalle.

La conexión se configura en `etl/config/settings.py` para la base local `EcommerceDW`, servidor `localhost`, autenticación integrada y `ODBC Driver 17 for SQL Server`. Las rutas de los datasets y reportes se centralizan en `config.py`.

## 9. Capa analítica

El esquema `dw` expone las siguientes estructuras:

| Vista o script | Propósito |
|---|---|
| `dw.vw_FactSales` | Une hechos y dimensiones y calcula `SalesAmount` y `TotalAmount`. |
| `dw.vw_SalesByCategory` | Ventas, unidades, pedidos y flete por categoría. |
| `dw.vw_SalesByMonth` | Evolución por año, mes y trimestre. |
| `dw.vw_SalesByState` | Distribución de ventas por estado del cliente. |
| `dw.vw_TopProducts` | Productos con mayor desempeño comercial. |
| `dw.vw_TopCustomers` | Clientes con mayor actividad o ventas. |
| `dw.vw_TopSellers` | Vendedores con mayor desempeño. |
| `08_KPIs.sql` | Consulta de KPIs generales. |

Los indicadores principales son pedidos, clientes, productos, vendedores, unidades, ventas (`Quantity * Price`), flete, ingreso total (`SalesAmount + FreightValue`) y valor promedio del pedido.

## 10. Power BI

El archivo `powerbi/DataFlow_Analytics_Dashboard.pbix` representa la capa de consumo. La documentación del dashboard define páginas para resumen ejecutivo, productos, clientes/geografía y vendedores, con tarjetas KPI, gráficos, filtros y mapas.

La fuente esperada es la base `EcommerceDW`, principalmente mediante las vistas analíticas del esquema `dw`. La presencia del archivo `.pbix` está verificada en el repositorio; la conexión, actualización de datos y publicación no son comprobables sin abrir Power BI y disponer del SQL Server configurado.

## 11. Instalación y prerrequisitos

Se requiere:

- Python con las dependencias de `requirements.txt`.
- SQL Server local o accesible.
- ODBC Driver 17 for SQL Server.
- Base de datos `EcommerceDW`.
- Permisos para crear esquemas, tablas, vistas y procedimientos.
- Archivos CSV ubicados en `datasets/raw/`.

Las dependencias declaradas son Pandas, SQLAlchemy, PyODBC, `python-docx`, KaggleHub y Tabulate. No se incluye un archivo de bloqueo de versiones.

## 12. Ejecución

Para generar el perfilamiento y los análisis Python:

```powershell
python main.py
```

Para cargar únicamente staging:

```powershell
python etl/run_staging.py
```

Para ejecutar staging y el Data Warehouse completo:

```powershell
python etl/run_etl.py
```

Antes del ETL deben haberse ejecutado en SQL Server los scripts de creación de la base/esquemas, staging, warehouse y procedimientos, respetando las dependencias entre ellos. Las consultas de `sql/queries/` pueden utilizarse para validaciones manuales posteriores.

## 13. Validación realizada y estado final

La evidencia disponible confirma:

- Reportes generados para los siete datasets.
- Conteos de origen coherentes con el dataset Olist.
- DDL para staging, dimensiones, `FactSales` y vistas analíticas.
- Procedimientos de carga para las dimensiones y la tabla de hechos.
- Orquestadores Python separados para análisis y ETL.
- Archivo Power BI presente.




## 15. Conclusión

El proyecto entrega una solución funcional de ingeniería de datos para el dataset Olist: parte de archivos raw, genera análisis de calidad, carga una capa staging, construye un esquema estrella de ventas en SQL Server y ofrece vistas listas para el análisis en Power BI.

Su principal fortaleza es la separación de responsabilidades entre análisis Python, carga staging, procedimientos SQL y capa analítica. 

Con base en los artefactos disponibles, el proyecto puede considerarse finalizado y operativo para el alcance implementado.
