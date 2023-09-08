-- Returns all products that have a description
select product_id, product_name, discontinued, 
	   case when discontinued = 0 then 'No' 
			when discontinued = 1 then 'Yes' 
			else 'unknown'
	   end as discontinued_description
from oes.products


-- 
select product_id, product_name, list_price,
	   case when list_price < 50 then 'Low'
			when list_price >= 50 and list_price < 250 then 'Medium'
			when list_price >= 250 then 'High'
			else 'Unknown'
	   end as price_grade
from oes.products


-- 
select order_id, order_date, shipped_date,
	   case when datediff(day, order_date, shipped_date) <= 7 then 'Shipped within one week'
			when datediff(day, order_date, shipped_date) > 7 then 'Shipped over a week later'
			else 'Not yet shipped'
	   end as shipping_status
from oes.orders


-- 
with orderscte as
(
	select order_id, order_date, shipped_date,
		   case when datediff(day, order_date, shipped_date) <= 7 then 'Shipped within one week'
				when datediff(day, order_date, shipped_date) > 7 then 'Shipped over a week later'
				else 'Not yet shipped'
		   end as shipping_status
	from oes.orders
)
select shipping_status, count(*) as number_of_orders 
from orderscte
group by shipping_status
order by number_of_orders