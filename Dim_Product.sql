/****** Cleansed DIM Product Table  ******/
SELECT 
p.[ProductKey],
      p.[ProductAlternateKey] AS productItemCode,
      --,[ProductSubcategoryKey]
      --,[WeightUnitMeasureCode]
      --,[SizeUnitMeasureCode]
      p.[EnglishProductName] AS [ProductName],
	  ps.EnglishProductSubcategoryName AS [Sub Category], --Joined in from sub category Table
	  pc.EnglishProductCategoryName AS [Product Category], --Joined in from category Table
      --,[SpanishProductName]
      --,[FrenchProductName]
      --,[StandardCost]
      --,[FinishedGoodsFlag]
      p.[Color] AS [Product Color],
      --,[SafetyStockLevel]
      --,[ReorderPoint]
      --,[ListPrice]
       p.[size] AS [Product size],
      --,[SizeRange]
      --,[Weight]
      --,[DaysToManufacture]
      p.[ProductLine] AS [Product Line],
      --,[DealerPrice]
      --,[Class]
      --,[Style]
      p.[ModelName] AS[Product Model Name],
      --,[LargePhoto]
      p.[EnglishDescription] AS [Product Description],
      --,[FrenchDescription]
      --,[ChineseDescription]
      --,[ArabicDescription]
      --,[HebrewDescription]
      --,[ThaiDescription]
      --,[GermanDescription]
      --,[JapaneseDescription]
      --,[TurkishDescription]
      --,[StartDate]
      --,[EndDate]
	  p.status AS Example,
      ISNULL (p.status, 'Outdated') AS [Product Status]
  FROM
  [dbo].[DimProduct] AS p
  LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategorykey 
  LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategorykey
  Order By
  p.ProductKey ASC
