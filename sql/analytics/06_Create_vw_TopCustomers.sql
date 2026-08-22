/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 06_Create_vw_TopCustomers.sql
Author  : Wistel Alexander
Purpose : Create analytical view of customer sales performance
===========================================================
*/

USE EcommerceDW;
GO

--==========================================================
-- Drop view if it already exists
--==========================================================

IF OBJECT_ID('dw.vw_TopCustomers', 'V') IS NOT NULL
BEGIN
    DROP VIEW dw.vw_TopCustomers;
    PRINT 'Existing view dw.vw_TopCustomers dropped.';
END;
GO

--==========================================================
-- Create Analytical View
--==========================================================

CREATE VIEW dw.vw_TopCustomers
AS
SELECT
    CustomerUniqueID,
    CustomerCity,
    CustomerState,

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
    CustomerUniqueID,
    CustomerCity,
    CustomerState;
GO

PRINT 'View dw.vw_TopCustomers created successfully.';
GO