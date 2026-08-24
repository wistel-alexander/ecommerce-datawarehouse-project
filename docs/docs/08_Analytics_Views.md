# Analytics Layer – Ecommerce Data Warehouse

## 1. Descripción

La carpeta `analytics` contiene la capa de análisis del proyecto **Ecommerce Data Warehouse**.

Esta capa tiene como propósito transformar el modelo dimensional del Data Warehouse en estructuras orientadas al análisis y consumo de información empresarial.

Las consultas y vistas desarrolladas en esta capa permiten analizar las ventas desde diferentes perspectivas, como:

* Ventas generales.
* Categorías de productos.
* Evolución mensual.
* Distribución geográfica.
* Desempeño de productos.
* Desempeño de clientes.
* Desempeño de vendedores.
* Indicadores clave de desempeño (KPIs).

La capa analítica se encuentra ubicada después del proceso ETL y del modelo dimensional, por lo que consume principalmente información proveniente de las tablas del esquema `dw`.

Su objetivo es facilitar el análisis de los datos sin modificar directamente las tablas del Data Warehouse.

---

# 2. Estructura de la capa Analytics

La estructura de esta capa es la siguiente:

```text
analytics/
│
├── 01_Create_vw_FactSales.sql
├── 02_Create_vw_SalesByCategory.sql
├── 03_Create_vw_SalesByMonth.sql
├── 04_Create_vw_SalesByState.sql
├── 05_Create_vw_TopProducts.sql
├── 06_Create_vw_TopCustomers.sql
├── 07_Create_vw_TopSellers.sql
└── 08_KPIs.sql
```

Cada archivo tiene una responsabilidad específica dentro del proceso de análisis.

---

# 3. Vista `vw_FactSales`

### Archivo

```text
01_Create_vw_FactSales.sql
```

### Nombre de la vista

```text
dw.vw_FactSales
```

### Propósito

La vista `vw_FactSales` constituye la principal capa de consulta para el análisis de las ventas.

Su función es presentar en una estructura de fácil consumo la información almacenada en la tabla de hechos `dw.FactSales`, incorporando también los atributos descriptivos de las dimensiones relacionadas.

De esta manera, el usuario de negocio no necesita trabajar directamente con las claves sustitutas del modelo dimensional.

### Información principal

La vista integra información relacionada con:

* Pedidos.
* Fechas.
* Clientes.
* Productos.
* Vendedores.
* Cantidades.
* Precios.
* Fletes.
* Estado de los pedidos.

Entre los principales campos utilizados se encuentran:

```text
OrderID
DateKey
CustomerUniqueID
CustomerCity
CustomerState
ProductID
CategoryName
SellerID
SellerCity
SellerState
Quantity
Price
FreightValue
SalesAmount
TotalAmount
OrderStatus
```

### Medidas calculadas

La vista permite trabajar con medidas derivadas como:

**SalesAmount**

Representa el valor de los productos vendidos.

**TotalAmount**

Representa el valor total considerando el valor de los productos y el flete.

### Importancia dentro de la arquitectura

Esta vista funciona como una capa de abstracción entre el modelo dimensional y las consultas analíticas.

Las demás vistas de la carpeta `analytics` utilizan esta estructura como fuente principal para realizar sus respectivas agregaciones.

---

# 4. Vista `vw_SalesByCategory`

### Archivo

```text
02_Create_vw_SalesByCategory.sql
```

### Nombre de la vista

```text
dw.vw_SalesByCategory
```

### Propósito

Esta vista permite analizar el comportamiento de las ventas según la categoría de producto.

Responde principalmente a la pregunta:

> ¿Qué categorías de productos generan mayor volumen de ventas?

### Principales indicadores

La vista presenta información como:

* Categoría del producto.
* Número de pedidos.
* Unidades vendidas.
* Ventas totales.
* Flete total.
* Ingreso total.

### Campos principales

```text
CategoryName
TotalOrders
TotalUnits
TotalSales
TotalFreight
TotalAmount
```

### Agrupación

La información se agrupa por:

```text
CategoryName
```

Esto permite comparar el desempeño comercial de las diferentes categorías existentes en el Data Warehouse.

### Utilidad para el negocio

Esta vista puede utilizarse para:

* Identificar las categorías con mayor facturación.
* Comparar volumen de unidades vendidas.
* Analizar el impacto del transporte sobre las ventas.
* Identificar categorías de mayor importancia comercial.
* Construir gráficos de ventas por categoría en Power BI.

---

# 5. Vista `vw_SalesByMonth`

### Archivo

```text
03_Create_vw_SalesByMonth.sql
```

### Nombre de la vista

```text
dw.vw_SalesByMonth
```

### Propósito

Esta vista permite analizar la evolución de las ventas a través del tiempo.

Responde principalmente a la pregunta:

> ¿Cómo se comportan las ventas durante los diferentes meses y períodos?

### Principales indicadores

La vista contiene:

* Año.
* Mes.
* Nombre del mes.
* Trimestre.
* Número de pedidos.
* Unidades vendidas.
* Ventas.
* Fletes.
* Ingresos totales.

### Campos principales

```text
Year
Month
MonthName
Quarter
TotalOrders
TotalUnits
TotalSales
TotalFreight
TotalAmount
```

### Agrupación

La información se agrupa por:

```text
Year
Month
MonthName
Quarter
```

Esto permite conservar la información temporal necesaria para realizar análisis cronológicos.

### Utilidad para el negocio

Esta vista permite:

* Analizar tendencias de ventas.
* Comparar períodos.
* Identificar meses con mayor actividad comercial.
* Analizar ventas por trimestre.
* Construir gráficos de evolución temporal.
* Identificar posibles comportamientos estacionales.

Es especialmente útil para construir gráficos de líneas y columnas en Power BI.

---

# 6. Vista `vw_SalesByState`

### Archivo

```text
04_Create_vw_SalesByState.sql
```

### Nombre de la vista

```text
dw.vw_SalesByState
```

### Propósito

Esta vista permite analizar la distribución geográfica de las ventas según el estado donde se encuentra el cliente.

Responde principalmente a la pregunta:

> ¿En qué estados se concentra la actividad comercial?

### Principales indicadores

La vista presenta:

* Estado del cliente.
* Número de pedidos.
* Número de clientes.
* Unidades vendidas.
* Ventas totales.
* Fletes.
* Ingresos totales.

### Campos principales

```text
CustomerState
TotalOrders
TotalCustomers
TotalUnits
TotalSales
TotalFreight
TotalAmount
```

### Agrupación

La información se agrupa por:

```text
CustomerState
```

### Utilidad para el negocio

Esta vista permite:

* Identificar los estados con mayor volumen de ventas.
* Conocer la distribución geográfica de los clientes.
* Comparar mercados regionales.
* Identificar zonas con mayor potencial comercial.
* Construir mapas y visualizaciones geográficas en Power BI.

---

# 7. Vista `vw_TopProducts`

### Archivo

```text
05_Create_vw_TopProducts.sql
```

### Nombre de la vista

```text
dw.vw_TopProducts
```

### Propósito

Esta vista permite analizar el desempeño comercial de los productos.

Responde principalmente a la pregunta:

> ¿Qué productos generan mayor volumen de ventas?

La vista no limita los resultados a una cantidad específica de productos. En lugar de utilizar directamente un `TOP 10` o `TOP 20`, conserva los productos agregados para que posteriormente puedan aplicarse diferentes filtros desde las herramientas de análisis.

### Principales indicadores

La vista contiene:

* Identificador del producto.
* Categoría.
* Número de pedidos.
* Unidades vendidas.
* Ventas totales.
* Flete total.
* Ingreso total.
* Precio unitario promedio.

### Campos principales

```text
ProductID
CategoryName
TotalOrders
TotalUnits
TotalSales
TotalFreight
TotalAmount
AverageUnitPrice
```

### Indicador `AverageUnitPrice`

Este indicador se calcula a partir del valor total de las ventas y las unidades vendidas.

Permite obtener una referencia del valor promedio por unidad comercializada.

### Utilidad para el negocio

Esta vista permite:

* Identificar productos de mayor facturación.
* Identificar productos con mayor cantidad de unidades vendidas.
* Comparar productos dentro de una misma categoría.
* Analizar diferencias entre volumen y valor de venta.
* Construir rankings de productos en Power BI.

---

# 8. Vista `vw_TopCustomers`

### Archivo

```text
06_Create_vw_TopCustomers.sql
```

### Nombre de la vista

```text
dw.vw_TopCustomers
```

### Propósito

Esta vista permite analizar el comportamiento de compra de los clientes.

Responde principalmente a la pregunta:

> ¿Cuáles son los clientes que generan mayor valor de ventas?

### Principales indicadores

La vista contiene:

* Identificador único del cliente.
* Ciudad.
* Estado.
* Número de pedidos.
* Unidades compradas.
* Ventas totales.
* Fletes.
* Ingresos totales.

### Campos principales

```text
CustomerUniqueID
CustomerCity
CustomerState
TotalOrders
TotalUnits
TotalSales
TotalFreight
TotalAmount
```

### Agrupación

La información se agrupa utilizando:

```text
CustomerUniqueID
CustomerCity
CustomerState
```

El uso de `CustomerUniqueID` permite analizar el comportamiento del cliente real a través de sus diferentes compras.

### Utilidad para el negocio

Esta vista permite:

* Identificar clientes de mayor valor.
* Analizar frecuencia de compra.
* Comparar clientes por volumen de compras.
* Identificar clientes importantes para estrategias de fidelización.
* Crear rankings de clientes en Power BI.

---

# 9. Vista `vw_TopSellers`

### Archivo

```text
07_Create_vw_TopSellers.sql
```

### Nombre de la vista

```text
dw.vw_TopSellers
```

### Propósito

Esta vista permite analizar el desempeño comercial de los vendedores.

Responde principalmente a la pregunta:

> ¿Qué vendedores generan mayor volumen de ventas?

### Principales indicadores

La vista contiene:

* Identificador del vendedor.
* Ciudad.
* Estado.
* Número de pedidos.
* Unidades vendidas.
* Ventas totales.
* Fletes.
* Ingresos totales.

### Campos principales

```text
SellerID
SellerCity
SellerState
TotalOrders
TotalUnits
TotalSales
TotalFreight
TotalAmount
```

### Agrupación

La información se agrupa por:

```text
SellerID
SellerCity
SellerState
```

### Utilidad para el negocio

Esta vista permite:

* Identificar vendedores con mayor facturación.
* Comparar vendedores por número de pedidos.
* Analizar unidades comercializadas.
* Analizar distribución geográfica de vendedores.
* Construir rankings de desempeño en Power BI.

---

# 10. Archivo `08_KPIs.sql`

### Archivo

```text
08_KPIs.sql
```

### Propósito

El archivo `08_KPIs.sql` contiene las consultas utilizadas para obtener los principales indicadores generales del negocio.

A diferencia de las siete vistas anteriores, este archivo funciona como una consulta de indicadores y no como una vista permanente.

### Principales KPIs

Los indicadores calculados son:

```text
TotalOrders
TotalCustomers
TotalProducts
TotalSellers
TotalUnitsSold
TotalSales
TotalFreight
TotalRevenue
AverageOrderValue
```

### Descripción

**TotalOrders**

Cantidad total de pedidos registrados.

**TotalCustomers**

Cantidad de clientes únicos involucrados en las ventas.

**TotalProducts**

Cantidad de productos diferentes vendidos.

**TotalSellers**

Cantidad de vendedores involucrados en las ventas.

**TotalUnitsSold**

Cantidad total de unidades comercializadas.

**TotalSales**

Valor total correspondiente a los productos vendidos.

**TotalFreight**

Valor total asociado al transporte.

**TotalRevenue**

Valor total considerando las ventas y el transporte.

**AverageOrderValue**

Valor promedio de venta por pedido.

### Utilidad

Estos indicadores permiten obtener una visión general del comportamiento comercial del Data Warehouse y sirven como base para construir un tablero ejecutivo en Power BI.

---

# 11. Validación de la capa Analytics

Durante el desarrollo de esta capa se realizaron pruebas individuales sobre las vistas creadas.

Cada vista fue ejecutada directamente en SQL Server mediante consultas `SELECT`, verificando que:

* La vista pudiera crearse correctamente.
* Los registros fueran retornados correctamente.
* Las agrupaciones funcionaran de acuerdo con el nivel de análisis definido.
* Las medidas calculadas presentaran resultados.
* Las vistas pudieran ser consultadas desde el esquema `dw`.

Las pruebas realizadas permitieron validar la funcionalidad de las ocho estructuras desarrolladas.

---

# 12. Relación con el Data Warehouse

La capa `analytics` utiliza principalmente la vista:

```text
dw.vw_FactSales
```

como punto de acceso a la información dimensional y de hechos.

La arquitectura simplificada es:

```text
Datos fuente
     │
     ▼
Staging
     │
     ▼
ETL / Procedures
     │
     ▼
Data Warehouse
     │
     ├── DimDate
     ├── DimCustomer
     ├── DimProduct
     ├── DimSeller
     └── FactSales
            │
            ▼
      vw_FactSales
            │
            ▼
       Analytics
            │
     ┌──────┼────────┐
     ▼      ▼        ▼
Categoría  Mes    Geografía
     │
     ├── Productos
     ├── Clientes
     └── Vendedores
            │
            ▼
         Power BI
```

Esta separación permite mantener diferenciadas las responsabilidades de cada componente del proyecto.

---

# 13. Relación con Power BI

La capa `analytics` está diseñada para facilitar el consumo posterior de información desde herramientas de Business Intelligence.

Power BI podrá utilizar estas vistas para construir diferentes tipos de visualizaciones, por ejemplo:

### Indicadores generales

* Ventas totales.
* Pedidos.
* Clientes.
* Productos.
* Vendedores.
* Unidades vendidas.
* Valor promedio del pedido.

### Análisis comercial

* Ventas por categoría.
* Productos más vendidos.
* Clientes de mayor valor.
* Vendedores con mejor desempeño.

### Análisis temporal

* Evolución mensual.
* Comparación entre períodos.
* Ventas por trimestre.

### Análisis geográfico

* Ventas por estado.
* Clientes por ubicación.
* Distribución regional de las ventas.

---

# 14. Consideraciones sobre calidad de datos

Las vistas de esta capa no modifican directamente los datos originales del Data Warehouse.

Por ejemplo, si un producto presenta una categoría `NULL`, la capa analítica conserva inicialmente dicha información en lugar de modificarla directamente.

Esto permite mantener la trazabilidad de los datos y diferenciar entre:

* Datos disponibles.
* Datos faltantes.
* Datos transformados durante el proceso ETL.

Las transformaciones adicionales orientadas específicamente a visualización podrán realizarse posteriormente cuando se defina el modelo de consumo en Power BI.

---

# 15. Beneficios de la capa Analytics

La implementación de esta capa proporciona varias ventajas:

1. **Separación de responsabilidades**

   El Data Warehouse almacena la información estructurada, mientras que la capa analítica prepara los datos para responder preguntas de negocio.

2. **Reutilización**

   Las vistas pueden ser utilizadas por diferentes consultas y herramientas sin repetir la lógica de combinación y agregación.

3. **Facilidad de análisis**

   Los usuarios no necesitan conocer la estructura interna completa del modelo dimensional.

4. **Integración con BI**

   Las vistas proporcionan estructuras adecuadas para su posterior consumo desde Power BI.

5. **Mantenimiento**

   La lógica analítica se encuentra organizada en archivos independientes y fácilmente identificables.

6. **Escalabilidad**

   En el futuro pueden agregarse nuevas vistas analíticas sin modificar la estructura principal del Data Warehouse.

---

# 16. Estado actual

La primera versión de la capa Analytics se encuentra implementada y validada.

Las estructuras desarrolladas son:

| Archivo                            | Objeto                  | Estado   |
| ---------------------------------- | ----------------------- | -------- |
| `01_Create_vw_FactSales.sql`       | `dw.vw_FactSales`       | Validada |
| `02_Create_vw_SalesByCategory.sql` | `dw.vw_SalesByCategory` | Validada |
| `03_Create_vw_SalesByMonth.sql`    | `dw.vw_SalesByMonth`    | Validada |
| `04_Create_vw_SalesByState.sql`    | `dw.vw_SalesByState`    | Validada |
| `05_Create_vw_TopProducts.sql`     | `dw.vw_TopProducts`     | Validada |
| `06_Create_vw_TopCustomers.sql`    | `dw.vw_TopCustomers`    | Validada |
| `07_Create_vw_TopSellers.sql`      | `dw.vw_TopSellers`      | Validada |
| `08_KPIs.sql`                      | Consulta de KPIs        | Validada |

La capa queda preparada para la siguiente etapa del proyecto: **consumo y visualización de la información mediante una herramienta de Business Intelligence como Power BI**.
