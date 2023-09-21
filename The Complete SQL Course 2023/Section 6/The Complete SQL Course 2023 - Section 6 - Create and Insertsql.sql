-- Create a table called dept in the dbo schema
CREATE TABLE dbo.dept (
	dept_id INT IDENTITY(1,1),
	dept_name VARCHAR(50) NOT NULL,
	CONSTRAINT pk_dept_id PRIMARY KEY (dept_id)
);

-- Insert department name "Business Intelligence"
INSERT INTO dbo.dept VALUES ('Business Intelligence')

-- Insert all department names into the dept table
INSERT INTO dbo.dept SELECT department_name FROM hcm.departments

-- Check the records
select * from dbo.dept


-- Create a table called emp in the dbo schema
CREATE TABLE emp (
	emp_id INT IDENTITY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	hire_date DATE NOT NULL,
	dept_id INT,
	CONSTRAINT pk_emp_id PRIMARY KEY (emp_id),
	CONSTRAINT fk_dept_id FOREIGN KEY (dept_id) REFERENCES dept (dept_id)
);


-- Populate the emp table with two employees
INSERT INTO dbo.emp VALUES ('Scott', 'Davis', '20201211', 1)
INSERT INTO dbo.emp VALUES ('Miriam', 'Yardley', '20201205', 1)

-- Check the following records
select * from dbo.emp

sp_help 'dbo.dept'
sp_help 'dbo.emp'