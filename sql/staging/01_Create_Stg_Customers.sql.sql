/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 01_Create_Stg_Customers.sql
Author  : Wistel Alexander
Purpose : Create staging table for customers dataset
===========================================================
*/

USE EcommerceDW;
GO

------------------------------------------------------------
-- Drop Table
------------------------------------------------------------

IF OBJECT_ID('stg.stg_customers', 'U') IS NOT NULL
BEGIN
    DROP TABLE stg.stg_customers;
    PRINT 'Table stg.stg_customers dropped.';
END;
GO

------------------------------------------------------------
-- Create Staging Table
------------------------------------------------------------

CREATE TABLE stg.stg_customers
(
    customer_id NVARCHAR(50) NOT NULL,

    customer_unique_id NVARCHAR(50) NOT NULL,

    customer_zip_code_prefix INT NULL,

    customer_city NVARCHAR(100) NULL,

    customer_state CHAR(2) NULL,

    LoadDate DATETIME2 NOT NULL
        CONSTRAINT DF_stg_customers_LoadDate
        DEFAULT SYSDATETIME()
);
GO

PRINT 'Table stg.stg_customers created successfully.';
GO