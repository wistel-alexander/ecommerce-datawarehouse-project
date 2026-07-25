# Análisis del Dataset de Vendedores


## Objetivo

Analizar el dataset de vendedores para comprender su distribución geográfica y su importancia dentro del futuro Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de vendedores | 3,095 |
| Vendedores únicos | 3,095 |
| Filas duplicadas | 0 |
| Valores nulos | 0 |
| Ciudades | 611 |
| Estados | 23 |

---

## Calidad de los datos

No se identificaron registros duplicados ni valores nulos.

La estructura del dataset presenta una alta calidad y no requiere procesos de limpieza antes de la transformación.

---

## Distribución de valores nulos

No se encontraron valores nulos.

---

## Distribución geográfica de vendedores

| Estado | Cantidad |
|---------|---------:|
| SP | 1,849 |
| PR | 349 |
| MG | 244 |
| SC | 190 |
| RJ | 171 |
| RS | 129 |
| GO | 40 |
| DF | 30 |
| ES | 23 |
| BA | 19 |


---

## Observaciones del negocio

- Los vendedores se encuentran distribuidos en diferentes estados de Brasil.
- La concentración de vendedores por estado permitirá realizar análisis geográficos de las ventas.
- La información de ubicación facilitará la construcción de indicadores regionales.

---

## Hallazgos técnicos

- Cada vendedor posee un identificador único.
- No existen registros duplicados.
- No existen valores nulos.
- El dataset será utilizado para construir la dimensión de vendedores.

---

## Reglas ETL identificadas

- Se conservará el identificador original (**seller_id**) como clave de negocio.
- Se generará una clave sustituta (**SellerKey**) durante el proceso ETL.
- Los nombres de ciudades se estandarizarán para evitar diferencias por mayúsculas o espacios.
- Los estados conservarán su abreviatura oficial.

---

## Decisiones para el Data Warehouse

Este dataset será la fuente principal para construir la dimensión **DimSeller**.

Permitirá almacenar atributos como:

- SellerKey.
- seller_id.
- Ciudad.
- Estado.

Además permitirá construir indicadores como:

- Ventas por estado.
- Ventas por ciudad.
- Participación de vendedores por región.
- Distribución geográfica de las ventas.

---

## Conclusiones

El dataset de vendedores presenta una excelente calidad de datos y permitirá construir la dimensión **DimSeller**, facilitando análisis geográficos y regionales dentro del Data Warehouse.
