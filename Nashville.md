# Cleaning data using SQL

Ensure that I am on the correct database
```sql
USE [PortfolioProject]
```

```sql
-- Standardize Data Format
select SaleDate = cast(SaleDate as date),
	   SaleDate
from dbo.NashvilleHousing


ALTER TABLE [PortfolioProject].[dbo].[NashvilleHousing] ADD SaleDateConverted DATE
ALTER TABLE [PortfolioProject].[dbo].[NashvilleHousing] DROP COLUMN SaleDate

UPDATE [PortfolioProject].[dbo].[NashvilleHousing]
SET SaleDateConverted = cast(SaleDate as date)

sp_rename 'NashvilleHousing.SaleDateConverted', 'SalesDate', 'COLUMN'

-- Open the "Tools" menu bar >> Go to "Options" >> Click on the "Designers" drop down or search for it using the search bar >> uncheck the "Prevent saving changes that require table re-creation"
-- Once you have completed that step, right click on the table and select "Design", drag the column to the position of your choosing then exit out of the tab
-- it will ask you to save so click yes

-- Check the position of the column
select * from dbo.NashvilleHousing
```

```sql
-- Populate Property Address data
select * from dbo.NashvilleHousing where PropertyAddress is null

select nash1.PropertyAddress,
       nash2.PropertyAddress,
       NewPropertyAddress = isnull(nash1.PropertyAddress, nash2.PropertyAddress)
from dbo.NashvilleHousing nash1
join dbo.NashvilleHousing nash2
on nash1.ParcelID = nash2.ParcelID
and nash1.[UniqueID ] <> nash2.[UniqueID ]
where nash1.PropertyAddress is null


UPDATE nash1
SET PropertyAddress = ISNULL(nash1.PropertyAddress, nash2.PropertyAddress)
                      FROM dbo.NashvilleHousing nash1
                      JOIN dbo.NashvilleHousing nash2
                      ON nash1.ParcelID = nash2.ParcelID
                      AND nash1.[UniqueID ] <> nash2.[UniqueID ]
                      WHERE nash1.PropertyAddress IS NULL


select PropertyAddress from dbo.NashvilleHousing
```


```sql
-- Breaking out Address into Indivisual Columns (Street Name, City, State)
select PropertyAddress, 
       OwnerAddress 
from dbo.NashvilleHousing

select PropertyStreet = parsename(replace(PropertyAddress, ',', '.'), 2),
       PropertyCity = parsename(replace(PropertyAddress, ',', '.'), 1),
       OwnerStreet = parsename(replace(OwnerAddress, ',', '.'), 3),
       OwnerCity = parsename(replace(OwnerAddress, ',', '.'), 2),
       OwnerState = parsename(replace(OwnerAddress, ',', '.'), 1)
from dbo.NashvilleHousing


ALTER TABLE [PortfolioProject].[dbo].[NashvilleHousing] ADD PropertyStreet VARCHAR(75)
ALTER TABLE [PortfolioProject].[dbo].[NashvilleHousing] ADD PropertyCity VARCHAR(75)
ALTER TABLE [PortfolioProject].[dbo].[NashvilleHousing] ADD OwnerStreet VARCHAR(75)
ALTER TABLE [PortfolioProject].[dbo].[NashvilleHousing] ADD OwnerCity VARCHAR(75)
ALTER TABLE [PortfolioProject].[dbo].[NashvilleHousing] ADD OwnerState VARCHAR(75)

ALTER TABLE [PortfolioProject].[dbo].[NashvilleHousing] DROP COLUMN PropertyAddress
ALTER TABLE [PortfolioProject].[dbo].[NashvilleHousing] DROP COLUMN OwnerAddress

UPDATE [PortfolioProject].[dbo].[NashvilleHousing] SET PropertyStreet = PARSENAME(REPLACE(PropertyAddress, ',', '.'), 2)
UPDATE [PortfolioProject].[dbo].[NashvilleHousing] SET PropertyCity = PARSENAME(REPLACE(PropertyAddress, ',', '.'), 1)
UPDATE [PortfolioProject].[dbo].[NashvilleHousing] SET OwnerStreet = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
UPDATE [PortfolioProject].[dbo].[NashvilleHousing] SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
UPDATE [PortfolioProject].[dbo].[NashvilleHousing] SET OwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

select * from dbo.NashvilleHousing
```

```sql
-- Change Y and N to Yes and No in the "Sold as Vacant" field
select SoldAsVacant, 
	   CountYesAndNo = count(SoldAsVacant) 
from dbo.NashvilleHousing 
group by SoldAsVacant 
order by 2

-- Test Query
select ChangeCharacters = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes' WHEN SoldAsVacant = 'N' THEN 'No' ELSE SoldAsVacant END,
       SoldAsVacant
from dbo.NashvilleHousing 
group by SoldAsVacant


UPDATE [PortfolioProject].[dbo].[NashvilleHousing]
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
                        WHEN SoldAsVacant = 'N' THEN 'No'
                        ELSE SoldAsVacant
                   END
```

```sql
-- Remove Duplicates
-- Check for duplicates
with rankCTE as (
	select row_num = row_number() over(partition by ParcelID, 
                                                        LandUse, 
							PropertyStreet, 
						        PropertyCity, 
						        SalesDate, 
							SalePrice, 
							LegalReference,
							SoldAsVacant,
							OwnerName,
							OwnerStreet,
							OwnerState,
							Acreage,
							TaxDistrict,
							LandValue,
							BuildingValue,
							TotalValue,
							YearBuilt,
							Bedrooms,
							FullBath,
							HalfBath
                                          order by UniqueID),
             *
	from dbo.NashvilleHousing
)
select * from rankCTE
where row_num > 1


-- Delete duplicate values
with rankCTE as (
	select row_num = row_number() over(partition by ParcelID,
	                                                LandUse, 
							PropertyStreet, 
							PropertyCity, 
							SalesDate, 
							SalePrice, 
							LegalReference,
							SoldAsVacant,
							OwnerName,
							OwnerStreet,
							OwnerState,
							Acreage,
							TaxDistrict,
							LandValue,
							BuildingValue,
							TotalValue,
							YearBuilt,
							Bedrooms,
							FullBath,
							HalfBath
                                          order by UniqueID),
             *
	from dbo.NashvilleHousing
)
delete from rankCTE
where row_num > 1

select * from dbo.NashvilleHousing
```
