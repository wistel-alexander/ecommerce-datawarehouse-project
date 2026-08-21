/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 02_Create_vw_SalesByCategory.sql
Author  : Wistel Alexander
Purpose : Create analytical view of sales by product category
===========================================================
*/

USE EcommerceDW;
GO

--==========================================================
-- Drop view if it already exists
--==========================================================

IF OBJECT_ID('dw.vw_SalesByCategory', 'V') IS NOT NULL
BEGIN
    DROP VIEW dw.vw_SalesByCategory;
    PRINT 'Existing view dw.vw_SalesByCategory dropped.';
END;
GO

--==========================================================
-- Create Analytical View
--==========================================================

CREATE VIEW dw.vw_SalesByCategory
AS
SELECT
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
    ) AS TotalAmount

FROM dw.vw_FactSales

GROUP BY
    CategoryName;
GO

PRINT 'View dw.vw_SalesByCategory created successfully.';
GO