/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 01_Create_DimDate.sql
Author  : Wistel Alexander
Purpose : Create the DimDate dimension table
===========================================================
*/

USE EcommerceDW;
GO

--==========================================================
-- Drop table if it already exists (Development only)
--==========================================================

IF OBJECT_ID('dw.DimDate', 'U') IS NOT NULL
BEGIN
    DROP TABLE dw.DimDate;
    PRINT 'Existing table dw.DimDate dropped.';
END;
GO

--==========================================================
-- Create Dimension Table
--==========================================================

CREATE TABLE dw.DimDate
(
    DateKey INT NOT NULL,

    FullDate DATE NOT NULL,

    Day TINYINT NOT NULL,

    Month TINYINT NOT NULL,

    MonthName VARCHAR(20) NOT NULL,

    Quarter TINYINT NOT NULL,

    Year SMALLINT NOT NULL,

    WeekDay TINYINT NOT NULL,

    WeekDayName VARCHAR(20) NOT NULL,

    IsWeekend BIT NOT NULL
        CONSTRAINT DF_DimDate_IsWeekend DEFAULT (0),

    CONSTRAINT PK_DimDate
        PRIMARY KEY (DateKey)
);
GO

PRINT 'Table dw.DimDate created successfully.';
GO