-- Get all records of the emplyees
select * from hcm.employees

-- Adding a new column into the emplyees table called termination_date
ALTER TABLE hcm.employees ADD termination_date DATE


-- Change the first and last name data types from VARCHAR(50) to VARCHAR(60)
ALTER TABLE oes.customers ALTER COLUMN first_name VARCHAR(60)
ALTER TABLE oes.customers ALTER COLUMN last_name VARCHAR(60)

-- Check the data type changes for the customers table
sp_help 'oes.customers'


-- Rename naming the column phone to main_phone in the customes table
sp_rename 'oes.customers.phone', 'main_phone', 'COLUMN'

-- Check the changes
select * from oes.customers

-- Or
sp_help 'oes.customers'


-- Make the department_name column a UNIQUE constraint to avoid duplicate departments
ALTER TABLE hcm.departments ADD CONSTRAINT uk_department_name UNIQUE (department_name)

-- Check the records
sp_help 'hcm.departments'


-- Ensure that the salary for the employees is greater than 0, meaning when new info gets sumbmitted they can not have a salary of 0
ALTER TABLE hcm.employees ADD CONSTRAINT ck_salary CHECK (salary >= 0)

-- Check the records
sp_help 'hcm.employees'

-- Check the constraints for a certain schema
select tc.CONSTRAINT_SCHEMA, tc.CONSTRAINT_NAME, tc.CONSTRAINT_TYPE, ccu.TABLE_SCHEMA, ccu.TABLE_NAME 
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
join INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
on tc.CONSTRAINT_SCHEMA = ccu.TABLE_SCHEMA
and tc.TABLE_CATALOG = ccu.TABLE_CATALOG
and tc.TABLE_NAME = ccu.TABLE_NAME
and tc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
where ccu.CONSTRAINT_SCHEMA = 'hcm'
and tc.CONSTRAINT_NAME like 'ck%'
