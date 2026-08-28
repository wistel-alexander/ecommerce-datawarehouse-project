# Power BI Dashboard – DataFlow Analytics

## 1. Descripción

El archivo `DataFlow_Analytics_Dashboard.pbix` corresponde a la capa de Business Intelligence del proyecto Ecommerce Data Warehouse.

Su objetivo es transformar los datos almacenados y procesados en SQL Server en información visual que permita analizar el comportamiento de las ventas, productos, clientes y vendedores del comercio electrónico.

El dashboard fue desarrollado en Microsoft Power BI y utiliza como fuente principal las vistas analíticas creadas en SQL Server.

---

## 2. Fuente de datos

El dashboard se conecta con la base de datos:

**EcommerceDW**

La información utilizada proviene principalmente de las vistas analíticas creadas en el esquema `dw`, entre ellas:

- `vw_FactSales`
- `vw_SalesByCategory`
- `vw_SalesByMonth`
- `vw_SalesByState`
- `vw_TopProducts`
- `vw_TopCustomers`
- `vw_TopSellers`

Estas vistas permiten presentar la información del Data Warehouse de forma adecuada para el análisis y la visualización en Power BI.

---

## 3. Estructura del Dashboard

El dashboard está compuesto por cuatro páginas principales.

### 3.1 Resumen Ejecutivo

Esta página presenta una visión general del comportamiento de las ventas.

Incluye indicadores clave como:

- Total Sales
- Total Orders
- Total Customers
- Total Units
- Average Order Value

También contiene:

- Evolución mensual de las ventas.
- Ventas por categoría.
- Segmentación por estado del cliente.
- Segmentación por rango de fechas.

Su propósito es proporcionar una visión rápida del comportamiento general del negocio.

---

### 3.2 Análisis de Productos

Esta página está enfocada en el comportamiento de los productos y categorías.

Incluye:

- Ventas por categoría.
- Participación de ventas por categoría.
- Top 10 productos por ventas.
- Top 10 productos por unidades vendidas.
- Filtro por categoría.
- Filtro por estado del cliente.

Esta información permite identificar las categorías y productos con mayor participación dentro de las ventas.

---

### 3.3 Clientes y Geografía

Esta página permite analizar la distribución de los clientes y las ventas desde una perspectiva geográfica.

Incluye:

- Total de clientes.
- Ventas por estado.
- Top 10 clientes por ventas.
- Filtro por estado.
- Mapa geográfico basado en `CustomerState`.

El mapa permite complementar los gráficos tradicionales y facilitar la identificación de los estados con mayor actividad comercial.

---

### 3.4 Análisis de Vendedores

Esta página está orientada al análisis del desempeño de los vendedores.

Incluye:

- Total de vendedores.
- Top 10 vendedores por ventas.
- Ventas por estado del vendedor.
- Filtro por estado del vendedor.
- Mapa geográfico basado en `SellerState`.

Su propósito es identificar los vendedores y regiones que presentan mayor participación en las ventas.

---

## 4. Indicadores principales

El dashboard utiliza medidas para obtener indicadores consolidados a partir de los datos disponibles.

Entre los principales indicadores se encuentran:

- **Total Sales:** valor total de las ventas.
- **Total Orders:** cantidad de pedidos registrados.
- **Total Customers:** cantidad de clientes.
- **Total Units:** cantidad de unidades vendidas.
- **Total Sellers:** cantidad de vendedores.
- **Average Order Value:** valor promedio de los pedidos.

Estos indicadores permiten realizar un análisis general y facilitar la interpretación de los resultados.

---

## 5. Interactividad

El dashboard incorpora elementos interactivos que permiten analizar la información de acuerdo con diferentes criterios.

Entre ellos se encuentran:

- Segmentaciones por estado.
- Segmentaciones por fecha.
- Segmentación por categoría.
- Segmentación por estado del vendedor.
- Filtros aplicados sobre determinadas visualizaciones.

Los filtros permiten explorar diferentes subconjuntos de información sin modificar los datos originales almacenados en el Data Warehouse.

---

## 6. Visualizaciones

Las principales visualizaciones utilizadas son:

- Tarjetas KPI.
- Gráficos de barras.
- Gráficos de columnas.
- Gráficos de dona.
- Gráficos de líneas.
- Mapas geográficos.
- Segmentaciones de datos (Slicers).

Cada visualización fue seleccionada de acuerdo con el tipo de información que se desea analizar.

---

## 7. Arquitectura de consumo

El flujo utilizado para alimentar el dashboard es:

Dataset Olist
↓
Procesamiento y preparación de datos
↓
Staging en SQL Server
↓
Procesos ETL
↓
EcommerceDW
↓
Modelo dimensional
↓
Vistas analíticas
↓
Power BI
↓
Dashboard

Power BI funciona como la capa de visualización y consumo de información, mientras que SQL Server mantiene el almacenamiento y procesamiento principal de los datos.

---

## 8. Propósito dentro del proyecto

El dashboard constituye la capa final del proyecto de Data Engineering y Business Intelligence.

Su implementación permite demostrar la capacidad de:

- Integrar datos provenientes de diferentes fuentes.
- Procesar y transformar información mediante procesos ETL.
- Diseñar un Data Warehouse dimensional.
- Crear vistas orientadas al análisis.
- Construir indicadores de negocio.
- Presentar información mediante herramientas de Business Intelligence.
- Facilitar el análisis de ventas, productos, clientes y vendedores.

De esta manera, el proyecto no se limita al almacenamiento de datos, sino que proporciona una solución completa desde la extracción y transformación hasta la visualización y análisis de la información.

---

## 9. Archivo Power BI

**Archivo:** `DataFlow_Analytics_Dashboard.pbix`

**Herramienta:** Microsoft Power BI

**Base de datos:** `EcommerceDW`

**Propósito:** Visualización y análisis de la información procesada en el Data Warehouse.

---

## 10. Estado

El dashboard se encuentra finalizado y corresponde a la capa de visualización y análisis del proyecto Ecommerce Data Warehouse.