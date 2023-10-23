USE [AdventureWorks2017]

-- Challenge 1
-- 
select pod.PurchaseOrderID,
       pod.PurchaseOrderDetailID,
       pod.OrderQty,
       pod.UnitPrice,
       pod.LineTotal,
       poh.OrderDate,
       ProductName = pro.Name,
       Subcategory = isnull(prs.Name, 'None'),
       Category = isnull(prc.Name, 'None'),
       OrderSizeCategory = case when pod.OrderQty > 500 then 'Large' 
				when pod.OrderQty > 50 and pod.OrderQty <= 500 then 'Medium'
				else 'Small'
			   end
from Purchasing.PurchaseOrderDetail pod
join Purchasing.PurchaseOrderHeader poh
on pod.PurchaseOrderID = poh.PurchaseOrderID
join Production.Product pro
on pod.ProductID = pro.ProductID
join Production.ProductSubcategory prs
on pro.ProductSubcategoryID = prs.ProductSubcategoryID
join Production.ProductCategory prc
on prs.ProductCategoryID = prc.ProductCategoryID
where month(poh.OrderDate) = 12
GO


-- Challenge 2
-- 
select Purchases = 'Purchases',
       pod.PurchaseOrderID,
       pod.PurchaseOrderDetailID,
       pod.OrderQty,
       pod.UnitPrice,
       pod.LineTotal,
       poh.OrderDate,
       ProductName = pro.Name,
       Subcategory = isnull(prs.Name, 'None'),
       Category = isnull(prc.Name, 'None'),
       OrderSizeCategory = case when pod.OrderQty > 500 then 'Large' 
				when pod.OrderQty > 50 and pod.OrderQty <= 500 then 'Medium'
				else 'Small'
			   end
from Purchasing.PurchaseOrderDetail pod
join Purchasing.PurchaseOrderHeader poh
on pod.PurchaseOrderID = poh.PurchaseOrderID
join Production.Product pro
on pod.ProductID = pro.ProductID
join Production.ProductSubcategory prs
on pro.ProductSubcategoryID = prs.ProductSubcategoryID
join Production.ProductCategory prc
on prs.ProductCategoryID = prc.ProductCategoryID
where month(poh.OrderDate) = 12

union

select Sales = 'Sales',
       sod.SalesOrderID,
       sod.SalesOrderDetailID,
       sod.OrderQty,
       sod.UnitPrice,
       sod.LineTotal,
       soh.OrderDate,
       ProductName = pro.Name,
       Subcategory = isnull(prs.Name, 'None'),
       Category = isnull(prc.Name, 'None'),
       OrderSizeCategory = case when sod.OrderQty > 500 then 'Large' 
				when sod.OrderQty > 50 and sod.OrderQty <= 500 then 'Medium'
				else 'Small'
			   end
from Sales.SalesOrderDetail sod
join Sales.SalesOrderHeader soh
on sod.SalesOrderID = soh.SalesOrderID
join Production.Product pro
on sod.ProductID = pro.ProductID
join Production.ProductSubcategory prs
on pro.ProductSubcategoryID = prs.ProductSubcategoryID
join Production.ProductCategory prc
on prs.ProductCategoryID = prc.ProductCategoryID
where month(soh.OrderDate) = 12
GO


-- Challege 3
-- 
select per.BusinessEntityID,
       per.PersonType,
       FullName = concat(per.FirstName, ' ' , '' + MiddleName, ' ', LastName),
       Address = adr.AddressLine1,
       adr.City,
       adr.PostalCode,
       State = psr.Name,
       Country = pcr.Name
from Person.Person per
join Person.BusinessEntityAddress bea
on per.BusinessEntityID = bea.BusinessEntityID
join Person.Address adr
on bea.AddressID = adr.AddressID
join Person.StateProvince psr
on adr.StateProvinceID = psr.StateProvinceID
join Person.CountryRegion pcr
on psr.CountryRegionCode = pcr.CountryRegionCode
where per.PersonType = 'SP'
and (adr.PostalCode like '9%'
or len(adr.PostalCode) = 5
and pcr.Name = 'United States')
GO


-- Challenge 4
-- 
with employeesCTE as (
	select JobCategory = case when emp.JobTitle like '%Manager%' or emp.JobTitle like '%President%' or emp.JobTitle like '%Executive%' then 'Management'
				  when emp.JobTitle like '%Engineer%' then 'Engineering'
				  when emp.JobTitle like '%Production%' then 'Production'
				  when emp.JobTitle like '%Marketing%' then 'Marketing'
				  when emp.JobTitle is null then 'NA'
				  when emp.JobTitle in ('Recruiter', '“Benefits Specialist', 'Human Resources Administrative Assistant') then 'Human Resources'
				  else 'Other'
			     end,
		   JobTitle = isnull(emp.JobTitle, 'None')
	from Person.Person per
	left join HumanResources.Employee emp
	on emp.BusinessEntityID = per.BusinessEntityID
)
select * from employeesCTE where JobCategory <> 'NA'


-- Challenge 5
-- 
select getdate() as CurrentDate

-- 
select datefromparts(year(getdate()), month(getdate()), 1)

-- 
select dateadd(month, 1, datefromparts(year(getdate()), month(getdate()), 1))

-- 
select dateadd(day, -1,  dateadd(month, 1, datefromparts(year(getdate()), month(getdate()), 1)))

-- 
select DATEDIFF(DAY, getdate(), dateadd(day, -1,  dateadd(month, 1, datefromparts(year(getdate()), month(getdate()), 1))))

