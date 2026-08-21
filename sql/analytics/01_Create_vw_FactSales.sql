/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 01_Create_vw_FactSales.sql
Author  : Wistel Alexander
Purpose : Create analytical sales view for reporting
===========================================================
*/

USE EcommerceDW;
GO

--==========================================================
-- Drop view if it already exists
--==========================================================

IF OBJECT_ID('dw.vw_FactSales', 'V') IS NOT NULL
BEGIN
    DROP VIEW dw.vw_FactSales;
    PRINT 'Existing view dw.vw_FactSales dropped.';
END;
GO

--==========================================================
-- Create Analytical View
--==========================================================

CREATE VIEW dw.vw_FactSales
AS
SELECT
    -- Order
    fs.OrderID,

    -- Date
    d.FullDate,
    d.Day,
    d.Month,
    d.MonthName,
    d.Quarter,
    d.Year,
    d.WeekDay,
    d.WeekDayName,
    d.IsWeekend,

    -- Customer
    c.CustomerID,
    c.CustomerUniqueID,
    c.City AS CustomerCity,
    c.State AS CustomerState,

    -- Product
    p.ProductID,
    p.CategoryName,
    p.WeightGrams,
    p.LengthCm,
    p.HeightCm,
    p.WidthCm,

    -- Seller
    s.SellerID,
    s.City AS SellerCity,
    s.State AS SellerState,

    -- Measures
    fs.Quantity,
    fs.Price,
    fs.FreightValue,

    -- Calculated Measures
    CAST(fs.Quantity * fs.Price AS DECIMAL(14,2))
        AS SalesAmount,

    CAST(
        (fs.Quantity * fs.Price) + fs.FreightValue
        AS DECIMAL(14,2)
    ) AS TotalAmount,

    -- Order Status
    fs.OrderStatus

FROM dw.FactSales AS fs

INNER JOIN dw.DimDate AS d
    ON fs.DateKey = d.DateKey

INNER JOIN dw.DimCustomer AS c
    ON fs.CustomerKey = c.CustomerKey

INNER JOIN dw.DimProduct AS p
    ON fs.ProductKey = p.ProductKey

INNER JOIN dw.DimSeller AS s
    ON fs.SellerKey = s.SellerKey;
GO

PRINT 'View dw.vw_FactSales created successfully.';
GO