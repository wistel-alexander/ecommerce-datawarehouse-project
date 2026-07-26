/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 05_Create_FactSales.sql
Purpose : Create Fact Sales Table
===========================================================
*/

IF OBJECT_ID('dw.FactSales', 'U') IS NOT NULL
    DROP TABLE dw.FactSales;
GO

CREATE TABLE dw.FactSales
(
    ---------------------------------------------------------
    -- Surrogate Key
    ---------------------------------------------------------
    SalesKey BIGINT IDENTITY(1,1) NOT NULL,

    ---------------------------------------------------------
    -- Degenerate Dimension
    ---------------------------------------------------------
    OrderID VARCHAR(32) NOT NULL,

    ---------------------------------------------------------
    -- Foreign Keys
    ---------------------------------------------------------
    DateKey INT NOT NULL,

    CustomerKey INT NOT NULL,

    ProductKey INT NOT NULL,

    SellerKey INT NOT NULL,

    ---------------------------------------------------------
    -- Measures
    ---------------------------------------------------------
    Quantity SMALLINT NOT NULL,

    Price DECIMAL(12,2) NOT NULL,

    FreightValue DECIMAL(12,2) NOT NULL,

    ---------------------------------------------------------
    -- Order Attributes
    ---------------------------------------------------------
    OrderStatus VARCHAR(20) NOT NULL,

    ---------------------------------------------------------
    -- Audit
    ---------------------------------------------------------
    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_FactSales_CreatedDate
        DEFAULT SYSDATETIME(),

    ModifiedDate DATETIME2 NULL,

    ---------------------------------------------------------
    -- Primary Key
    ---------------------------------------------------------
    CONSTRAINT PK_FactSales
        PRIMARY KEY CLUSTERED (SalesKey),

    ---------------------------------------------------------
    -- Foreign Keys
    ---------------------------------------------------------
    CONSTRAINT FK_FactSales_Date
        FOREIGN KEY (DateKey)
        REFERENCES dw.DimDate(DateKey),

    CONSTRAINT FK_FactSales_Customer
        FOREIGN KEY (CustomerKey)
        REFERENCES dw.DimCustomer(CustomerKey),

    CONSTRAINT FK_FactSales_Product
        FOREIGN KEY (ProductKey)
        REFERENCES dw.DimProduct(ProductKey),

    CONSTRAINT FK_FactSales_Seller
        FOREIGN KEY (SellerKey)
        REFERENCES dw.DimSeller(SellerKey)
);
GO

---------------------------------------------------------
-- Indexes
---------------------------------------------------------

CREATE INDEX IX_FactSales_DateKey
ON dw.FactSales(DateKey);
GO

CREATE INDEX IX_FactSales_CustomerKey
ON dw.FactSales(CustomerKey);
GO

CREATE INDEX IX_FactSales_ProductKey
ON dw.FactSales(ProductKey);
GO

CREATE INDEX IX_FactSales_SellerKey
ON dw.FactSales(SellerKey);
GO