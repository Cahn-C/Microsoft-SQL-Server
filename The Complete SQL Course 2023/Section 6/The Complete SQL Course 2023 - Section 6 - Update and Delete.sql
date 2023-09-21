-- Change Miriam's last name, due to marriage
UPDATE dbo.emp SET last_name = 'Greenbank' WHERE emp_id = 2


-- Check records
select * from dbo.emp
GO

-- Delete employee Scott Daveis, due to lack of work
DELETE FROM dbo.emp WHERE emp_id = 1


-- Check records
select * from dbo.emp
GO