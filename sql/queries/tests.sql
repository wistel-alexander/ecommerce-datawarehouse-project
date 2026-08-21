SELECT TOP 20 *
FROM dw.vw_FactSales;

SELECT
    COUNT(*) AS TotalRows,
    SUM(Quantity) AS TotalQuantity,
    SUM(SalesAmount) AS TotalSales,
    SUM(FreightValue) AS TotalFreight,
    SUM(TotalAmount) AS TotalAmount
FROM dw.vw_FactSales;

-----------------------------------------------

SELECT DB_NAME() AS CurrentDatabase;



SELECT *
FROM dw.vw_SalesByCategory
ORDER BY TotalSales DESC;


SELECT
    COUNT(*) AS TotalCategories,
    SUM(TotalOrders) AS Orders,
    SUM(TotalUnits) AS Units,
    SUM(TotalSales) AS Sales,
    SUM(TotalFreight) AS Freight,
    SUM(TotalAmount) AS Amount
FROM dw.vw_SalesByCategory;

--------------------------------------------------


USE EcommerceDW;
GO

SELECT *
FROM dw.vw_SalesByMonth
ORDER BY Year, Month;
