/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 03_Create_DimProduct.sql
Purpose : Create Product Dimension
===========================================================
*/

IF OBJECT_ID('dw.DimProduct', 'U') IS NOT NULL
    DROP TABLE dw.DimProduct;
GO

CREATE TABLE dw.DimProduct
(
    ProductKey INT IDENTITY(1,1) NOT NULL,

    ProductID VARCHAR(32) NOT NULL,

    CategoryName VARCHAR(100) NULL,

    WeightGrams INT NULL,

    LengthCm DECIMAL(10,2) NULL,

    HeightCm DECIMAL(10,2) NULL,

    WidthCm DECIMAL(10,2) NULL,

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_DimProduct_CreatedDate
        DEFAULT SYSDATETIME(),

    ModifiedDate DATETIME2 NULL,

    CONSTRAINT PK_DimProduct
        PRIMARY KEY CLUSTERED (ProductKey),

    CONSTRAINT UQ_DimProduct_ProductID
        UNIQUE (ProductID)
);
GO