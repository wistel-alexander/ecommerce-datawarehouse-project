--==========================================================
-- Create Schemas
--==========================================================

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dw')
BEGIN
    EXEC('CREATE SCHEMA dw');
    PRINT 'Schema dw created successfully.';
END
ELSE
BEGIN
    PRINT 'Schema dw already exists.';
END;
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'stg')
BEGIN
    EXEC('CREATE SCHEMA stg');
    PRINT 'Schema stg created successfully.';
END
ELSE
BEGIN
    PRINT 'Schema stg already exists.';
END;
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'audit')
BEGIN
    EXEC('CREATE SCHEMA audit');
    PRINT 'Schema audit created successfully.';
END
ELSE
BEGIN
    PRINT 'Schema audit already exists.';
END;
GO
--==========================================================
-- Create ETL Schema
--==========================================================

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'etl')
BEGIN
    EXEC('CREATE SCHEMA etl');
    PRINT 'Schema etl created successfully.';
END
ELSE
BEGIN
    PRINT 'Schema etl already exists.';
END;
GO
