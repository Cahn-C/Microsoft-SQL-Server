-- Returns the cheapest products
select product_id, product_name, list_price, category_id 
from oes.products
where list_price = (select min(list_price) as cheapest_product from oes.products)


-- Returns the cheapest products in each category
select product_id, product_name, list_price, category_id 
from oes.products p1
where list_price = (select min(list_price) as cheapest_product 
				    from oes.products p2
					where p1.category_id = p2.category_id)


-- Returns the cheapest products in each category using an inner join to a derived table 
select p1.product_id, p1.product_name, p1.list_price, p2.category_id 
from oes.products p1
join (select category_id, min(list_price) as cheapest_product 
	  from oes.products
	  group by category_id) p2
on p1.category_id = p2.category_id
and p1.list_price = p2.cheapest_product


-- Returns the cheapest products in each category using a CTE (Common Table Expression)
with cheap_products as
(
	select category_id, min(list_price) as cheapest_product
	from oes.products
	group by category_id
)
select p.product_id, p.product_name, p.list_price, cp.category_id 
from cheap_products cp
join oes.products p
on cp.category_id = p.category_id
and cp.cheapest_product = p.list_price


-- Returns the cheapest products in each category along with the caetgory name using a CTE (Common Table Expression)
with cheap_products as
(
	select category_id, min(list_price) as cheapest_product
	from oes.products
	group by category_id
)
select p.product_id, p.product_name, pc.category_name, p.list_price, cp.category_id 
from cheap_products cp
join oes.products p
on cp.category_id = p.category_id
join oes.product_categories pc
on pc.category_id = cp.category_id
and cp.cheapest_product = p.list_price


-- Returns all employees who have never been the salesperson for any customer order with NOT IN
select employee_id, first_name, last_name from hcm.employees 
where employee_id not in (select employee_id from oes.orders
						  where employee_id is not null)


-- Returns all employees who have never been the salesperson for any customer order with NOT EXISTS
select employee_id, first_name, last_name 
from hcm.employees e
where not exists (select employee_id from oes.orders o
				  where e.employee_id = o.employee_id)


-- Returns unique customer who have ordered the PBX Smart Watch 4
select customer_id, first_name, last_name, email 
from oes.customers c
where customer_id in (select customer_id from oes.orders o
					  join oes.order_items oi
					  on o.order_id = oi.order_id
					  join oes.products p
					  on oi.product_id = p.product_id
					  where p.product_name = 'PBX Smart Watch 4')
order by first_name
