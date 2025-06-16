select
  cast(order_id as string) as order_id,
  cast(contact_id as string) as contact_id,
  cast(order_date as timestamp) as order_date,
  lower(status) as order_status,
  cast(total_amount as numeric) as total_amount
from {{ ref('orders') }}
