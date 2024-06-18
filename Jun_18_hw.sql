-- 1.
SELECT ProductId, Name, Color, ListPrice
FROM Production.Product

SELECT ProductId, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice <> 0

SELECT ProductId, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NULL

SELECT ProductId, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL

SELECT ProductId, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL AND ListPrice > 0

SELECT Name + Color
FROM Production.Product
WHERE Color IS NOT NULL

SELECT 'NAME: ' + Name + ' -- COLOR: ' + Color
FROM Production.Product
WHERE Color IS NOT NULL

SELECT ProductId, Name
FROM Production.Product
WHERE productId BETWEEN 400 AND 500

SELECT ProductId, Name, Color
FROM Production.Product
WHERE Color = 'Black' OR Color = 'Blue'

SELECT *
FROM Production.Product
WHERE Name LIKE 'S%'

SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'S%'
ORDER BY Name

SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'S%' OR Name LIKE 'A%'
ORDER BY Name

SELECT *
FROM Production.Product
WHERE Name LIKE 'SPO[^K]%'
ORDER BY Name

SELECT DISTINCT Color
FROM Production.Product
WHERE Color IS NOT NULL
ORDER BY Color DESC

SELECT DISTINCT ProductSubcategoryID, Color
FROM Production.Product
WHERE ProductSubcategoryID is NOT NULL AND Color IS NOT NULL