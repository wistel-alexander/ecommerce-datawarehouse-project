/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 03_usp_Load_DimProduct.sql
Purpose : Load Product Dimension (SCD Type 1)
===========================================================
*/

CREATE OR ALTER PROCEDURE etl.usp_Load_DimProduct

    @BatchID UNIQUEIDENTIFIER

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
        PRINT 'LOADING DIMPRODUCT';
        PRINT '=========================================================';

        BEGIN TRANSACTION;

        ---------------------------------------------------------
        -- Update Existing Products (SCD Type 1)
        ---------------------------------------------------------
        PRINT 'Updating existing products...';

        UPDATE d
        SET
            CategoryName = s.product_category_name,
            WeightGrams  = s.product_weight_g,
            LengthCm     = s.product_length_cm,
            HeightCm     = s.product_height_cm,
            WidthCm      = s.product_width_cm,
            ModifiedDate = SYSDATETIME()

        FROM dw.DimProduct d
        INNER JOIN stg.stg_products s
            ON d.ProductID = s.product_id

        WHERE

               ISNULL(d.CategoryName,'') <> ISNULL(s.product_category_name,'')
            OR ISNULL(d.WeightGrams,-1)  <> ISNULL(s.product_weight_g,-1)
            OR ISNULL(d.LengthCm,-1)     <> ISNULL(s.product_length_cm,-1)
            OR ISNULL(d.HeightCm,-1)     <> ISNULL(s.product_height_cm,-1)
            OR ISNULL(d.WidthCm,-1)      <> ISNULL(s.product_width_cm,-1);

        SET @RowsUpdated = @@ROWCOUNT;

        ---------------------------------------------------------
        -- Insert New Products
        ---------------------------------------------------------
        PRINT 'Inserting new products...';

        INSERT INTO dw.DimProduct
        (
            ProductID,
            CategoryName,
            WeightGrams,
            LengthCm,
            HeightCm,
            WidthCm
        )

        SELECT

            s.product_id,
            s.product_category_name,
            s.product_weight_g,
            s.product_length_cm,
            s.product_height_cm,
            s.product_width_cm

        FROM stg.stg_products s

        WHERE NOT EXISTS
        (
            SELECT 1
            FROM dw.DimProduct d
            WHERE d.ProductID = s.product_id
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
        PRINT 'DIMPRODUCT LOADED SUCCESSFULLY';
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
        PRINT 'ERROR LOADING DIMPRODUCT';
        PRINT '=========================================================';
        PRINT 'Error Number : ' + CAST(@ErrorNumber AS VARCHAR(10));
        PRINT 'Error Line   : ' + CAST(@ErrorLine AS VARCHAR(10));
        PRINT 'Message      : ' + @ErrorMessage;
        PRINT '=========================================================';

        THROW;

    END CATCH

END;
GO
