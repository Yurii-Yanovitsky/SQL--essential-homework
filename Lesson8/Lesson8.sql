--TASK2
CREATE DATABASE MyFuncDB
ON
(
	NAME = 'MyFuncDB',
	FILENAME = 'F:\DB\MyFuncDB.mdf',
	SIZE = 30MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME = 'LogMyFuncDB',
	FILENAME = 'F:\DB\MyFuncDB.log',
	SIZE = 5MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)
GO

drop database MyFuncDB

USE MyFuncDB
GO

--TASK3
DROP TABLE PostInfo
DROP TABLE EmployeeInfo
DROP TABLE Employee
GO

CREATE TABLE Employee
(
	EmployeeID int IDENTITY PRIMARY KEY,
	[Name] varchar(30) NOT NULL,
	Phone char(10) NOT NULL UNIQUE
)
GO

CREATE TABLE PostInfo
(
	PostID int IDENTITY PRIMARY KEY,
	Post varchar(25) NOT NULL,
	Salary money NOT NULL,
	EmployeeID int NOT NULL UNIQUE,
    FOREIGN KEY(EmployeeID) REFERENCES Employee (EmployeeID)
	ON DELETE CASCADE
)
GO

CREATE TABLE EmployeeInfo
(
	MaritalStatus varchar(20) NOT NULL,
	BirthDate date NOT NULL,
	[Address1] varchar(30) NOT NULL,
	EmployeeID int NOT NULL UNIQUE CLUSTERED,
    FOREIGN KEY(EmployeeID) REFERENCES Employee (EmployeeID)
)
GO


INSERT INTO Employee
VALUES
('Петров С. В.', '0952588722'),
('Сергеев А. Н.', '0958975745'),
('Федоров Д. В.', '0952552721'),
('Щербаков О. А.', '0994750925'),
('Шевченко А. Ю.', '0665457680'),
('Веселкин Н. С.', '0502446285'),
('Дорош В. А.', '0507820807')
GO

INSERT INTO PostInfo
VALUES
('главный директор', 40000,2),
('менеджер', 30000,3),
('рабочий', 15000,1),
('менеджер', 30000,4),
('рабочий', 15000,6),
('менеджер', 30000,5),
('рабочий', 15000,7)
GO

INSERT INTO EmployeeInfo
VALUES
('женат','05/30/1988','Лизы Чайкиной 8',2),
('не женат','07/25/1994','Фрунзе 15',3),
('женат','02/15/1986','Богдана Хмельницкого 20',1),
('не женат','05/24/1990','Клочковская 17',4),
('не женат','09/09/1985','Татаренка 1а',6),
('женат','11/07/1992','Горького 44',5),
('женат','08/28/1994','Льговская 20б',7)
GO


--TASK4

--USING PROCEDURE
--1)
CREATE PROCEDURE prcContactInfo
AS SELECT e.[Name], e.Phone, ei.Address1 FROM Employee e
JOIN EmployeeInfo ei
ON e.EmployeeID = ei.EmployeeID
GO

EXECUTE prcContactInfo
GO

--2)
CREATE PROCEDURE prcUnmarriedInfo
AS SELECT e.[Name], ei.BirthDate, e.Phone FROM Employee e
JOIN EmployeeInfo ei
ON e.EmployeeID = ei.EmployeeID
WHERE ei.MaritalStatus = 'не женат'
GO

EXECUTE prcUnmarriedInfo
GO

--3)
CREATE PROCEDURE prcManagerInfo
AS SELECT e.[Name], ei.BirthDate, e.Phone FROM Employee e
JOIN EmployeeInfo ei
ON e.EmployeeID = ei.EmployeeID
JOIN PostInfo p
ON e.EmployeeID = p.EmployeeID
WHERE p.Post = 'менеджер'
GO

EXECUTE prcManagerInfo
GO

--USING FUNCTION
--1)
CREATE FUNCTION  fncContactInfo()
RETURNS TABLE
AS
RETURN SELECT e.[Name], e.Phone, ei.Address1 FROM Employee e
JOIN EmployeeInfo ei
ON e.EmployeeID = ei.EmployeeID
GO

SELECT * FROM dbo.fncContactInfo()
GO

--2)
CREATE FUNCTION  fncUnmarriedInfo()
RETURNS TABLE
AS
RETURN SELECT e.[Name], ei.BirthDate, e.Phone FROM Employee e
JOIN EmployeeInfo ei
ON e.EmployeeID = ei.EmployeeID
WHERE ei.MaritalStatus = 'не женат'
GO

SELECT * FROM dbo.fncUnmarriedInfo()
GO

--3)
CREATE FUNCTION  fncManagerInfo()
RETURNS TABLE
AS
RETURN SELECT e.[Name], ei.BirthDate, e.Phone FROM Employee e
JOIN EmployeeInfo ei
ON e.EmployeeID = ei.EmployeeID
JOIN PostInfo p
ON e.EmployeeID = p.EmployeeID
WHERE p.Post = 'менеджер'
GO

SELECT * FROM dbo.fncManagerInfo()
GO

