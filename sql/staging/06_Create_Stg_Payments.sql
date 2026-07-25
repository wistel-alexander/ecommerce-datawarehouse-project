/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 06_Create_Stg_Payments.sql
Purpose : Create Payments Staging Table
===========================================================
*/

IF OBJECT_ID('stg.stg_payments', 'U') IS NOT NULL
    DROP TABLE stg.stg_payments;
GO

CREATE TABLE stg.stg_payments
(
    order_id                VARCHAR(32)     NOT NULL,

    payment_sequential      INT             NOT NULL,

    payment_type            VARCHAR(30)     NOT NULL,

    payment_installments    INT             NOT NULL,

    payment_value           DECIMAL(10,2)   NOT NULL
);
GO