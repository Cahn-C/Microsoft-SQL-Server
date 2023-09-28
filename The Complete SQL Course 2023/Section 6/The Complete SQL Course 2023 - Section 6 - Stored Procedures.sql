-- Stored Procedure that returns the quantity on hand
GO

CREATE PROCEDURE oes.getQuantityOnHand (
	@product INT,
	@warehouse INT
)
AS

	BEGIN

		select * from oes.inventories 
		where product_id = @product 
		and warehouse_id = @warehouse

	END

GO

-- Return the quantity on hand for product id 4 and warehouse id 2
EXECUTE oes.getQuantityOnHand 
@product = 4,
@warehouse = 2


-- Test query for the stored procedure
select e.employee_id, 
	   e.first_name, 
	   e.last_name, 
	   m.employee_id as manager_id, 
	   m.first_name as manager_first_name, 
	   m.last_name as manager_last_name, 
	   d.department_name
from hcm.employees e
left join hcm.employees m
on e.manager_id = m.employee_id
left join hcm.departments d
on e.department_id= d.department_id
where m.first_name = 'jack'
and m.last_name = 'bernard'
and d.department_name = 'Executive'

GO


-- Stored procedure that will return the following manager names along with the department that they run, and the employees that work for them
CREATE PROCEDURE hcm.ManagerNamesAndDepartments (
	@manager_first_name VARCHAR(100),
	@manager_last_name VARCHAR(100),
	@department VARCHAR(100)
)
AS

BEGIN
	
	select e.employee_id, 
		   e.first_name, 
		   e.last_name, 
		   m.employee_id as manager_id, 
		   m.first_name as manager_first_name, 
		   m.last_name as manager_last_name, 
		   d.department_name
	from hcm.employees e
	left join hcm.employees m
	on e.manager_id = m.employee_id
	left join hcm.departments d
	on e.department_id= d.department_id
	where m.first_name = @manager_first_name
	and m.last_name = @manager_last_name
	and d.department_name = @department

END

GO


EXECUTE hcm.ManagerNamesAndDepartments 
@manager_first_name = 'Jack',
@manager_last_name = 'bernard', 
@department = 'Executive'



-- Strored procudeure that returns the current products
GO

CREATE PROCEDURE oes.getCurrentProducts (
	@prodcut_name VARCHAR(100),
	@max_list_price DECIMAL(19, 4)
)
AS

	BEGIN

		select * from oes.products
		where discontinued = 0
		and product_name like '%' + @prodcut_name + '%'
		and list_price <= @max_list_price

	END

GO

-- Return the current products that contain the word "Drone" and have a maximum price of 700
EXECUTE oes.getCurrentProducts @prodcut_name = 'Drone', @max_list_price = 700


-- Stored procedure that transfer money from one bank account to another bank account
GO
CREATE PROCEDURE oes.transferFunds (
	@withdraw_account_id INT,
	@deposit_account_id INT,
	@transfer_amount DECIMAL(30, 2)
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION

	-- Withdraw (debit) transfer amount from the first bank account
	UPDATE bank_accounts 
	SET balance = balance - @transfer_amount 
	WHERE account_id = @withdraw_account_id

	-- Deposit (credit) transfer amount into the second bank account
	UPDATE bank_accounts 
	SET balance = balance + @transfer_amount 
	WHERE account_id = @deposit_account_id

	-- Insert the transaction details
	INSERT INTO bank_transactions(from_account_id, to_account_id, amount)
	VALUES (@withdraw_account_id, @deposit_account_id, @transfer_amount)

COMMIT TRANSACTION

GO

-- Withdraw $100 from user 2 and deposit the $100 to user 1
EXECUTE oes.transferFunds 
@withdraw_account_id = 2,
@deposit_account_id = 1,
@transfer_amount = 100

-- Check the records
select * from oes.bank_accounts

-- Check the tranactions
select * from oes.bank_transactions
