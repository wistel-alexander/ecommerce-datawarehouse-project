/*
===========================================================
Project : Ecommerce Data Warehouse
File    : 07_Create_Stg_Reviews.sql
Purpose : Create Reviews Staging Table
===========================================================
*/

IF OBJECT_ID('stg.stg_reviews', 'U') IS NOT NULL
    DROP TABLE stg.stg_reviews;
GO

CREATE TABLE stg.stg_reviews
(
    review_id                   VARCHAR(32)     NOT NULL,

    order_id                    VARCHAR(32)     NOT NULL,

    review_score                INT             NOT NULL,

    review_comment_title        VARCHAR(255)    NULL,

    review_comment_message      VARCHAR(MAX)    NULL,

    review_creation_date        DATETIME2       NULL,

    review_answer_timestamp     DATETIME2       NULL
);
GO