/*

Cleaning Data in SQL Queries

*/


SELECT *
FROM PortolioProject..NashvilleHousing

------------------------------------------------------------------------------

-- Standardize Date Format:

SELECT saleDate
FROM PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing ALTER COLUMN saleDate DATE

UPDATE NashvilleHousing
SET saleDate = CONVERT(DATE, SaleDate)

SELECT saleDate
FROM PortfolioProject..NashvilleHousing

------------------------------------------------------------------------------

-- Populate Property Address Data:

SELECT ParcelID, PropertyAddress
FROM PortfolioProject..NashvilleHousing
WHERE PropertyAddress IS NULL

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
	ON a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
	ON a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

------------------------------------------------------------------------------

-- Breaking Out Address Into Individual Columns (Address, City, State):

-- For The PropertyAddress
SELECT PropertyAddress
FROM PortfolioProject..NashvilleHousing

SELECT PropertyAddress,
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1),
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))
FROM PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitcity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))

SELECT *
FROM PortfolioProject..NashvilleHousing

-- For The OwnerAddress
SELECT OwnerAddress
FROM PortfolioProject..NashvilleHousing

SELECT OwnerAddress,
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3) AS Address,
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2) AS City,
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1) AS State
FROM PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255), OwnerSplitCity NVARCHAR(255), OwnerSplitState NVARCHAR(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3),
	OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2),
	OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)


------------------------------------------------------------------------------

-- Standardizing (Yes), (No) Values:
SELECT SoldAsVacant, count(SoldAsVacant)
FROM PortfolioProject..NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END
FROM PortfolioProject..NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = 
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END


------------------------------------------------------------------------------

-- Removing Duplicates:

WITH Row_Num_CTE AS (
SELECT *, ROW_NUMBER() OVER (
PARTITION BY ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference
ORDER BY UniqueID) RowNum
FROM PortfolioProject..NashvilleHousing
)
-- SELECT *
DELETE
FROM Row_Num_CTE
WHERE RowNum > 1


------------------------------------------------------------------------------

-- Delete Unused Columns:
SELECT *
FROM PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing
DROP COLUMN PropertyAddress, OwnerAddress, TaxDistrict


------------------------------------------------------------------------------


