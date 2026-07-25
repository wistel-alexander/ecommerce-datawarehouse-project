/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 02_Load_DimCustomer.sql
Purpose : Load Customer Dimension (SCD Type 1)
===========================================================
*/

CREATE OR ALTER PROCEDURE dw.usp_Load_DimCustomer
AS
BEGIN

    SET NOCOUNT ON;

    ---------------------------------------------------------
    -- Variables
    ---------------------------------------------------------
    DECLARE @RowsInserted INT = 0;
    DECLARE @RowsUpdated INT = 0;

    BEGIN TRY

        ---------------------------------------------------------
        -- Start Process
        ---------------------------------------------------------
        PRINT '=========================================================';
        PRINT 'LOADING DIMCUSTOMER';
        PRINT '=========================================================';

        BEGIN TRANSACTION;

        ---------------------------------------------------------
        -- Update Existing Customers (SCD Type 1)
        ---------------------------------------------------------
        PRINT 'Updating existing customers...';

        UPDATE d
        SET
            CustomerUniqueID = s.customer_unique_id,
            ZipCodePrefix    = s.customer_zip_code_prefix,
            City             = UPPER(LTRIM(RTRIM(s.customer_city))),
            State            = UPPER(LTRIM(RTRIM(s.customer_state))),
            ModifiedDate     = SYSDATETIME()

        FROM dw.DimCustomer d
        INNER JOIN stg.stg_customers s
            ON d.CustomerID = s.customer_id

        WHERE

               d.CustomerUniqueID <> s.customer_unique_id
            OR d.ZipCodePrefix    <> s.customer_zip_code_prefix
            OR d.City             <> UPPER(LTRIM(RTRIM(s.customer_city)))
            OR d.State            <> UPPER(LTRIM(RTRIM(s.customer_state)));

        SET @RowsUpdated = @@ROWCOUNT;

        ---------------------------------------------------------
        -- Insert New Customers
        ---------------------------------------------------------
        PRINT 'Inserting new customers...';

        INSERT INTO dw.DimCustomer
        (
            CustomerID,
            CustomerUniqueID,
            ZipCodePrefix,
            City,
            State
        )

        SELECT

            s.customer_id,
            s.customer_unique_id,
            s.customer_zip_code_prefix,
            UPPER(LTRIM(RTRIM(s.customer_city))),
            UPPER(LTRIM(RTRIM(s.customer_state)))

        FROM stg.stg_customers s

        WHERE NOT EXISTS
        (
            SELECT 1
            FROM dw.DimCustomer d
            WHERE d.CustomerID = s.customer_id
        );

        SET @RowsInserted = @@ROWCOUNT;

        ---------------------------------------------------------
        -- Commit
        ---------------------------------------------------------
        COMMIT TRANSACTION;

        ---------------------------------------------------------
        -- Summary
        ---------------------------------------------------------
        PRINT '';
        PRINT '=========================================================';
        PRINT 'DIMCUSTOMER LOADED SUCCESSFULLY';
        PRINT '=========================================================';
        PRINT 'Rows Updated : ' + CAST(@RowsUpdated AS VARCHAR(20));
        PRINT 'Rows Inserted: ' + CAST(@RowsInserted AS VARCHAR(20));
        PRINT '=========================================================';

    END TRY

    BEGIN CATCH

        ---------------------------------------------------------
        -- Rollback
        ---------------------------------------------------------
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        ---------------------------------------------------------
        -- Error Information
        ---------------------------------------------------------
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorNumber INT;
        DECLARE @ErrorLine INT;

        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorNumber  = ERROR_NUMBER();
        SET @ErrorLine    = ERROR_LINE();

        PRINT '';
        PRINT '=========================================================';
        PRINT 'ERROR LOADING DIMCUSTOMER';
        PRINT '=========================================================';
        PRINT 'Error Number : ' + CAST(@ErrorNumber AS VARCHAR(10));
        PRINT 'Error Line   : ' + CAST(@ErrorLine AS VARCHAR(10));
        PRINT 'Message      : ' + @ErrorMessage;
        PRINT '=========================================================';

        THROW;

    END CATCH

END;
GO

