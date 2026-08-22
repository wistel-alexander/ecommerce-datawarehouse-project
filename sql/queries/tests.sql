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

SELECT
    COUNT(*) AS TotalStates,
    SUM(TotalUnits) AS TotalUnits,
    SUM(TotalSales) AS TotalSales,
    SUM(TotalFreight) AS TotalFreight,
    SUM(TotalAmount) AS TotalAmount
FROM dw.vw_SalesByState;

----------------------------------------------

USE EcommerceDW;
GO

SELECT TOP 20 *
FROM dw.vw_TopProducts
ORDER BY TotalSales DESC;


-----------------------------------------------


USE EcommerceDW;
GO

SELECT TOP 20 *
FROM dw.vw_TopCustomers
ORDER BY TotalSales DESC;



SELECT TOP 20
    CustomerUniqueID,
    CustomerCity,
    CustomerState,
    TotalOrders,
    TotalUnits,
    TotalSales
FROM dw.vw_TopCustomers
ORDER BY TotalOrders DESC;