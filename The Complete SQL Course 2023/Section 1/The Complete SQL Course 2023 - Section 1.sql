-- Get all employees who live in wither Seattle or Sydney
select first_name, last_name, city 
from hcm.employees 
where city = 'Seattle'
or city = 'Sydney'


-- Get all employees who live in any of the following cities: Seattle, Sydney, Ascot, Hillston
select first_name, last_name, city
from hcm.employees 
where city in ('Seattle', 'Sydney', 'Ascot', 'Hillston')


-- Get all employees from Sydney who have a salry greater than $200,000
select first_name, last_name, city, salary
from hcm.employees
where city = 'Sydney' 
and salary > 200000


-- Get all employees who live in either Seattle or Sydney and were also hired on or after the 1st on January 2019
select first_name, last_name, city, hire_date 
from hcm.employees
where hire_date >= '2019-01-01'
and city in ('Seattle', 'Sydney')


-- Get the products that do not have a product category of either 1, 2 or 5
select product_name, category_id 
from oes.products
where category_id not in (1, 2, 5)