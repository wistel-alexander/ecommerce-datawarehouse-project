/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 02_Create_Stg_Products.sql
Purpose : Create Products Staging Table
===========================================================
*/

IF OBJECT_ID('stg.stg_products', 'U') IS NOT NULL
    DROP TABLE stg.stg_products;
GO

CREATE TABLE stg.stg_products
(
    product_id                    VARCHAR(32)    NOT NULL,

    product_category_name         VARCHAR(100)   NULL,

    product_name_lenght           INT            NULL,

    product_description_lenght    INT            NULL,

    product_photos_qty            INT            NULL,

    product_weight_g              DECIMAL(10,2)  NULL,

    product_length_cm             DECIMAL(10,2)  NULL,

    product_height_cm             DECIMAL(10,2)  NULL,

    product_width_cm              DECIMAL(10,2)  NULL
);
GO