with contacts as (
  select *
  from {{ ref('stg_contacts') }}
),
orders as (
  select *
  from {{ ref('fct_orders') }}
  where order_status = 'completed'
),
agg as (
  select
    contact_id,
    count(*) as total_completed_orders,
    sum(total_amount) as total_spend,
    avg(total_amount) as avg_order_value,
    min(order_date) as customer_since_date
  from orders
  group by contact_id
),
final as (
  select
    c.contact_id,
    c.first_name,
    c.last_name,
    coalesce(a.total_completed_orders, 0) as total_completed_orders,
    coalesce(a.total_spend, 0) as total_spend,
    coalesce(a.avg_order_value, 0) as avg_order_value,
    case when a.total_completed_orders >= 1 then true else false end as is_customer,
    case when a.total_completed_orders > 1 then true else false end as is_repeat_customer,
    a.customer_since_date
  from contacts c
  left join agg a on c.contact_id = a.contact_id
)

select * from final
