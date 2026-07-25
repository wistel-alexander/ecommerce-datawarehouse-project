/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 04_Create_Stg_Orders.sql
Purpose : Create Orders Staging Table
===========================================================
*/

IF OBJECT_ID('stg.stg_orders', 'U') IS NOT NULL
    DROP TABLE stg.stg_orders;
GO

CREATE TABLE stg.stg_orders
(
    order_id                         VARCHAR(32) NOT NULL,

    customer_id                      VARCHAR(32) NOT NULL,

    order_status                     VARCHAR(20) NOT NULL,

    order_purchase_timestamp         DATETIME2 NULL,

    order_approved_at                DATETIME2 NULL,

    order_delivered_carrier_date     DATETIME2 NULL,

    order_delivered_customer_date    DATETIME2 NULL,

    order_estimated_delivery_date    DATETIME2 NULL
);
GO