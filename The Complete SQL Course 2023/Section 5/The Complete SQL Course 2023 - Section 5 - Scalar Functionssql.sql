-- Combining the first name and the last namee for each employee
select employee_id, first_name, last_name, concat(first_name, ' ', last_name) as employee_name 
from hcm.employees


-- Combining the first name, middle name (if the employee has a middle name), and the last namee for each employee
select employee_id, first_name, last_name, concat(first_name, ' ' + middle_name, ' ', last_name) as employee_name 
from hcm.employees


-- Extracting the genus name from the "scientific_name" column ==> "Pygoscelis": Genus Name - "adeliae": Species Name
select substring(scientific_name, 1, charindex(' ', scientific_name) -1) as genus_name
from bird.antarctic_species

select * from bird.antarctic_species


-- Extracting the species name from the "scientific_name" column ==> "Pygoscelis": Genus Name - "adeliae": Species Name
select substring(scientific_name, charindex(' ', scientific_name), len(scientific_name)) as species_name
from bird.antarctic_species

select * from bird.antarctic_species


-- Returns the employee's age
select employee_id, first_name, last_name, birth_date, datediff(year, birth_date, getdate()) as employee_age
from hcm.employees


-- Returns the estimated shipping days
select order_id, order_date, dateadd(day, 7, order_date) as estimated_shipping_date
from oes.orders
where shipped_date is null


-- Calculate the average number of days it takes each shipping company to ship an order
select company_name, avg(datediff(day, order_date, shipped_date)) as avg_shipping_days
from oes.shippers s
join oes.orders o
on s.shipper_id = o.shipper_id
group by company_name