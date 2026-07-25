# Diseño del Data Warehouse

## 1. Objetivo

El objetivo de este documento es definir la arquitectura y el diseño del Data Warehouse que soportará el análisis de información del conjunto de datos Olist Brazilian E-Commerce Public Dataset.

Este Data Warehouse permitirá integrar la información proveniente de múltiples conjuntos de datos transaccionales (OLTP) para construir una única fuente de información orientada al análisis de negocio (OLAP), facilitando la generación de indicadores estratégicos, reportes ejecutivos y paneles de control en Power BI.

El diseño propuesto sigue la metodología de modelado dimensional de Ralph Kimball, utilizando un esquema estrella (Star Schema), debido a que ofrece un excelente rendimiento para consultas analíticas, simplifica el modelo de datos y facilita la construcción de indicadores empresariales.

Durante el proceso ETL se realizarán las tareas de extracción, transformación y carga de los datos hacia una estructura optimizada para el análisis histórico de ventas, clientes, productos, vendedores y métodos de pago.

Este documento servirá como guía para el desarrollo del modelo dimensional, la implementación del proceso ETL y la construcción del Data Warehouse en SQL Server.

---

# 2. Arquitectura del Data Warehouse

El proyecto implementará una arquitectura clásica de Data Warehouse dividida en varias capas, donde cada una cumple una responsabilidad específica dentro del flujo de procesamiento de los datos.

La información será extraída desde los archivos CSV originales del conjunto de datos Olist, posteriormente será validada y transformada mediante procesos desarrollados en Python utilizando Pandas. Una vez aplicada la limpieza y estandarización de los datos, estos serán cargados en SQL Server para construir el Data Warehouse.

La arquitectura propuesta se divide en las siguientes etapas:

## Fuente de datos (Source)

Corresponde a los archivos CSV originales suministrados por el conjunto de datos Olist. Estos archivos representan el sistema transaccional (OLTP) y contienen la información de clientes, pedidos, productos, vendedores, pagos y opiniones.

## Staging

La capa Staging almacenará temporalmente los datos extraídos antes de ser transformados.

Su objetivo es:

- Centralizar la información proveniente de múltiples archivos.
- Validar la calidad de los datos.
- Detectar registros duplicados.
- Identificar valores nulos.
- Mantener una copia de los datos originales antes de cualquier transformación.

Esta capa permitirá repetir el proceso ETL sin afectar la información original.

## Transformación (ETL)

En esta etapa se aplicarán todas las reglas de negocio identificadas durante el análisis de los datasets.

Entre ellas se encuentran:

- Limpieza de datos.
- Estandarización de formatos.
- Conversión de tipos de datos.
- Generación de claves sustitutas (Surrogate Keys).
- Tratamiento de valores nulos.
- Integración entre datasets.
- Validaciones de integridad.

Todos estos procesos serán desarrollados en Python utilizando Pandas.

## Data Warehouse

Después de completar las transformaciones, la información será cargada al Data Warehouse implementado en SQL Server.

El modelo dimensional estará compuesto por una tabla de hechos y varias tablas de dimensiones, diseñadas específicamente para optimizar consultas analíticas.

Esta estructura permitirá analizar el comportamiento de las ventas desde diferentes perspectivas, como clientes, productos, vendedores, fechas y métodos de pago.

## Consumo de datos

Finalmente, el Data Warehouse será utilizado como fuente de datos para Power BI.

Desde allí se construirán dashboards e indicadores que permitirán analizar:

- Ventas.
- Clientes.
- Productos.
- Logística.
- Métodos de pago.
- Satisfacción de clientes.
- Rendimiento de vendedores.

La siguiente figura conceptual resume el flujo general de la arquitectura del proyecto:

Fuente de datos (CSV)
        ↓
      Staging
        ↓
Transformación (Python + Pandas)
        ↓
 Data Warehouse (SQL Server)
        ↓
     Power BI


---
# 3. Granularidad de la Tabla de Hechos (FactSales)

La granularidad define el nivel de detalle que tendrá cada registro almacenado en la tabla de hechos. Esta es una de las decisiones más importantes en el diseño de un Data Warehouse, ya que determina la estructura del modelo dimensional, las relaciones con las dimensiones y el tipo de análisis que podrán realizar los usuarios.

Después de analizar los datasets del proyecto, se determinó que la granularidad más adecuada consiste en almacenar **una fila por cada producto vendido dentro de un pedido**.

Esta decisión se fundamenta en que el dataset `olist_order_items_dataset.csv` representa el mayor nivel de detalle disponible sobre las ventas. Cada registro corresponde a un producto específico asociado a un pedido, incluyendo información como el precio, el valor del flete y el vendedor responsable de la venta.

Gracias a esta granularidad será posible responder preguntas de negocio como:

- ¿Cuáles son los productos más vendidos?
- ¿Qué vendedores generan mayores ingresos?
- ¿Cuál es el valor promedio de venta por producto?
- ¿Cuál es el costo promedio del flete por categoría?
- ¿Qué clientes realizan compras de mayor valor?
- ¿Cómo evolucionan las ventas por mes, trimestre o año?
- ¿Cuál es la calificación promedio obtenida por los productos vendidos?

Si la tabla de hechos almacenara una fila por pedido, sería imposible conocer el detalle de cada producto incluido en la compra, lo que limitaría significativamente la capacidad analítica del Data Warehouse.

Por esta razón, cada registro de la tabla **FactSales** representará un único producto vendido dentro de un pedido.

## Nivel de granularidad

**Una fila = Un producto vendido dentro de un pedido.**

Ejemplo conceptual:

| Pedido | Producto | Cliente | Vendedor | Precio | Flete |
|---------|----------|----------|-----------|--------:|-------:|
| 1001 | A | Cliente 1 | Seller X | 80.00 | 12.00 |
| 1001 | B | Cliente 1 | Seller Y | 45.00 | 10.00 |
| 1002 | C | Cliente 2 | Seller X | 120.00 | 20.00 |

En este ejemplo, el pedido **1001** contiene dos productos diferentes, por lo que genera dos registros en la tabla de hechos. Esto garantiza el máximo nivel de detalle para realizar análisis multidimensionales.

La granularidad definida permitirá calcular indicadores como:

- Total de ventas.
- Cantidad de productos vendidos.
- Ticket promedio.
- Valor promedio del flete.
- Participación por vendedor.
- Participación por categoría.
- Ventas por cliente.
- Ventas por ciudad y estado.
- Rentabilidad por producto.
- Evolución histórica de las ventas.

Esta decisión constituye la base del modelo dimensional y garantiza que el Data Warehouse pueda responder eficientemente tanto consultas agregadas como análisis detallados.

---

# 4. Dimensiones del Data Warehouse

Las dimensiones representan las diferentes perspectivas desde las cuales será posible analizar la información almacenada en la tabla de hechos (**FactSales**).

Cada dimensión contiene atributos descriptivos que permiten clasificar, filtrar y agrupar la información para responder preguntas de negocio. A diferencia de la tabla de hechos, las dimensiones almacenan información textual o descriptiva y cambian con mucha menor frecuencia.

Con base en el análisis realizado sobre los datasets del proyecto, se definieron las siguientes dimensiones.

---

## 4.1 DimCustomer

Esta dimensión almacenará la información de los clientes.

Su origen será el dataset:

- olist_customers_dataset.csv

### Atributos principales

- CustomerKey (Clave sustituta)
- customer_id (Clave de negocio)
- customer_unique_id
- customer_city
- customer_state

### Objetivo

Permitir el análisis de las ventas por cliente, ciudad y estado.

Ejemplos de análisis:

- Clientes con mayor número de compras.
- Ventas por ciudad.
- Ventas por estado.
- Distribución geográfica de clientes.

---

## 4.2 DimProduct

Esta dimensión almacenará la información descriptiva de los productos.

Su origen será el dataset:

- olist_products_dataset.csv

### Atributos principales

- ProductKey
- product_id
- product_category_name
- product_weight_g
- product_length_cm
- product_height_cm
- product_width_cm

### Objetivo

Permitir el análisis de ventas por producto y categoría.

Ejemplos de análisis:

- Productos más vendidos.
- Categorías con mayores ingresos.
- Peso promedio de productos vendidos.
- Distribución de ventas por categoría.

---

## 4.3 DimSeller

Esta dimensión contendrá la información de los vendedores.

Su origen será:

- olist_sellers_dataset.csv

### Atributos principales

- SellerKey
- seller_id
- seller_city
- seller_state

### Objetivo

Permitir el análisis del desempeño comercial de los vendedores.

Ejemplos de análisis:

- Ventas por vendedor.
- Ventas por ciudad.
- Ventas por estado.
- Participación por región.

---

## 4.4 DimDate

Esta dimensión será generada durante el proceso ETL.

No proviene directamente de un archivo CSV.

Se construirá a partir de las fechas presentes en los pedidos.

### Atributos principales

- DateKey
- Fecha completa
- Día
- Mes
- Nombre del mes
- Trimestre
- Año
- Día de la semana
- Nombre del día
- Fin de semana (Sí / No)

### Objetivo

Permitir el análisis temporal de las ventas.

Ejemplos de análisis:

- Ventas por año.
- Ventas por trimestre.
- Ventas por mes.
- Ventas por día.
- Tendencias históricas.

---

## 4.5 DimPayment

Esta dimensión almacenará los diferentes métodos de pago utilizados por los clientes.

Su origen será:

- olist_order_payments_dataset.csv

### Atributos principales

- PaymentKey
- payment_type

### Objetivo

Permitir analizar el comportamiento financiero de las ventas.

Ejemplos de análisis:

- Ventas por método de pago.
- Participación de cada medio de pago.
- Uso de cuotas por método de pago.

---

## Consideración sobre las opiniones de clientes

Durante el análisis del dataset de opiniones se evaluó la posibilidad de construir una dimensión independiente para las reseñas de los clientes.

Sin embargo, se determinó que la información principal de este dataset corresponde a una medida cuantitativa (**review_score**) y a comentarios de texto opcionales. Debido a ello, no resulta conveniente crear una dimensión específica, ya que incrementaría la complejidad del modelo sin aportar beneficios significativos para los análisis planteados en este proyecto.

En consecuencia:

- La calificación (**review_score**) será incorporada como una medida dentro de la tabla de hechos (**FactSales**).
- Los comentarios escritos (**review_comment_title** y **review_comment_message**) no serán cargados al Data Warehouse, ya que no forman parte de los indicadores definidos para este proyecto y aumentarían considerablemente el volumen de almacenamiento.

Esta decisión mantiene el modelo dimensional simple, eficiente y orientado al análisis de indicadores de negocio.


---

# 5. Tabla de Hechos (FactSales)

La tabla **FactSales** constituye el núcleo del Data Warehouse y almacenará las métricas cuantitativas relacionadas con cada venta realizada.

De acuerdo con la granularidad definida, cada registro de esta tabla representará un único producto vendido dentro de un pedido.

Esta tabla integrará información proveniente de múltiples datasets mediante el proceso ETL, consolidando en una única estructura todos los datos necesarios para el análisis de negocio.

---

## Objetivo

Centralizar la información de las ventas para facilitar el análisis histórico del comportamiento comercial de la empresa desde diferentes perspectivas, como clientes, productos, vendedores, fechas y métodos de pago.

---

## Origen de la información

La tabla FactSales integrará información proveniente de los siguientes datasets:

| Dataset | Información utilizada |
|----------|----------------------|
| olist_orders_dataset.csv | Pedido, fechas y estado del pedido |
| olist_order_items_dataset.csv | Productos vendidos, precio y flete |
| olist_order_payments_dataset.csv | Método de pago y cuotas |
| olist_order_reviews_dataset.csv | Calificación del cliente |
| olist_customers_dataset.csv | Cliente asociado al pedido |
| olist_products_dataset.csv | Producto vendido |
| olist_sellers_dataset.csv | Vendedor responsable |

---

## Claves Foráneas

La tabla FactSales almacenará las siguientes claves provenientes de las dimensiones:

- DateKey
- CustomerKey
- ProductKey
- SellerKey
- PaymentKey

Estas claves permitirán relacionar la tabla de hechos con las dimensiones mediante un esquema estrella (Star Schema).

---

## Medidas

Las principales medidas almacenadas serán:

- Precio del producto (price)
- Valor del flete (freight_value)
- Valor total de la venta
- Número de cuotas
- Calificación del cliente (review_score)

Estas medidas podrán agregarse mediante operaciones como SUM, AVG, COUNT, MIN y MAX para construir indicadores de negocio.

---

## Atributos Operativos

Además de las medidas, la tabla conservará algunos atributos operativos que facilitarán el análisis y la trazabilidad de la información.

Entre ellos se encuentran:

- order_id (clave de negocio)
- order_item_id
- order_status

Estos campos permitirán realizar análisis específicos sin afectar la estructura dimensional.

---

## Indicadores que soportará FactSales

El diseño de la tabla permitirá calcular indicadores como:

### Ventas

- Total de ventas.
- Cantidad de productos vendidos.
- Ticket promedio.
- Valor promedio por pedido.
- Evolución de ventas.

### Clientes

- Clientes con mayor número de compras.
- Clientes con mayor valor de compra.
- Distribución geográfica de clientes.

### Productos

- Productos más vendidos.
- Categorías con mayores ingresos.
- Participación por categoría.

### Vendedores

- Ventas por vendedor.
- Participación por estado.
- Participación por ciudad.

### Pagos

- Distribución por método de pago.
- Número promedio de cuotas.
- Participación por medio de pago.

### Logística

- Valor promedio del flete.
- Tiempo promedio de entrega.
- Cumplimiento de entregas.

### Satisfacción

- Calificación promedio.
- Distribución de calificaciones.
- Porcentaje de clientes satisfechos.

---

## Beneficios del diseño

La estructura propuesta permitirá:

- Reducir la complejidad de las consultas.
- Mejorar el rendimiento de los reportes analíticos.
- Facilitar la construcción de dashboards en Power BI.
- Simplificar la creación de indicadores de negocio.
- Mantener un modelo escalable para futuras ampliaciones.

---

## Justificación

La tabla FactSales concentra todas las métricas relevantes del proceso comercial y constituye el eje principal del modelo dimensional.

Su diseño permite relacionar cada venta con las dimensiones del negocio, proporcionando una visión integral del comportamiento comercial de la empresa y facilitando el análisis multidimensional.

---

# 6. Especificación Técnica de la Tabla FactSales

La siguiente tabla describe cada uno de los campos que conformarán la tabla de hechos (**FactSales**), indicando su origen, tipo de dato y propósito dentro del modelo dimensional.

| Columna | Tipo de dato (SQL Server) | Origen | Descripción |
|---------|--------------------------|--------|-------------|
| SalesKey | INT IDENTITY(1,1) | ETL | Clave sustituta de la tabla de hechos. |
| DateKey | INT | DimDate | Relación con la dimensión de fechas. |
| CustomerKey | INT | DimCustomer | Relación con la dimensión de clientes. |
| ProductKey | INT | DimProduct | Relación con la dimensión de productos. |
| SellerKey | INT | DimSeller | Relación con la dimensión de vendedores. |
| PaymentKey | INT | DimPayment | Relación con la dimensión de métodos de pago. |
| OrderID | VARCHAR(50) | Orders | Clave de negocio del pedido. |
| OrderItemID | INT | Order Items | Identificador del producto dentro del pedido. |
| OrderStatus | VARCHAR(20) | Orders | Estado del pedido. |
| Price | DECIMAL(10,2) | Order Items | Precio del producto vendido. |
| FreightValue | DECIMAL(10,2) | Order Items | Valor del flete asociado al producto. |
| PaymentInstallments | TINYINT | Payments | Número de cuotas del pago. |
| ReviewScore | TINYINT | Reviews | Calificación otorgada por el cliente (1 a 5). |

---

## Descripción de las medidas

Las siguientes columnas representan las principales métricas que serán utilizadas para construir indicadores y reportes analíticos.

### Price

Representa el valor de venta del producto.

Ejemplos de indicadores:

- Total de ventas.
- Venta promedio.
- Venta máxima.
- Venta mínima.

---

### FreightValue

Representa el costo del envío asociado al producto vendido.

Ejemplos de indicadores:

- Flete promedio.
- Flete total.
- Participación del flete sobre las ventas.

---

### PaymentInstallments

Representa el número de cuotas utilizadas por el cliente para realizar el pago.

Ejemplos de indicadores:

- Promedio de cuotas.
- Distribución de cuotas.
- Preferencia de financiación.

---

### ReviewScore

Representa la calificación otorgada por el cliente después de recibir el pedido.

Su valor oscila entre 1 y 5.

Permitirá construir indicadores como:

- Nivel de satisfacción.
- Calificación promedio.
- Distribución de opiniones.

---

## Relaciones del modelo

Cada registro de FactSales estará relacionado con las siguientes dimensiones:

- DimDate
- DimCustomer
- DimProduct
- DimSeller
- DimPayment

Esta estructura corresponde a un modelo dimensional tipo **Star Schema**, en el cual la tabla de hechos se encuentra en el centro y las dimensiones la rodean.

---

## Ventajas del diseño

El modelo propuesto ofrece las siguientes ventajas:

- Alto rendimiento en consultas analíticas.
- Facilidad para construir dashboards en Power BI.
- Escalabilidad para incorporar nuevas dimensiones.
- Simplicidad en las consultas SQL.
- Integración eficiente mediante procesos ETL.
- Reducción de redundancia de información.

---

# 7. Modelo Dimensional (Star Schema)

El Data Warehouse será implementado utilizando un modelo dimensional tipo **Star Schema (Esquema Estrella)**.

Este modelo organiza la información alrededor de una tabla central de hechos (**FactSales**) y un conjunto de dimensiones que contienen la información descriptiva del negocio.

El objetivo de esta arquitectura es optimizar el rendimiento de las consultas analíticas, reducir la complejidad del modelo de datos y facilitar la construcción de indicadores y dashboards en Power BI.

El esquema estrella definido para este proyecto estará compuesto por una tabla de hechos y cuatro dimensiones.

## Estructura del modelo

```
                  DimDate
                     │
                     │
DimCustomer ───── FactSales ───── DimProduct
                     │
                     │
                DimSeller
```

---

## Tabla de Hechos

### FactSales

Almacena las métricas del negocio.

Cada registro representa un producto vendido dentro de un pedido.

Contendrá las siguientes medidas principales:

- Precio del producto.
- Valor del flete.
- Calificación del cliente.
- Número de cuotas.
- Método de pago.
- Estado del pedido.

---

## Dimensiones

### DimCustomer

Describe la información geográfica del cliente.

Permite responder preguntas como:

- ¿Qué ciudades compran más?
- ¿Qué estados generan mayores ingresos?
- ¿Qué clientes realizan más compras?

---

### DimProduct

Describe las características de los productos.

Permitirá responder preguntas como:

- ¿Qué categorías venden más?
- ¿Qué productos generan mayores ingresos?
- ¿Qué características físicas tienen los productos vendidos?

---

### DimSeller

Describe la información de los vendedores.

Permitirá realizar análisis como:

- Ventas por vendedor.
- Participación por ciudad.
- Participación por estado.
- Concentración geográfica de vendedores.

---

### DimDate

Permitirá realizar análisis históricos de la información.

Entre ellos:

- Ventas por día.
- Ventas por mes.
- Ventas por trimestre.
- Ventas por año.
- Comparaciones históricas.

---

## Beneficios del modelo

El modelo dimensional seleccionado proporciona las siguientes ventajas:

- Consultas analíticas simples.
- Alto rendimiento en SQL Server.
- Fácil integración con Power BI.
- Modelo escalable.
- Baja redundancia de información.
- Facilidad para incorporar nuevas dimensiones en el futuro.

La utilización de un esquema estrella permitirá que los procesos ETL sean más sencillos y que los usuarios finales puedan realizar análisis multidimensionales sin necesidad de conocer la estructura transaccional original del sistema.

---

# 8. Modelo Físico del Data Warehouse

Una vez definido el modelo dimensional, se establece el diseño físico que será implementado en SQL Server.

El modelo físico especifica las tablas, columnas, tipos de datos, claves primarias, claves foráneas y restricciones que garantizarán la integridad de la información durante el proceso ETL.

La implementación seguirá las buenas prácticas de modelado dimensional propuestas por Ralph Kimball, utilizando claves sustitutas (Surrogate Keys) para todas las dimensiones y una tabla de hechos central.

---

## 8.1 Tabla FactSales

La tabla FactSales almacenará las métricas del negocio.

### Clave primaria

SalesKey

### Claves foráneas

- DateKey
- CustomerKey
- ProductKey
- SellerKey

### Columnas

| Columna | Tipo SQL Server | Descripción |
|----------|----------------|-------------|
| SalesKey | INT IDENTITY(1,1) | Clave primaria de la tabla de hechos. |
| DateKey | INT | Relación con DimDate. |
| CustomerKey | INT | Relación con DimCustomer. |
| ProductKey | INT | Relación con DimProduct. |
| SellerKey | INT | Relación con DimSeller. |
| OrderID | VARCHAR(50) | Identificador original del pedido. |
| OrderItemID | INT | Producto dentro del pedido. |
| OrderStatus | VARCHAR(20) | Estado del pedido. |
| PaymentType | VARCHAR(30) | Método de pago utilizado. |
| PaymentInstallments | TINYINT | Número de cuotas. |
| Price | DECIMAL(10,2) | Precio del producto. |
| FreightValue | DECIMAL(10,2) | Valor del flete. |
| ReviewScore | TINYINT | Calificación otorgada por el cliente. |

---

## 8.2 DimCustomer

### Clave primaria

CustomerKey

### Columnas

| Columna | Tipo SQL Server |
|----------|----------------|
| CustomerKey | INT IDENTITY(1,1) |
| CustomerID | VARCHAR(50) |
| CustomerUniqueID | VARCHAR(50) |
| CustomerCity | VARCHAR(100) |
| CustomerState | CHAR(2) |

---

## 8.3 DimProduct

### Clave primaria

ProductKey

### Columnas

| Columna | Tipo SQL Server |
|----------|----------------|
| ProductKey | INT IDENTITY(1,1) |
| ProductID | VARCHAR(50) |
| Category | VARCHAR(100) |
| WeightGrams | DECIMAL(10,2) |
| LengthCM | DECIMAL(10,2) |
| HeightCM | DECIMAL(10,2) |
| WidthCM | DECIMAL(10,2) |

---

## 8.4 DimSeller

### Clave primaria

SellerKey

### Columnas

| Columna | Tipo SQL Server |
|----------|----------------|
| SellerKey | INT IDENTITY(1,1) |
| SellerID | VARCHAR(50) |
| SellerCity | VARCHAR(100) |
| SellerState | CHAR(2) |

---

## 8.5 DimDate

### Clave primaria

DateKey

### Columnas

| Columna | Tipo SQL Server |
|----------|----------------|
| DateKey | INT |
| FullDate | DATE |
| Day | TINYINT |
| Month | TINYINT |
| MonthName | VARCHAR(20) |
| Quarter | TINYINT |
| Year | SMALLINT |
| WeekDay | TINYINT |
| WeekDayName | VARCHAR(20) |
| IsWeekend | BIT |

---

## Integridad Referencial

El modelo utilizará claves foráneas para garantizar la consistencia de la información entre la tabla de hechos y las dimensiones.

Todas las relaciones serán de tipo uno a muchos (1:N), donde cada dimensión podrá relacionarse con múltiples registros de la tabla FactSales.

---

## Estrategia de Carga

Durante el proceso ETL, las dimensiones serán cargadas antes de la tabla de hechos.

El orden de carga será el siguiente:

1. DimDate
2. DimCustomer
3. DimProduct
4. DimSeller
5. FactSales

Este orden garantiza que todas las claves sustitutas existan antes de poblar la tabla de hechos, manteniendo la integridad referencial del modelo.


