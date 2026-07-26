/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 01_Create_ExecutionLog.sql
Purpose : Create ETL Execution Log Table
===========================================================
*/

IF OBJECT_ID('etl.ExecutionLog', 'U') IS NOT NULL
    DROP TABLE etl.ExecutionLog;
GO

CREATE TABLE etl.ExecutionLog
(
    ExecutionID INT IDENTITY(1,1) NOT NULL,

    BatchID UNIQUEIDENTIFIER NOT NULL,

    ProcessName VARCHAR(100) NOT NULL,

    StartTime DATETIME2 NOT NULL,

    EndTime DATETIME2 NULL,

    DurationSeconds DECIMAL(10,2) NULL,

    RowsInserted INT NULL,

    RowsUpdated INT NULL,

    Status VARCHAR(20) NOT NULL,

    ErrorMessage NVARCHAR(MAX) NULL,

    CONSTRAINT PK_ExecutionLog
        PRIMARY KEY CLUSTERED (ExecutionID)
);
GO