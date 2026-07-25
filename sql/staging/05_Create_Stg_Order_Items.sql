/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 05_Create_Stg_Order_Items.sql
Purpose : Create Order Items Staging Table
===========================================================
*/

IF OBJECT_ID('stg.stg_order_items', 'U') IS NOT NULL
    DROP TABLE stg.stg_order_items;
GO

CREATE TABLE stg.stg_order_items
(
    order_id                VARCHAR(32)     NOT NULL,

    order_item_id           INT             NOT NULL,

    product_id              VARCHAR(32)     NOT NULL,

    seller_id               VARCHAR(32)     NOT NULL,

    shipping_limit_date     DATETIME2       NOT NULL,

    price                   DECIMAL(10,2)  NOT NULL,

    freight_value           DECIMAL(10,2)  NOT NULL
);
GO