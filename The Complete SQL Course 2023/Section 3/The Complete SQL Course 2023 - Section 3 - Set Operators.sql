-- Returns all rows for the following species
select * from bird.california_sightings
union all
select * from bird.arizona_sightings


-- Returns all unique species
select common_name, scientific_name, location_of_sighting, sighting_date from bird.california_sightings
union
select common_name, scientific_name, sighting_location, sighting_date from bird.arizona_sightings


-- Returns all unique combinations of speices from states California & Arizona
select scientific_name, 'California' as state from bird.california_sightings
union
select scientific_name, 'Arizona' as state from bird.arizona_sightings
order by state, scientific_name


-- Returns all unique combinations of speices from states California, Arizona & Florida
select common_name, scientific_name, location_of_sighting, sighting_date, 'California' as state from bird.california_sightings
union all
select common_name, scientific_name, sighting_location, sighting_date, 'Arizona' as state from bird.arizona_sightings
union all
select NULL, scientific_name, locality, sighting_datetime, 'Florida' as state from bird.florida_sightings
order by scientific_name, state


-- Returns all unique customers who have placed multiple orders
select customer_id from oes.customers
intersect
select customer_id from oes.orders


-- Returns all unique products that are currently not in stock 
select product_id from oes.products
except
select product_id from oes.inventories
