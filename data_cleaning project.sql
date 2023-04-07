select *
from portfolio_project.dbo.NashvilleHousing


--Standerdize date format
select SaleDate,convert(date,SaleDate) AS saledate
from portfolio_project.dbo.NashvilleHousing
 

alter table dbo.NashvilleHousing
add Saledate2 Date;

update NashvilleHousing
set  Saledate2 = saledate

select Saledate2
from NashvilleHousing

-- Populate null property addresses

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,isnull(a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
     on a.ParcelID=b.ParcelID
	 and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
     on a.ParcelID=b.ParcelID
	 and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null


-- Breaking out the address into individual columns (Address,City) 


select substring(PropertyAddress,1,charindex(',',PropertyAddress)-1) as Address,
       substring (PropertyAddress,charindex(',',PropertyAddress)+1,len(PropertyAddress)) as City
from NashvilleHousing

alter table NashvilleHousing
add Split_Property_Address nvarchar(255);


update NashvilleHousing
set Split_Property_Address=substring (PropertyAddress,charindex(',',PropertyAddress)+1,len(PropertyAddress))

alter table NashvilleHousing
add Split_Property_City nvarchar(255)

update NashvilleHousing
set Split_Property_City=substring (PropertyAddress,charindex(',',PropertyAddress)+1,len(PropertyAddress))


--Splitting Owner Address(Address,City,State)

select OwnerAddress
from NashvilleHousing

select 
parsename(replace(OwnerAddress,',' , '.'),3),
parsename(replace(OwnerAddress,',' , '.'),2),
parsename(replace(OwnerAddress,',' , '.'),1)
from NashvilleHousing

alter table NashvilleHousing
add Split_Owner_Address nvarchar(255)

alter table NashvilleHousing
add Split_Owner_City nvarchar(255)

alter table NashvilleHousing
add Split_Owner_State nvarchar(255)

update NashvilleHousing
set Split_Owner_Address=parsename(replace(OwnerAddress,',' , '.'),3)


update NashvilleHousing
set Split_Owner_City=parsename(replace(OwnerAddress,',' , '.'),2)

update NashvilleHousing
set Split_Owner_State=parsename(replace(OwnerAddress,',' , '.'),1)

select *
from NashvilleHousing
where OwnerAddress is not null

-- Change Y and N to Yes and No in Sold as vacant column

select SoldAsVacant,count(SoldAsVacant)
from NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant,
case when SoldAsVacant = 'Y' then 'Yes'
     when SoldAsVacant = 'N' then 'No'
     else SoldAsVacant
      end
from NashvilleHousing

update NashvilleHousing
set SoldAsVacant =
case when SoldAsVacant = 'Y' then 'Yes'
     when SoldAsVacant = 'N' then 'No'
     else SoldAsVacant
      end

--Removing duplicates

with RownumCte as(
select *,
        row_number() over (
		partition by ParcelId,
		PropertyAddress,
		SaleDate,
		SalePrice,
		LegalReference,
		OwnerName
		order by UniqueID
		) row_num
from NashvilleHousing
)
select *
from RownumCte
where row_num>1

--Deleting Unused columns

alter table NashvilleHousing
drop column PropertyAddress,OwnerAddress,SaleDate