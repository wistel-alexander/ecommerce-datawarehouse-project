# FactSales Design

## Project

**Ecommerce Data Warehouse**

---

# Business Process

The business process modeled in the Data Warehouse is:

> Product Sales

Each record represents the sale of a single product within an order.

---

# Granularity

**Grain**

One row represents:

> One product sold in one customer order.

This means that an order containing three products will generate three rows in the fact table.

Example

| Order | Product |
|--------|----------|
| 1001 | Product A |
| 1001 | Product B |
| 1001 | Product C |

FactSales will contain:

| Order | Product |
|--------|----------|
|1001|Product A|
|1001|Product B|
|1001|Product C|

---

# Dimensions

The fact table references the following dimensions.

| Dimension | Key |
|-----------|------|
| Date | DateKey |
| Customer | CustomerKey |
| Product | ProductKey |
| Seller | SellerKey |

---

# Degenerate Dimension

The following business key is stored directly inside the fact table.

| Column |
|---------|
| OrderID |

OrderID is kept for traceability and operational analysis.

---

# Measures

The fact table stores the following business measures.

| Measure | Description |
|----------|-------------|
| Quantity | Number of units sold |
| Price | Product selling price |
| FreightValue | Shipping cost |
| PaymentValue | Customer payment amount |

---

# Order Attributes

Additional order information:

| Attribute |
|-----------|
| OrderStatus |

---

# Audit Columns

The table includes technical audit information.

| Column |
|---------|
| CreatedDate |
| ModifiedDate |

---

# Source Tables

The fact table is built from multiple staging tables.

| Source |
|---------|
| stg_orders |
| stg_order_items |
| stg_payments |

Dimension lookups:

| Dimension |
|-----------|
| dw.DimCustomer |
| dw.DimProduct |
| dw.DimSeller |
| dw.DimDate |

---

# ETL Flow

```
CSV Files
      │
      ▼
Staging Tables
      │
      ▼
Join Source Tables
      │
      ▼
Lookup Dimension Keys
      │
      ▼
Build FactSales
      │
      ▼
Power BI
```

---

# Fact Table Structure

```
FactSales

SalesKey

OrderID

DateKey

CustomerKey

ProductKey

SellerKey

Quantity

Price

FreightValue

PaymentValue

OrderStatus

CreatedDate

ModifiedDate
```

---

# Relationships

```
DimCustomer
        │
DimProduct
        │
DimSeller
        │
DimDate
        │
        ▼
     FactSales
```