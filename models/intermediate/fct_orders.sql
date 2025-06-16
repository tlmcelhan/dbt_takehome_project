with orders as (
  select *
  from {{ ref('stg_orders') }}
),
order_items as (
  select *
  from {{ ref('stg_order_items') }} oi
  join {{ ref('stg_products') }} p
    on oi.product_id = p.product_id
),
order_metrics as (
  select
    oi.order_id,
    sum(oi.quantity) as total_quantity,
    sum(p.list_price * oi.quantity) as list_amount
  from order_items oi
  join {{ ref('stg_products') }} p
    on oi.product_id = p.product_id
  group by oi.order_id
),
final as (
  select
    o.order_id,
    o.contact_id,
    o.order_date,
    o.order_status,
    o.total_amount,
    om.total_quantity,
    om.list_amount,
    case
      when o.total_amount < om.list_amount then true
      else false
    end as is_discount_applied
  from orders o
  left join order_metrics om
    on o.order_id = om.order_id
)
select * from final
