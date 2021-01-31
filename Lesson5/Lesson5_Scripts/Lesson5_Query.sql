------------HOMEWORK------------------
--TASK2
CREATE DATABASE MyJoinsDB
ON
(
	NAME = 'MyJoinsDB',
	FILENAME = 'F:\DB\MyJoinsDB.mdf',
	SIZE = 30MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME = 'LogMyJoinsDB',
	FILENAME = 'F:\DB\MyJoinsDB.ldf',
	SIZE = 5MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)
COLLATE Cyrillic_General_CI_AS 

USE MyJoinsDB
GO

--TASK3
CREATE TABLE Employee
(
	EmployeeID int IDENTITY NOT NULL PRIMARY KEY,
	Name varchar(20) NOT NULL,
	Phone varchar(10) CHECK (Phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
GO

CREATE TABLE Post
(
	PostID int IDENTITY NOT NULL PRIMARY KEY,
	Post varchar(20) NOT NULL,
	Salary money NOT NULL,
	EmployeeID int NOT NULL UNIQUE FOREIGN KEY REFERENCES Employee(EmployeeID)
)
GO

CREATE TABLE EmployeeInfo
(
	MaritalStatus varchar(25) NOT NULL,
	BirthDate date NOT NULL,
	City varchar(20) NOT NULL,
	Address varchar (25) NOT NULL,
	EmployeeID int NOT NULL UNIQUE FOREIGN KEY REFERENCES Employee(EmployeeID)
)
GO

INSERT INTO Employee
VALUES
('������ �. �.', '0952588722'),
('������� �. �.', '0958975745'),
('������� �. �.', '0952552721'),
('�������� �. �.', '0994750925'),
('�������� �. �.', '0665457680'),
('�������� �. �.', '0502446285'),
('����� �. �.', '0507820807')
GO

INSERT INTO Post
VALUES
('������� ��������', 40000,2),
('��������', 30000,3),
('�������', 15000,1),
('��������', 30000,4),
('�������', 15000,6),
('��������', 30000,5),
('�������', 15000,7)
GO

INSERT INTO EmployeeInfo
VALUES
('�����','05/30/1988','�������','���� �������� 8',2),
('�� �����','07/25/1994','�������','������ 15',3),
('�����','02/15/1986','�������','������� ������������ 20',1),
('�� �����','05/24/1990','����','����������� 17',4),
('�� �����','09/09/1985','�����','��������� 1�',6),
('�����','11/07/1992','����','�������� 44',5),
('�����','08/28/1994','�����','��������� 20�',7)
GO

--TASK4
SELECT Name, Phone, City, Address FROM Employee AS emp
JOIN
EmployeeInfo AS empInfo
ON emp.EmployeeID = empInfo.EmployeeID
GO

SELECT Name, Phone, MaritalStatus FROM Employee AS emp
join
EmployeeInfo AS empInfo
ON emp.EmployeeID = empInfo.EmployeeID
WHERE MaritalStatus = '�� �����'
GO

SELECT Name, Post, BirthDate, Phone FROM Employee AS emp
join
Post
ON emp.EmployeeID = Post.EmployeeID
join
EmployeeInfo AS empInfo
ON emp.EmployeeID = empInfo.EmployeeID
WHERE Post = '��������'
GO

SELECT * FROM Employee
SELECT * FROM Post
SELECT * FROM EmployeeInfo

--------------PRACTICE-----------------------
--TASK1
USE master
GO

CREATE TABLE Users
(
	ID int PRIMARY KEY,
	Username varchar(20)
)
GO

CREATE TABLE Transactions
(
	ID int,
	UserID int FOREIGN KEY REFERENCES Users(ID),
	[Value] int
)

INSERT INTO Users
VALUES
(1,'test_1'),
(2,'test_2'),
(3,'test_3'),
(4,'test_4')
GO

INSERT INTO Transactions
VALUES
(1,1,-10),
(2,1,30),
(3,3,30),
(4,3,-20),
(5,1,-12),
(6,4,-50),
(7,3,10)
GO

SELECT Username, ISNULL(SUM([Value]), 0) AS Balance FROM Users AS u
LEFT OUTER JOIN
Transactions AS t
ON t.UserID = u.ID
GROUP BY u.Username
GO

SELECT * FROM Users
SELECT * FROM Transactions
GO

--TASK2
USE AdventureWorks2016
GO

SELECT sp.BusinessEntityID, sp.SalesLastYear AS TotalSum FROM Sales.SalesPerson AS sp
JOIN
Sales.SalesOrderHeader AS oh
ON sp.BusinessEntityID = oh.SalesPersonID
GROUP BY sp.BusinessEntityID, sp.SalesLastYear
ORDER BY TotalSum DESC
GO

SELECT * FROM Sales.SalesPerson
SELECT * FROM Sales.SalesOrderHeader
GO

--TASK3
SELECT TOP(1) sp.BusinessEntityID, od.ProductID, SUM(od.OrderQty) AS Total FROM Sales.SalesPerson AS sp
JOIN
Sales.SalesOrderHeader AS oh
ON sp.BusinessEntityID = oh.SalesPersonID
JOIN 
Sales.SalesOrderDetail AS od
ON oh.SalesOrderID = od.SalesOrderID
WHERE od.ProductID = 773
GROUP BY sp.BusinessEntityID, od.ProductID
ORDER BY Total DESC
GO

SELECT * FROM Sales.SalesPerson
SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.SalesOrderDetail
GO