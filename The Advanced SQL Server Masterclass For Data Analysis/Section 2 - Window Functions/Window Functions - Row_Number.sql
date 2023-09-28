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
-- View the rankings of the most expensive product to the least expensive product
select pp.Name, 
	   pp.ListPrice, 
	   ps.Name,
	   pc.Name,
	   row_number() over(order by pp.ListPrice desc) as PriceRank
from Production.Product pp
join Production.ProductSubcategory ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
on ps.ProductCategoryID = pc.ProductCategoryID


-- Exercise 3
-- View the rankings of the most expensive product to the least expensive product for each category
select pp.Name, 
	   pp.ListPrice, 
	   ps.Name,
	   pc.Name,
	   row_number() over(order by pp.ListPrice desc) as PriceRank,
	   row_number() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRank
from Production.Product pp
join Production.ProductSubcategory ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
on ps.ProductCategoryID = pc.ProductCategoryID


-- Exercise 4
-- View the top 5 list prices for each category 
select pp.Name, 
	   pp.ListPrice, 
	   ps.Name,
	   pc.Name,
	   row_number() over(order by pp.ListPrice desc) as PriceRank,
	   row_number() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRank,
	   case when row_number() over(partition by pc.Name order by pp.ListPrice desc) <= 5 then 'Yes' else 'No' end as Top5PriceInCategory
from Production.Product pp
join Production.ProductSubcategory ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
on ps.ProductCategoryID = pc.ProductCategoryID