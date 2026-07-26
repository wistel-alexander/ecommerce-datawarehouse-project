# Source to Target Mapping

## Project

**Ecommerce Data Warehouse**

---

# FactSales Mapping

| Target Column | Source Table | Source Column | Transformation |
|---------------|-------------|---------------|----------------|
| OrderID | stg_orders | order_id | Direct |
| DateKey | stg_orders | order_purchase_timestamp | Convert date to YYYYMMDD and lookup in DimDate |
| CustomerKey | dw.DimCustomer | CustomerID | Lookup using customer_id |
| ProductKey | dw.DimProduct | ProductID | Lookup using product_id |
| SellerKey | dw.DimSeller | SellerID | Lookup using seller_id |
| Quantity | Constant | 1 | Each row represents one sold product |
| Price | stg_order_items | price | Direct |
| FreightValue | stg_order_items | freight_value | Direct |
| OrderStatus | stg_orders | order_status | UPPER(TRIM()) |
| CreatedDate | System | SYSDATETIME() | Insert timestamp |
| ModifiedDate | System | NULL | Updated only on changes |

---

# Lookup Logic

Customer

```
stg_orders.customer_id

↓

dw.DimCustomer.CustomerID

↓

CustomerKey
```

---

Product

```
stg_order_items.product_id

↓

dw.DimProduct.ProductID

↓

ProductKey
```

---

Seller

```
stg_order_items.seller_id

↓

dw.DimSeller.SellerID

↓

SellerKey
```

---

Date

```
order_purchase_timestamp

↓

CAST(Date)

↓

YYYYMMDD

↓

dw.DimDate.DateKey
```

---

# Business Rules

## Grain

One record represents one product sold in one order.

---

## Quantity

Always equals 1 because each row in
stg_order_items
represents a single sold item.

---

## Order Status

Stored in uppercase.

---

## Payment Value

Not stored in FactSales.

Reason:

Payment belongs to the order, while FactSales represents products.

This avoids duplicated payment amounts during analysis.

---

# ETL Flow

```
stg_orders
        │
        │
        ├──────────────┐
        │              │
        ▼              ▼
stg_order_items   DimCustomer Lookup
        │
        ▼
DimProduct Lookup
        │
        ▼
DimSeller Lookup
        │
        ▼
DimDate Lookup
        │
        ▼
Insert FactSales
```