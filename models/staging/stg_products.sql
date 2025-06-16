select
  cast(product_id as string) as product_id,
  lower(product_name) as product_name,
  lower(category) as product_category,
  cast(list_price as numeric) as list_price
from {{ ref('products') }}
