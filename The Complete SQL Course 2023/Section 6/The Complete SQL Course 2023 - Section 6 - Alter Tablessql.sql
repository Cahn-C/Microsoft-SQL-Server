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