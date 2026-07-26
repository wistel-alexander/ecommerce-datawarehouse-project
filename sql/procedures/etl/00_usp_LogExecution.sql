/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 00_usp_LogExecution.sql
Purpose : Register ETL Execution Results
===========================================================
*/

CREATE OR ALTER PROCEDURE etl.usp_LogExecution

    @BatchID UNIQUEIDENTIFIER,

    @ProcessName VARCHAR(100),

    @StartTime DATETIME2,

    @EndTime DATETIME2,

    @RowsInserted INT = NULL,

    @RowsUpdated INT = NULL,

    @Status VARCHAR(20),

    @ErrorMessage NVARCHAR(MAX) = NULL

AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO etl.ExecutionLog
    (
        BatchID,

        ProcessName,

        StartTime,

        EndTime,

        DurationSeconds,

        RowsInserted,

        RowsUpdated,

        Status,

        ErrorMessage
    )

    VALUES
    (

        @BatchID,

        @ProcessName,

        @StartTime,

        @EndTime,

        DATEDIFF(MILLISECOND,@StartTime,@EndTime)/1000.0,

        @RowsInserted,

        @RowsUpdated,

        @Status,

        @ErrorMessage

    );

END;
GO