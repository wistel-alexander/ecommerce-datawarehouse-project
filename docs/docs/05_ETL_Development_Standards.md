# ETL Development Standards

## Project

**Ecommerce Data Warehouse**

---

# Purpose

This document defines the development standards used throughout the ETL project.

Following these standards guarantees consistency, maintainability, scalability and readability.

---

# SQL Server Standards

## Schemas

The project is organized using the following schemas:

| Schema | Purpose |
|---------|---------|
| stg | Staging tables |
| dw | Data Warehouse tables |
| etl | Stored Procedures |

---

## Naming Convention

### Staging Tables

```
stg.stg_customers
stg.stg_products
stg.stg_orders
```

---

### Dimension Tables

```
dw.DimDate
dw.DimCustomer
dw.DimProduct
dw.DimSeller
```

---

### Fact Tables

```
dw.FactSales
```

---

### Stored Procedures

```
etl.usp_Load_DimDate
etl.usp_Load_DimCustomer
etl.usp_Load_DimProduct
etl.usp_Load_DimSeller
etl.usp_Load_FactSales
```

---

# Stored Procedure Structure

Every ETL procedure follows the same structure.

```
Variables

↓

TRY

↓

BEGIN TRANSACTION

↓

Business Logic

↓

COMMIT

↓

Summary

↓

CATCH

↓

ROLLBACK

↓

THROW
```

---

# Error Handling

All procedures must:

- Use TRY...CATCH
- Use explicit transactions
- Rollback on failure
- Re-throw SQL Server errors
- Print execution summary

---

# Python Standards

Project structure

```
etl/

config/

load/

transform/

run_staging.py

run_etl.py

execute_procedure.py
```

---

## Loader Scripts

Each dataset has its own loader.

Example:

```
load_customers.py

load_products.py

load_orders.py
```

Responsibilities:

- Read CSV
- Validate data
- Load into Staging

---

## Transformation Layer

Business transformations belong in:

```
etl/transform/
```

Transformations should never be embedded inside orchestration scripts.

---

## Orchestration

Execution order:

```
CSV Files

↓

Staging

↓

Dimensions

↓

Fact Tables

↓

Power BI
```

---

# Design Principles

The project follows these principles:

- Single Responsibility Principle
- Modular Design
- Reusable Components
- Clear Layer Separation
- Idempotent Loads
- Maintainable Code

---

# Slowly Changing Dimensions

Dimension strategy:

| Dimension | Type |
|-----------|------|
| DimDate | Static |
| DimCustomer | SCD Type 1 |
| DimProduct | SCD Type 1 |
| DimSeller | SCD Type 1 |

---

# Coding Style

SQL

- Uppercase SQL keywords
- Descriptive aliases
- One responsibility per procedure
- Consistent comments

Python

- snake_case
- Type hints
- Docstrings
- Small reusable functions

---

# ETL Workflow

```
run_etl.py

↓

run_staging.py

↓

execute_procedure.py

↓

Stored Procedures

↓

Data Warehouse
```

---

# Future Improvements

Planned improvements:

- Logging table
- ETL execution history
- Incremental loads
- Configuration file
- Scheduler integration
- Power BI automatic refresh