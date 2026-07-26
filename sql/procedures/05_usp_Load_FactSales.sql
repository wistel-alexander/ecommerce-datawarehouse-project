/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 05_usp_Load_FactSales.sql
Purpose : Load FactSales Table
Author  : Wistel Alexander
===========================================================
*/

CREATE OR ALTER PROCEDURE etl.usp_Load_FactSales

    @BatchID UNIQUEIDENTIFIER

AS
BEGIN

    SET NOCOUNT ON;

    ---------------------------------------------------------
    -- Variables
    ---------------------------------------------------------

    DECLARE @StartTime DATETIME2 = SYSDATETIME();

    DECLARE @EndTime DATETIME2;

    DECLARE @RowsInserted INT = 0;

    DECLARE @RowsUpdated INT = 0;

    DECLARE @ErrorNumber INT;

    DECLARE @ErrorLine INT;

    DECLARE @ErrorMessage NVARCHAR(MAX);

    BEGIN TRY

        ---------------------------------------------------------
        -- Start Process
        ---------------------------------------------------------

        PRINT '=========================================================';
        PRINT 'LOADING FACTSALES';
        PRINT '=========================================================';

        BEGIN TRANSACTION;

        ---------------------------------------------------------
        -- Clean Fact Table
        ---------------------------------------------------------

        PRINT 'Truncating FactSales...';

        TRUNCATE TABLE dw.FactSales;

        PRINT 'FactSales truncated successfully.';

        ---------------------------------------------------------
        -- Load FactSales
        ---------------------------------------------------------

        PRINT 'Loading FactSales...';

        INSERT INTO dw.FactSales
        (
            OrderID,
            DateKey,
            CustomerKey,
            ProductKey,
            SellerKey,
            Quantity,
            Price,
            FreightValue,
            OrderStatus
        )

        SELECT

            oi.order_id,

            dd.DateKey,

            dc.CustomerKey,

            dp.ProductKey,

            ds.SellerKey,

            CAST(1 AS SMALLINT),

            oi.price,

            oi.freight_value,

            UPPER(LTRIM(RTRIM(o.order_status)))

        FROM stg.stg_order_items oi

        INNER JOIN stg.stg_orders o
            ON oi.order_id = o.order_id

        INNER JOIN dw.DimCustomer dc
            ON o.customer_id = dc.CustomerID

        INNER JOIN dw.DimProduct dp
            ON oi.product_id = dp.ProductID

        INNER JOIN dw.DimSeller ds
            ON oi.seller_id = ds.SellerID

        INNER JOIN dw.DimDate dd
            ON dd.FullDate = CAST(o.order_purchase_timestamp AS DATE);

                    ---------------------------------------------------------
        -- Statistics
        ---------------------------------------------------------

        SET @RowsInserted = @@ROWCOUNT;

        PRINT '';

        PRINT 'Rows Inserted : ' + CAST(@RowsInserted AS VARCHAR(20));

        ---------------------------------------------------------
        -- Commit Transaction
        ---------------------------------------------------------

        COMMIT TRANSACTION;

        SET @EndTime = SYSDATETIME();

        ---------------------------------------------------------
        -- Register Execution
        ---------------------------------------------------------

        EXEC etl.usp_LogExecution

            @BatchID = @BatchID,

            @ProcessName = 'etl.usp_Load_FactSales',

            @StartTime = @StartTime,

            @EndTime = @EndTime,

            @RowsInserted = @RowsInserted,

            @RowsUpdated = @RowsUpdated,

            @Status = 'SUCCESS',

            @ErrorMessage = NULL;

        ---------------------------------------------------------
        -- Summary
        ---------------------------------------------------------

        PRINT '';
        PRINT '=========================================================';
        PRINT 'FACTSALES LOADED SUCCESSFULLY';
        PRINT '=========================================================';
        PRINT 'Rows Inserted : ' + CAST(@RowsInserted AS VARCHAR(20));
        PRINT '=========================================================';

            END TRY

    BEGIN CATCH

        ---------------------------------------------------------
        -- Rollback Transaction
        ---------------------------------------------------------

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        ---------------------------------------------------------
        -- Error Information
        ---------------------------------------------------------

        SET @EndTime = SYSDATETIME();

        SET @ErrorNumber = ERROR_NUMBER();

        SET @ErrorLine = ERROR_LINE();

        SET @ErrorMessage = ERROR_MESSAGE();

        ---------------------------------------------------------
        -- Register Execution
        ---------------------------------------------------------

        EXEC etl.usp_LogExecution

            @BatchID = @BatchID,

            @ProcessName = 'etl.usp_Load_FactSales',

            @StartTime = @StartTime,

            @EndTime = @EndTime,

            @RowsInserted = 0,

            @RowsUpdated = 0,

            @Status = 'FAILED',

            @ErrorMessage = @ErrorMessage;

        ---------------------------------------------------------
        -- Print Error
        ---------------------------------------------------------

        PRINT '';

        PRINT '=========================================================';

        PRINT 'ERROR LOADING FACTSALES';

        PRINT '=========================================================';

        PRINT 'Error Number : ' + CAST(@ErrorNumber AS VARCHAR(10));

        PRINT 'Error Line   : ' + CAST(@ErrorLine AS VARCHAR(10));

        PRINT 'Message      : ' + @ErrorMessage;

        PRINT '=========================================================';

                ---------------------------------------------------------
        -- Re-throw Error
        ---------------------------------------------------------

        THROW;

    END CATCH

END;
GO

