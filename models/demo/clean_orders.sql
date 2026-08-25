{{
    config 
    (
        materialized = 'ephemeral'
    )
}}

with base_orders as
(
    select 
    ORDER_ID,
    ORDER_DATE,
    CUSTOMER_ID,
    case when CUSTOMER_NAME is null then 'NA' else upper(CUSTOMER_NAME) end as CUSTOMER_NAME,
    CREATED_AT,
    from {{source('orders','BASE_ORDERS')}}
    where ORDER_DATE IS NOT NULL
)

select * from base_orders