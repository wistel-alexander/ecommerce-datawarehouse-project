SELECT
*
FROM
(
SELECT

    ---------------------------------------------------------
    -- Degenerate Dimension
    ---------------------------------------------------------
    oi.order_id                                    AS OrderID,

    ---------------------------------------------------------
    -- Dimension Keys
    ---------------------------------------------------------
    dd.DateKey,

    dc.CustomerKey,

    dp.ProductKey,

    ds.SellerKey,

    ---------------------------------------------------------
    -- Measures
    ---------------------------------------------------------
    CAST(1 AS SMALLINT)                            AS Quantity,

    oi.price                                       AS Price,

    oi.freight_value                               AS FreightValue,

    ---------------------------------------------------------
    -- Order Attributes
    ---------------------------------------------------------
    UPPER(LTRIM(RTRIM(o.order_status)))            AS OrderStatus

FROM stg.stg_order_items oi

INNER JOIN stg.stg_orders o

    ON oi.order_id = o.order_id

INNER JOIN dw.DimCustomer dc

    ON o.customer_id = dc.CustomerID

INNER JOIN dw.DimProduct dp

    ON oi.product_id = dp.ProductID

INNER JOIN dw.DimSeller ds

    ON oi.seller_id = ds.SellerID

INNER JOIN dw.DimDate dd

    ON dd.FullDate = CAST(o.order_purchase_timestamp AS DATE)
) x
WHERE

DateKey IS NULL

OR CustomerKey IS NULL

OR ProductKey IS NULL

OR SellerKey IS NULL;
