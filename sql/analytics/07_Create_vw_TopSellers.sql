/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 07_Create_vw_TopSellers.sql
Author  : Wistel Alexander
Purpose : Create analytical view of seller sales performance
===========================================================
*/

USE EcommerceDW;
GO

--==========================================================
-- Drop view if it already exists
--==========================================================

IF OBJECT_ID('dw.vw_TopSellers', 'V') IS NOT NULL
BEGIN
    DROP VIEW dw.vw_TopSellers;
    PRINT 'Existing view dw.vw_TopSellers dropped.';
END;
GO

--==========================================================
-- Create Analytical View
--==========================================================

CREATE VIEW dw.vw_TopSellers
AS
SELECT
    SellerID,
    SellerCity,
    SellerState,

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
    SellerID,
    SellerCity,
    SellerState;
GO

PRINT 'View dw.vw_TopSellers created successfully.';
GO