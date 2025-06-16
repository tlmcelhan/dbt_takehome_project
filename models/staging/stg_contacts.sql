select
  cast(contact_id as string) as contact_id,
  lower(first_name) as first_name,
  lower(last_name) as last_name,
  lower(email) as email
from {{ ref('contacts') }}
