/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 03_Create_vw_SalesByMonth.sql
Author  : Wistel Alexander
Purpose : Create analytical view of sales by month
===========================================================
*/

USE EcommerceDW;
GO

--==========================================================
-- Drop view if it already exists
--==========================================================

IF OBJECT_ID('dw.vw_SalesByMonth', 'V') IS NOT NULL
BEGIN
    DROP VIEW dw.vw_SalesByMonth;
    PRINT 'Existing view dw.vw_SalesByMonth dropped.';
END;
GO

--==========================================================
-- Create Analytical View
--==========================================================

CREATE VIEW dw.vw_SalesByMonth
AS
SELECT
    Year,
    Month,
    MonthName,
    Quarter,

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
    Year,
    Month,
    MonthName,
    Quarter;
GO

PRINT 'View dw.vw_SalesByMonth created successfully.';
GO