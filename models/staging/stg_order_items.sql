select
  cast(order_item_id as string) as order_item_id,
  cast(order_id as string) as order_id,
  cast(product_id as string) as product_id,
  cast(quantity as integer) as quantity
from {{ ref('order_items') }}
