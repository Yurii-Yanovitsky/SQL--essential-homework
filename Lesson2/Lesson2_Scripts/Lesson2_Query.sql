--ADDITIONAL TASK
USE AdventureWorks2016
GO

SELECT * FROM Production.Product
WHERE StandardCost > 100
GO

SELECT * FROM Production.Product
WHERE NAME LIKE 'ML%' AND ProductNumber LIKE 'RM%'
GO

--ADDITIONAL TASK1
SELECT FirstName, COUNT(*) as [COUNT] FROM Person.Person
GROUP BY FirstName
ORDER BY [COUNT] DESC
GO

--ADDITIONAL TASK2
SELECT DaysToManufacture, SUM(ListPrice) AS TOTAL FROM Production.Product
GROUP BY DaysToManufacture
HAVING SUM(ListPrice) > 3000
GO

--ADDITIONAL TASK3
SELECT ModifiedDate, SalesLastYear*CommissionPct AS TOTAL FROM Sales.SalesPerson
WHERE ModifiedDate > '2012-01-01' AND SalesLastYear > 0
GO

-- TASK2
CREATE DATABASE HomeWork
ON
(
	NAME = 'HomeWork',
	FILENAME = 'F:\DB\HomeWork.mdf',
	SIZE = 10MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME = 'HomeWork.ldf',
	FILENAME = 'F:\DB\HomeWork.ldf',
	SIZE = 5MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)
COLLATE Cyrillic_General_CI_AS

USE HomeWork
GO

CREATE TABLE Product
(
	ProductID Int IDENTITY NOT NULL,
	[Name] Varchar(20) NUll,
	ProductNumber Varchar(20) NULL,
	Cost Money NULL,
	[Count] int NULL,
	SellStartDate Date NULL
)
GO

INSERT INTO  Product
([Name],ProductNumber,Cost,[Count], SellStartDate)
VALUES
('Корона','AK-53818', $5, 50, '08/15/2011'),
('Милка','AK-51122', $6.1, 50, '07/15/2011'),
('Аленка','AA-52211', $2.5, 20, '06/15/2011'),
('Snickers','BS-32118', $2.8, 50, '08/15/2011'),
('Snickers','BSL-3818', $5, 100, '08/20/2011'),
('Bounty','BB-38218', $3, 100, '08/01/2011'),
('Nuts','BN-37818', $3, 100, '08/21/2011'),
('Mars','BM-3618', $2.5, 50, '08/24/2011'),
('Свиточ','AS-54181', $5, 100, '08/12/2011'),
('Свиточ','AS-54182', $5, 100, '08/12/2011');
GO

-- TASK3
SELECT * FROM Product
WHERE [COUNT] > 59
GO

SELECT * FROM Product
WHERE [COST] > 3 AND SellStartDate = '08/20/2011'
GO

-- TASK4
UPDATE Product
SET COST = 5.25
WHERE NAME = 'Свиточ'
GO

SELECT * FROM Product
GO