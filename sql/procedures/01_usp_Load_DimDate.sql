/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 01_usp_Load_DimDate.sql
Author  : Wistel Alexander
Purpose : Populate Date Dimension
===========================================================
*/

CREATE OR ALTER PROCEDURE etl.usp_Load_DimDate

    @BatchID UNIQUEIDENTIFIER

AS
BEGIN

    SET NOCOUNT ON;

    ---------------------------------------------------------
    -- Variables
    ---------------------------------------------------------
    DECLARE @StartDate DATE = '2015-01-01';
    DECLARE @EndDate DATE = '2030-12-31';
    DECLARE @CurrentDate DATE = @StartDate;

    DECLARE @RowsInserted INT = 0;

    ----------------------------------------------------
    -- Check Existing Data
    ----------------------------------------------------

        IF EXISTS
    (
        SELECT 1
        FROM dw.DimDate
    )
    BEGIN

        PRINT '=========================================================';
        PRINT 'LOADING DIMDATE';
        PRINT '=========================================================';
        PRINT 'DimDate already populated.';
        PRINT 'Skipping load.';
        PRINT '=========================================================';

        RETURN;

    END;

    BEGIN TRY

        PRINT '=========================================================';
        PRINT 'LOADING DIMDATE';
        PRINT '=========================================================';

        BEGIN TRANSACTION;

        ---------------------------------------------------------
        -- Generate Calendar
        ---------------------------------------------------------
        PRINT 'Generating calendar...';

        WHILE @CurrentDate <= @EndDate
        BEGIN

            INSERT INTO dw.DimDate
            (
                DateKey,
                FullDate,
                Day,
                Month,
                MonthName,
                Quarter,
                Year,
                WeekDay,
                WeekDayName,
                IsWeekend
            )

            VALUES
            (
                CONVERT(INT, CONVERT(CHAR(8), @CurrentDate, 112)),
                @CurrentDate,
                DAY(@CurrentDate),
                MONTH(@CurrentDate),

                CASE MONTH(@CurrentDate)
                    WHEN 1 THEN 'January'
                    WHEN 2 THEN 'February'
                    WHEN 3 THEN 'March'
                    WHEN 4 THEN 'April'
                    WHEN 5 THEN 'May'
                    WHEN 6 THEN 'June'
                    WHEN 7 THEN 'July'
                    WHEN 8 THEN 'August'
                    WHEN 9 THEN 'September'
                    WHEN 10 THEN 'October'
                    WHEN 11 THEN 'November'
                    WHEN 12 THEN 'December'
                END,

                DATEPART(QUARTER, @CurrentDate),

                YEAR(@CurrentDate),

                DATEPART(WEEKDAY, @CurrentDate),

                CASE DATEPART(WEEKDAY, @CurrentDate)
                    WHEN 1 THEN 'Sunday'
                    WHEN 2 THEN 'Monday'
                    WHEN 3 THEN 'Tuesday'
                    WHEN 4 THEN 'Wednesday'
                    WHEN 5 THEN 'Thursday'
                    WHEN 6 THEN 'Friday'
                    WHEN 7 THEN 'Saturday'
                END,

                CASE
                    WHEN DATEPART(WEEKDAY, @CurrentDate) IN (1,7)
                    THEN 1
                    ELSE 0
                END
            );

            SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);

        END;

        ---------------------------------------------------------
        -- Statistics
        ---------------------------------------------------------
        SELECT @RowsInserted = COUNT(*)
        FROM dw.DimDate;

        COMMIT TRANSACTION;

        ---------------------------------------------------------
        -- Summary
        ---------------------------------------------------------
        PRINT '';
        PRINT '=========================================================';
        PRINT 'DIMDATE LOADED SUCCESSFULLY';
        PRINT '=========================================================';
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
        PRINT 'ERROR LOADING DIMDATE';
        PRINT '=========================================================';
        PRINT 'Error Number : ' + CAST(@ErrorNumber AS VARCHAR(10));
        PRINT 'Error Line   : ' + CAST(@ErrorLine AS VARCHAR(10));
        PRINT 'Message      : ' + @ErrorMessage;
        PRINT '=========================================================';

        THROW;

    END CATCH

END;
GO

