/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 01_Load_DimDate.sql
Author  : Wistel Alexander
Purpose : Populate the DimDate dimension
===========================================================
*/

USE EcommerceDW;
GO

------------------------------------------------------------
-- Drop Procedure
------------------------------------------------------------

IF OBJECT_ID('etl.Load_DimDate', 'P') IS NOT NULL
    DROP PROCEDURE etl.Load_DimDate;
GO

------------------------------------------------------------
-- Create Procedure
------------------------------------------------------------

CREATE PROCEDURE etl.Load_DimDate

AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        DECLARE @StartDate DATE = '2015-01-01';
        DECLARE @EndDate DATE = '2030-12-31';

        DECLARE @CurrentDate DATE = @StartDate;

        DECLARE @RowsInserted INT;

        ----------------------------------------------------
        -- Clean Dimension
        ----------------------------------------------------

        TRUNCATE TABLE dw.DimDate;

        ----------------------------------------------------
        -- Generate Calendar
        ----------------------------------------------------

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

                DATEPART(QUARTER,@CurrentDate),

                YEAR(@CurrentDate),

                DATEPART(WEEKDAY,@CurrentDate),

                CASE DATEPART(WEEKDAY,@CurrentDate)
                    WHEN 1 THEN 'Sunday'
                    WHEN 2 THEN 'Monday'
                    WHEN 3 THEN 'Tuesday'
                    WHEN 4 THEN 'Wednesday'
                    WHEN 5 THEN 'Thursday'
                    WHEN 6 THEN 'Friday'
                    WHEN 7 THEN 'Saturday'
                END,

                CASE
                    WHEN DATEPART(WEEKDAY,@CurrentDate) IN (1,7)
                    THEN 1
                    ELSE 0
                END

            );

            SET @CurrentDate = DATEADD(DAY,1,@CurrentDate);

        END;

        ----------------------------------------------------
        -- Statistics
        ----------------------------------------------------

        SELECT @RowsInserted = COUNT(*)
        FROM dw.DimDate;

        PRINT '--------------------------------------------';
        PRINT 'DimDate loaded successfully.';
        PRINT 'Rows inserted: ' + CAST(@RowsInserted AS VARCHAR(20));
        PRINT '--------------------------------------------';

    END TRY

    BEGIN CATCH

        PRINT 'Error loading DimDate';

        PRINT ERROR_MESSAGE();

    END CATCH

END;
GO

