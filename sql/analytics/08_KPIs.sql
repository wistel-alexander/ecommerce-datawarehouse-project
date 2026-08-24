/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 08_KPIs.sql
Author  : Wistel Alexander
Purpose : Calculate main business KPIs
===========================================================
*/

USE EcommerceDW;
GO

--==========================================================
-- Main Sales KPIs
--==========================================================

SELECT
    COUNT(DISTINCT OrderID) AS TotalOrders,

    COUNT(DISTINCT CustomerUniqueID) AS TotalCustomers,

    COUNT(DISTINCT ProductID) AS TotalProducts,

    COUNT(DISTINCT SellerID) AS TotalSellers,

    SUM(Quantity) AS TotalUnitsSold,

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
    ) AS TotalRevenue,

    CAST(
        SUM(SalesAmount) / NULLIF(COUNT(DISTINCT OrderID), 0)
        AS DECIMAL(14,2)
    ) AS AverageOrderValue

FROM dw.vw_FactSales;
GO