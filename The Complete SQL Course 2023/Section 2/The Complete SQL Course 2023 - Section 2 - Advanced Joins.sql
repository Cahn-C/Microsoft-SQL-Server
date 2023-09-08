-- Returns eloyee details for all eloyees as well as the first and last name of each eloyee's mager
select e.employee_id, e.first_name, e.last_name, m.first_name as mager_first_name, m.last_name as mager_last_name 
from hcm.employees e
left join hcm.employees m
on e.manager_id = m.employee_id


-- Returns all products for each warehouse
select p.product_id, p.product_name, w.warehouse_id, i.quantity_on_hand
from oes.products p
left join oes.inventories i
on p.product_id = i.product_id
left join oes.warehouses w
on i.warehouse_id = w.warehouse_id


-- Returns all eloyees from Austrila
select e.employee_id, e.first_name, e.last_name, d.department_name, j.job_title, e.state_province, c.country_name
from hcm.employees e
left join hcm.departments d
on e.department_id = d.department_id
left join hcm.jobs j
on e.job_id = j.job_id
left join hcm.countries c
on e.country_id = c.country_id
where c.country_name = 'australia'


-- Returns the total quantity ordered of each product in each category
select p.product_name, pc.category_name, sum(i.quantity_on_hand) as total_quantity
from oes.products p
join oes.product_categories pc
on p.category_id = pc.category_id
join oes.inventories i
on i.product_id = p.product_id
group by p.product_name, pc.category_name
order by pc.category_name asc, p.product_name asc


-- Returns the total quantity ordered of all products in each category
select p.product_name, pc.category_name, isnull(sum(i.quantity_on_hand), 0) as total_quantity
from oes.products p
left join oes.product_categories pc
on p.category_id = pc.category_id
left join oes.inventories i
on i.product_id = p.product_id
group by p.product_name, pc.category_name
order by pc.category_name asc, p.product_name asc