-- Exercise 1
-- 
select pp.Name, 
	   pp.ListPrice, 
	   ps.Name,
	   pc.Name,
	   row_number() over(order by pp.ListPrice desc) as PriceRank,
	   row_number() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRank,
	   rank() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRankWithRank,
	   case when row_number() over(partition by pc.Name order by pp.ListPrice desc) <= 5 then 'Yes' else 'No' end as Top5PriceInCategory
from Production.Product pp
join Production.ProductSubcategory ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
on ps.ProductCategoryID = pc.ProductCategoryID



-- Exercise 2
-- 
select pp.Name, 
	   pp.ListPrice, 
	   ps.Name,
	   pc.Name,
	   row_number() over(order by pp.ListPrice desc) as PriceRank,
	   row_number() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRank,
	   rank() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRankWithRank,
	   dense_rank() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRankWithDenseRank,
	   case when row_number() over(partition by pc.Name order by pp.ListPrice desc) <= 5 then 'Yes' else 'No' end as Top5PriceInCategory
from Production.Product pp
join Production.ProductSubcategory ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
on ps.ProductCategoryID = pc.ProductCategoryID


-- Exercise 3
-- 
select pp.Name, 
	   pp.ListPrice, 
	   ps.Name,
	   pc.Name,
	   row_number() over(order by pp.ListPrice desc) as PriceRank,
	   row_number() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRank,
	   rank() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRankWithRank,
	   dense_rank() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRankWithDenseRank,
	   case when row_number() over(partition by pc.Name order by pp.ListPrice desc) <= 5 then 'Yes' else 'No' end as Top5PriceInCategory
from Production.Product pp
join Production.ProductSubcategory ps
on pp.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
on ps.ProductCategoryID = pc.ProductCategoryID


-- Exercise 3
-- Get all top 5 products for each category
with cte as (
	select pp.Name as ProductName, 
		   pp.ListPrice, 
		   ps.Name as CategroryName,
		   pc.Name as SubcategoryName,
		   row_number() over(order by pp.ListPrice desc) as PriceRank,
		   row_number() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRank,
		   rank() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRankWithRank,
		   dense_rank() over(partition by pc.Name order by pp.ListPrice desc) as CategoryPriceRankWithDenseRank,
		   case when row_number() over(partition by pc.Name order by pp.ListPrice desc) <= 5 then 'Yes' else 'No' end as Top5PriceInCategory
	from Production.Product pp
	join Production.ProductSubcategory ps
	on pp.ProductSubcategoryID = ps.ProductSubcategoryID
	join Production.ProductCategory pc
	on ps.ProductCategoryID = pc.ProductCategoryID
)
select * from cte where Top5PriceInCategory = 'yes'
