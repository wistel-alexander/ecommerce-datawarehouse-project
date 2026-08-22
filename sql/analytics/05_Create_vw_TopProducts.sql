/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 05_Create_vw_TopProducts.sql
Author  : Wistel Alexander
Purpose : Create analytical view of product sales performance
===========================================================
*/

USE EcommerceDW;
GO

--==========================================================
-- Drop view if it already exists
--==========================================================

IF OBJECT_ID('dw.vw_TopProducts', 'V') IS NOT NULL
BEGIN
    DROP VIEW dw.vw_TopProducts;
    PRINT 'Existing view dw.vw_TopProducts dropped.';
END;
GO

--==========================================================
-- Create Analytical View
--==========================================================

CREATE VIEW dw.vw_TopProducts
AS
SELECT
    ProductID,
    CategoryName,

    COUNT(DISTINCT OrderID) AS TotalOrders,

    SUM(Quantity) AS TotalUnits,

    CAST(
        SUM(SalesAmount)
        AS DECIMAL(14,2)
    ) AS TotalSales,

    CAST(
        SUM(FreightValue)
        AS DECIMAL(14,2)
    ) AS TotalFreight,

    CAST(
        SUM(TotalAmount)
        AS DECIMAL(14,2)
    ) AS TotalAmount,

    CAST(
        SUM(SalesAmount) / NULLIF(SUM(Quantity), 0)
        AS DECIMAL(14,2)
    ) AS AverageUnitPrice

FROM dw.vw_FactSales

GROUP BY
    ProductID,
    CategoryName;
GO

PRINT 'View dw.vw_TopProducts created successfully.';
GO