-- Exercise 1
-- Blueprint of the table that will be used to perform window functions
select pp.Name, 
       pp.ListPrice, 
       ps.Name,
       pc.Name
from Production.Product pp
join Production.ProductSubcategory ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
on ps.ProductCategoryID = pc.ProductCategoryID


-- Exercise 2
-- Compare the average List price value for each product category
select pp.Name, 
       pp.ListPrice, 
       ps.Name,
       pc.Name,
       avg(pp.ListPrice) over(partition by pc.Name) as AvgPriceByCategory
from Production.Product pp
join Production.ProductSubcategory ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
on ps.ProductCategoryID = pc.ProductCategoryID


-- Exercise 3
-- Compare the average List price value for each product category and subcategory
select pp.Name, 
       pp.ListPrice, 
       ps.Name, 
       pc.Name,
       avg(pp.ListPrice) over(partition by pc.Name) as AvgPriceByCategory,
       avg(pp.ListPrice) over(partition by pc.Name, ps.Name) as AvgPriceByCategoryAndSubcategory
from Production.Product pp
join Production.ProductSubcategory ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
on ps.ProductCategoryID = pc.ProductCategoryID


-- Exercise 4
-- Compare the product's list price to the average list price for each product category
select pp.Name, 
       pp.ListPrice, 
       ps.Name,
       pc.Name,
       avg(pp.ListPrice) over(partition by pc.Name) as AvgPriceByCategory,
       avg(pp.ListPrice) over(partition by pc.Name, ps.Name) as AvgPriceByCategoryAndSubcategory,
       pp.ListPrice - avg(pp.ListPrice) over(partition by pc.Name) as ProductVsCategoryDelta
from Production.Product pp
join Production.ProductSubcategory ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
on ps.ProductCategoryID = pc.ProductCategoryID
