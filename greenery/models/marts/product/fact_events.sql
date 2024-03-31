{{
  config(
    materialized='table'
  )
}}

select created_at, user_id, product_id, name AS product_name, price, inventory, event_type, COUNT(DISTINCT event_id) AS events 
from {{ source('postgres', 'events') }}
left join {{ source('postgres', 'products') }}
using(product_id)
where product_name IS NOT NULL
group by 1,2,3,4,5,6,7