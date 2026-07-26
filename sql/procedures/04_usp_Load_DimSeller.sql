/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 04_usp_Load_DimSeller.sql
Purpose : Load Seller Dimension (SCD Type 1)
===========================================================
*/

CREATE OR ALTER PROCEDURE etl.usp_Load_DimSeller
AS
BEGIN

    SET NOCOUNT ON;

    ---------------------------------------------------------
    -- Variables
    ---------------------------------------------------------
    DECLARE @RowsInserted INT = 0;
    DECLARE @RowsUpdated INT = 0;

    BEGIN TRY

        PRINT '=========================================================';
        PRINT 'LOADING DIMSELLER';
        PRINT '=========================================================';

        BEGIN TRANSACTION;

        ---------------------------------------------------------
        -- Update Existing Sellers (SCD Type 1)
        ---------------------------------------------------------
        PRINT 'Updating existing sellers...';

        UPDATE d
        SET
            ZipCodePrefix = s.seller_zip_code_prefix,
            City          = UPPER(LTRIM(RTRIM(s.seller_city))),
            State         = UPPER(LTRIM(RTRIM(s.seller_state))),
            ModifiedDate  = SYSDATETIME()

        FROM dw.DimSeller d
        INNER JOIN stg.stg_sellers s
            ON d.SellerID = s.seller_id

        WHERE

               ISNULL(d.ZipCodePrefix,-1) <> ISNULL(s.seller_zip_code_prefix,-1)
            OR ISNULL(d.City,'')          <> ISNULL(UPPER(LTRIM(RTRIM(s.seller_city))),'')
            OR ISNULL(d.State,'')         <> ISNULL(UPPER(LTRIM(RTRIM(s.seller_state))),'');

        SET @RowsUpdated = @@ROWCOUNT;

        ---------------------------------------------------------
        -- Insert New Sellers
        ---------------------------------------------------------
        PRINT 'Inserting new sellers...';

        INSERT INTO dw.DimSeller
        (
            SellerID,
            ZipCodePrefix,
            City,
            State
        )

        SELECT

            s.seller_id,
            s.seller_zip_code_prefix,
            UPPER(LTRIM(RTRIM(s.seller_city))),
            UPPER(LTRIM(RTRIM(s.seller_state)))

        FROM stg.stg_sellers s

        WHERE NOT EXISTS
        (
            SELECT 1
            FROM dw.DimSeller d
            WHERE d.SellerID = s.seller_id
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
        PRINT 'DIMSELLER LOADED SUCCESSFULLY';
        PRINT '=========================================================';
        PRINT 'Rows Updated : ' + CAST(@RowsUpdated AS VARCHAR(20));
        PRINT 'Rows Inserted: ' + CAST(@RowsInserted AS VARCHAR(20));
        PRINT '=========================================================';

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorNumber INT;
        DECLARE @ErrorLine INT;

        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorNumber = ERROR_NUMBER();
        SET @ErrorLine = ERROR_LINE();

        PRINT '';
        PRINT '=========================================================';
        PRINT 'ERROR LOADING DIMSELLER';
        PRINT '=========================================================';
        PRINT 'Error Number : ' + CAST(@ErrorNumber AS VARCHAR(10));
        PRINT 'Error Line   : ' + CAST(@ErrorLine AS VARCHAR(10));
        PRINT 'Message      : ' + @ErrorMessage;
        PRINT '=========================================================';

        THROW;

    END CATCH

END;
GO
