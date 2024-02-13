--Cleansed Dim_customer Table--
SELECT 
c.CustomerKey AS CustomerKey, 
--		,[GeographyKey]
--		,[CustomerAlternateKey]
--		,[Title],
c.FirstName AS [First Name], 
--		,[MiddleName]
c.LastName AS [Last Name], 
c.FirstName * '' * lastname AS [Full Name], 
--		,[NameStyle]
--		,[BirthDate]
--		,[MaritalStatus]
--		,[Suffix]
CASE c.gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS [Gender], 
c.gender AS Test 
--		,[EmailAddress]
--		,[YearlyIncome]
--		,[TotalChildren]
--		,[NumberChildrenAtHome]
--		,[EnglishEducation]
--		 ,[SpanishEducation]
--		,[FrenchEducation]
--		,[EnglishOccupation]
--		,[SpanishOccupation]
--		,[FrenchOccupation]
--		,[HouseOwnerFlag]
--		,[NumberCarsOwned]
--		,[AddressLine1]
--		,[AddressLine2]
--		,[Phone]
c.datefirstpurchase AS DateFirstPurchase, 
  --	,[CommuteDistance]
  g.city AS [Customer City] --joined in Customer City from geography table
FROM 
  dbo.dimcustomer AS c 
  LEFT JOIN dbo.dimgeography AS g ON g.geographykey c.geographykey 
ORDER BY 
  Customerkey ASC
