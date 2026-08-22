/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 04_Create_vw_SalesByState.sql
Author  : Wistel Alexander
Purpose : Create analytical view of sales by customer state
===========================================================
*/

USE EcommerceDW;
GO

--==========================================================
-- Drop view if it already exists
--==========================================================

IF OBJECT_ID('dw.vw_SalesByState', 'V') IS NOT NULL
BEGIN
    DROP VIEW dw.vw_SalesByState;
    PRINT 'Existing view dw.vw_SalesByState dropped.';
END;
GO

--==========================================================
-- Create Analytical View
--==========================================================

CREATE VIEW dw.vw_SalesByState
AS
SELECT
    CustomerState,

    COUNT(DISTINCT OrderID) AS TotalOrders,

    COUNT(DISTINCT CustomerUniqueID) AS TotalCustomers,

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
    CustomerState;
GO

PRINT 'View dw.vw_SalesByState created successfully.';
GO