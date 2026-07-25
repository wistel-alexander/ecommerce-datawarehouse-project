# Análisis del Dataset de Opiniones


## Objetivo

Analizar el dataset de opiniones de clientes para comprender el comportamiento de las calificaciones otorgadas a los pedidos y su utilidad dentro del futuro Data Warehouse.

---

## Resumen del Dataset

| Métrica | Valor |
|---------|------:|
| Total de opiniones | 99,224 |
| Opiniones únicas | 98,410 |
| Pedidos evaluados | 98,673 |
| Filas duplicadas | 0 |
| Valores nulos | 145,903 |

---

## Calidad de los datos

No se identificaron registros duplicados.

Se encontraron algunos valores nulos en las columnas relacionadas con el comentario del cliente, lo cual es esperado ya que muchos usuarios califican únicamente con estrellas sin escribir una opinión.

---

## Distribución de valores nulos

| Columna | Valores nulos |
|---------|--------------:|
| review_comment_title | 87,656 |
| review_comment_message | 58,247 |


---

## Distribución de Calificaciones

| Calificación | Cantidad |
|--------------|---------:|
| 1 estrella(s) | 11,424 |
| 2 estrella(s) | 3,151 |
| 3 estrella(s) | 8,179 |
| 4 estrella(s) | 19,142 |
| 5 estrella(s) | 57,328 |


---

## Estadísticas

| Métrica | Valor |
|---------|------:|
| Calificación promedio | 4.09 |

---

## Observaciones del negocio

- La mayoría de los clientes califican sus compras utilizando la escala de 1 a 5 estrellas.
- No todos los clientes escriben comentarios, aunque sí registran una calificación.
- La calificación promedio permitirá medir el nivel general de satisfacción de los clientes.

---

## Hallazgos técnicos

- Cada opinión está asociada a un pedido.
- El dataset permitirá relacionar satisfacción del cliente con pedidos, productos y vendedores.
- Los comentarios de texto podrán utilizarse posteriormente para proyectos de análisis de sentimiento.

---

## Reglas ETL identificadas

- Se conservará el identificador del pedido como clave de negocio.
- Los comentarios nulos no serán reemplazados, ya que representan un comportamiento normal del negocio.
- La calificación se almacenará como una medida para futuros indicadores de satisfacción.

---

## Decisiones para el Data Warehouse

Este dataset complementará la tabla de hechos **FactSales**.

Permitirá construir indicadores como:

- Calificación promedio.
- Distribución de calificaciones.
- Nivel de satisfacción del cliente.
- Análisis de calidad del servicio.

---

## Conclusiones

El dataset de opiniones representa una fuente importante para medir la experiencia del cliente. Su integración con las ventas permitirá analizar la relación entre logística, productos, vendedores y satisfacción del consumidor.
