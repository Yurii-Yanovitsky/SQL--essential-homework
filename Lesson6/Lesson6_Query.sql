-- TASK2
CREATE DATABASE MyJoinsDB
ON
(
	NAME = 'MyJoinsDB',
	FILENAME = 'F:DB/MyJoinsDB.mdf',
	SIZE = 30MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME = 'LogMyJoinsDB',
	FILENAME = 'MyJoinsDB',
	SIZE = 5MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)
COLLATE Cyrillic_General_CI_AS 

USE MyJoinsDB
GO

drop table Employee

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

--1)
select * from Employee

SELECT Phone, (SELECT City FROM EmployeeInfo AS einf WHERE e.EmployeeID = einf.EmployeeID) AS City,
			  (SELECT [Address] FROM EmployeeInfo AS einf WHERE e.EmployeeID = einf.EmployeeID) AS [Address]
FROM Employee AS e
WHERE e.EmployeeID IN (SELECT einf.EmployeeID FROM EmployeeInfo AS einf)
GO
--2)
SELECT (SELECT BirthDate FROM EmployeeInfo AS einf WHERE e.EmployeeID = einf.EmployeeID) AS BirthDate, Phone FROM Employee AS e
WHERE e.EmployeeID IN (SELECT einf.EmployeeID FROM EmployeeInfo AS einf WHERE MaritalStatus = '�� �����')
GO
--3)
SELECT (SELECT BirthDate FROM EmployeeInfo AS einf WHERE e.EmployeeID = einf.EmployeeID) AS BirthDate, Phone FROM Employee AS e
WHERE e.EmployeeID IN (SELECT EmployeeID FROM Post WHERE Post = '��������')
GO