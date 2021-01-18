--ADDITIONAL TASK
CREATE DATABASE HRDepartmentDB
ON
(
	NAME  = 'HRDepartmentDB',
	FILENAME = 'F:\DB\HRDepartmentDB.mdf',
	SIZE = 30MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME  = 'LogHRDepartmentDB',
	FILENAME = 'F:\DB\HRDepartmentDB.ldf',
	SIZE = 5MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)
COLLATE Cyrillic_General_CI_AS

USE HRDepartmentDB
GO

CREATE TABLE Department
(
	DepartmentID int IDENTITY NOT NULL PRIMARY KEY,
	DepartmentName char(30) NOT NULL
)
GO

CREATE TABLE Position
(
	PositionID int IDENTITY NOT NULL PRIMARY KEY,
	PositionName varchar(30) NOT NULL,
	Salary money NOT NULL
)
GO

CREATE TABLE Employee
(
	EmployeeID int IDENTITY NOT NULL PRIMARY KEY,
	FirstName varchar(20) NOT NULL,
	MiddleName varchar(20) NOT NULL,
	LastName varchar(20) NOT NULL,
	BirthDate date NOT NULL,
	[Address] varchar(25) NOT NULL,
	Phone varchar(10) NOT NULL CHECK(Phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	DepartmentID int NOT NULL FOREIGN KEY REFERENCES Department(DepartmentID),
	PositionID int NOT NULL FOREIGN KEY REFERENCES Position(PositionID)
)
GO

CREATE TABLE Task
(
	ID int IDENTITY NOT NULL PRIMARY KEY,
	Task char(50) NOT NULL,
	DateBegin date NOT NULL,
	EmployeeID int NOT NULL FOREIGN KEY REFERENCES Employee(EmployeeID)
)
GO

CREATE TABLE HoursWorkedLastMonth
(
	ID int IDENTITY NOT NULL PRIMARY KEY,
	HoursWorked int NOT NULL,
	[Date] date NOT NULL,
	EmployeeID int NOT NULL UNIQUE FOREIGN KEY REFERENCES Employee(EmployeeID)
)
GO

INSERT INTO Department
VALUES
('����� ���������'),
('����� ����������'),
('�����������')
GO

INSERT INTO Position
VALUES
('������', 30000),
('����������', 35000),
('���������', 25000)
GO

INSERT INTO Employee
(FirstName, MiddleName, LastName, BirthDate, [Address], Phone, DepartmentID, PositionID)
VALUES
('������','��������','������','02/15/1990','�������������� 58','0997772425',1,1),
('�������','��������','������','04/20/1988','�������� 10','0995772884',2,2),
('�������','����������','�������','07/30/1985','������� ������������ 17','0995752890',3,3),
('�����','����������','�����','11/02/1992','�������� 5�','0995752890',3,3)
GO

INSERT INTO Task
VALUES
('��������� ��������� �������� ������', '01/14/2021',2),
('��������� ������� ��������������� ������', '01/16/2021',1),
('������� ��������� ������������', '01/15/2021',2),
('������������ ����� �� ������', '01/17/2021',1),
('��������� ����������', '01/11/2021',3)
Go

INSERT INTO HoursWorkedLastMonth
VALUES
(150,CURRENT_TIMESTAMP, 1),
(110,CURRENT_TIMESTAMP, 2),
(135,CURRENT_TIMESTAMP, 3),
(120,CURRENT_TIMESTAMP, 4)
GO

SELECT * FROM Department
SELECT * FROM Position
SELECT * FROM Employee
SELECT * FROM Task
SELECT * FROM HoursWorkedLastMonth
GO

--TASK2
CREATE DATABASE WarehouseDB
ON
(
	NAME  = 'WarehouseDB',
	FILENAME = 'F:\DB\WarehouseDB.mdf',
	SIZE = 30MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME  = 'LogWarehouseDB',
	FILENAME = 'E:\Logs\WarehouseDB.ldf',
	SIZE = 5MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)
COLLATE Cyrillic_General_CI_AS

USE WarehouseDB
GO

--TASK3
CREATE TABLE Staff
(
	StaffID int IDENTITY NOT NULL PRIMARY KEY,
	[Name] varchar(20) NOT NULL,
	Post varchar(20) NOT NULL,
	[Address] varchar(30) NOT NULL,
	Phone varchar(10),
	Email varchar(30)
)
GO

CREATE TABLE [Provider]
(
	ProviderID int IDENTITY NOT NULL PRIMARY KEY,
	ProviderName varchar(30) NOT NULL,
	Product varchar(30) NOT NULL,
	[Address] varchar(30) NOT NULL,
	City varchar(20) NOT NULL,
	Phone varchar(10),
	Email varchar(30),
	Staff int NOT NULL FOREIGN KEY REFERENCES Staff(StaffID)
)
GO

CREATE TABLE Customers
(
	CustomerID int IDENTITY NOT NULL PRIMARY KEY,
	CustomerName varchar(30) NOT NULL,
	[Address] varchar(30) NOT NULL,
	City varchar(20) NOT NULL,
	Phone varchar(10),
	Email varchar(30),
	Staff int NOT NULL FOREIGN KEY REFERENCES Staff(StaffID)	
)
GO

INSERT INTO Staff
VALUES
('������ �. �.','�������� �� ��������','������ 7', '0952296070', 'chepigaAlex@mail.ru'),
('������ �. �.','�������� �� ��������','�������� 3', '0992457855', 'ivashuk1980@yande.ua')
GO

INSERT INTO [Provider]
VALUES
('TechCompany','���������','���������� 8','�������','0632443050','techCompany@gmail.com', 1),
('LG Electronics ','������������','��������� 2�','����','0962475077','lg_electronics@gmail.com', 1)
GO

INSERT INTO Customers
VALUES
('������� �. �.','����������� 15�','�����','0952296070','Nikonov55@yandex.ua', 2),
('�������� �. �.','������� 7�','����','0992907029','Sheva2021@gmail.com', 2)
GO

SELECT * FROM Staff
SELECT * FROM [Provider]
SELECT * FROM Customers
GO

--ADDITIONAL TASK PRACTICE
CREATE DATABASE [Library]
ON
(
	NAME = 'Library',
	FILENAME = 'F:\DB\Library.mdf',
	SIZE = 10MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME = 'Library.ldf',
	FILENAME = 'F:\DB\Library.ldf',
	SIZE = 5MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)
COLLATE Cyrillic_General_CI_AS

USE [Library]
GO

CREATE TABLE Authors
(
	AuthorID smallint IDENTITY NOT NULL,
	AuthorFirstName varchar(20) NOT NULL default 'Uknown',
	AuthorLastName varchar(20) NULL default 'Uknown',
	AuthorAge smallint NULL default NULL,
)
GO

INSERT INTO Authors
(AuthorFirstName, AuthorLastName, AuthorAge)
VALUES
('���������', '������', 37),
('������', '������', 30),
('����', '������', 40),
('����', '���������', 44),
('����������', '�����', 80)
GO

SELECT * FROM Authors
GO

ALTER TABLE Authors
ADD
Country varchar(20) NOT NULL default 'Uknown'
GO

ALTER TABLE Authors
ADD CONSTRAINT PK_Authors
PRIMARY KEY (AuthorID)
GO

CREATE TABLE Books
(
	BookID smallint IDENTITY NOT NULL PRIMARY KEY,
	BookTitel varchar(20) NULL default 'Uknown',
	AuthorID smallint NOT NULL FOREIGN KEY REFERENCES Authors(AuthorID),
)
GO

INSERT INTO Books
(BookTitel, AuthorID)
VALUES
('������ � �������', 1),
('��������� �������', 1),
('������� ������', 1),
('��������', 2),
('������������', 2),
('������ ����', 3),
('������� ����', 3),
('����� ����', 3)
GO

SELECT * FROM Authors
SELECT * FROM Books
GO