/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 04_Create_DimSeller.sql
Purpose : Create Seller Dimension
===========================================================
*/

IF OBJECT_ID('dw.DimSeller', 'U') IS NOT NULL
    DROP TABLE dw.DimSeller;
GO

CREATE TABLE dw.DimSeller
(
    SellerKey INT IDENTITY(1,1) NOT NULL,

    SellerID VARCHAR(32) NOT NULL,

    ZipCodePrefix INT NOT NULL,

    City VARCHAR(100) NOT NULL,

    State CHAR(2) NOT NULL,

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_DimSeller_CreatedDate
        DEFAULT SYSDATETIME(),

    ModifiedDate DATETIME2 NULL,

    CONSTRAINT PK_DimSeller
        PRIMARY KEY CLUSTERED (SellerKey),

    CONSTRAINT UQ_DimSeller_SellerID
        UNIQUE (SellerID)
);
GO