-- Returns the following attributes for employees who belong to a department
select emp.employee_id, emp.first_name, emp.last_name, emp.salary, dep.department_name
from hcm.employees emp 
join hcm.departments dep
on emp.department_id = dep.department_id


-- Returns the following attributes for all employees, including employees that do not belong to a department
select emp.employee_id, emp.first_name, emp.last_name, emp.salary, dep.department_name
from hcm.employees emp 
left join hcm.departments dep
on emp.department_id = dep.department_id


-- Returns the total number of employees in each department
select dep.department_name, count(emp.employee_id) as total_employees
from hcm.employees emp 
left join hcm.departments dep
on emp.department_id = dep.department_id
group by dep.department_name