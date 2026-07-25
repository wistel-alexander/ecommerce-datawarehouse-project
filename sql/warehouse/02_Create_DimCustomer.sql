/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 02_Create_DimCustomer.sql
Purpose : Create Customer Dimension
===========================================================
*/

IF OBJECT_ID('dw.DimCustomer', 'U') IS NOT NULL
    DROP TABLE dw.DimCustomer;
GO

CREATE TABLE dw.DimCustomer
(
    ----------------------------------------------------------------
    -- Surrogate Key
    ----------------------------------------------------------------
    CustomerKey INT IDENTITY(1,1) NOT NULL,

    ----------------------------------------------------------------
    -- Business Key
    ----------------------------------------------------------------
    CustomerID VARCHAR(32) NOT NULL,

    ----------------------------------------------------------------
    -- Customer Attributes
    ----------------------------------------------------------------
    CustomerUniqueID VARCHAR(32) NOT NULL,

    ZipCodePrefix INT NOT NULL,

    City VARCHAR(100) NOT NULL,

    State CHAR(2) NOT NULL,

    ----------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------
    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_DimCustomer_CreatedDate
        DEFAULT SYSDATETIME(),

    ModifiedDate DATETIME2 NULL,

    ----------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------
    CONSTRAINT PK_DimCustomer
        PRIMARY KEY CLUSTERED (CustomerKey),

    CONSTRAINT UQ_DimCustomer_CustomerID
        UNIQUE (CustomerID)
);
GO