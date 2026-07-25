/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 03_Create_Stg_Sellers.sql
Purpose : Create Sellers Staging Table
===========================================================
*/

IF OBJECT_ID('stg.stg_sellers', 'U') IS NOT NULL
    DROP TABLE stg.stg_sellers;
GO

CREATE TABLE stg.stg_sellers
(
    seller_id               VARCHAR(32)   NOT NULL,

    seller_zip_code_prefix  INT           NOT NULL,

    seller_city             VARCHAR(100)  NOT NULL,

    seller_state            CHAR(2)       NOT NULL
);
GO