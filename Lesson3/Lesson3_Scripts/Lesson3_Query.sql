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
('Отдел логистики'),
('Отдел маркетинга'),
('Бухгалтерия')
GO

INSERT INTO Position
VALUES
('Логист', 30000),
('Маркетолог', 35000),
('Бухгалтер', 25000)
GO

INSERT INTO Employee
(FirstName, MiddleName, LastName, BirthDate, [Address], Phone, DepartmentID, PositionID)
VALUES
('Сергей','Петрович','Иванов','02/15/1990','Благовещенская 58','0997772425',1,1),
('Николай','Иванович','Петров','04/20/1988','Одесская 10','0995772884',2,2),
('Людмила','Викторовна','Куценко','07/30/1985','Богдана Хмельницкого 17','0995752890',3,3),
('Алина','Викторовна','Дедко','11/02/1992','Фейєрбаха 5а','0995752890',3,3)
GO

INSERT INTO Task
VALUES
('Утвердить стратегии развития товара', '01/14/2021',2),
('Составить маршрут транспортировки грузов', '01/16/2021',1),
('Изучить поведение потребителей', '01/15/2021',2),
('Распределить товар на складе', '01/17/2021',1),
('Составить отчетность', '01/11/2021',3)
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
('Чепига А. В.','Менеджер по продажам','Фрунзе 7', '0952296070', 'chepigaAlex@mail.ru'),
('Иващук М. Н.','Менеджер по закупкам','Молочная 3', '0992457855', 'ivashuk1980@yande.ua')
GO

INSERT INTO [Provider]
VALUES
('TechCompany','Смартфоны','Набережная 8','Харьков','0632443050','techCompany@gmail.com', 1),
('LG Electronics ','Холодильники','Мечникова 2а','Киев','0962475077','lg_electronics@gmail.com', 1)
GO

INSERT INTO Customers
VALUES
('Никонов К. В.','Баррикадная 15а','Днепр','0952296070','Nikonov55@yandex.ua', 2),
('Шевченко В. С.','Супруна 7б','Сумы','0992907029','Sheva2021@gmail.com', 2)
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
('Александр', 'Пушкин', 37),
('Сергей', 'Есенин', 30),
('Джек', 'Лондон', 40),
('Шота', 'Руставели', 44),
('Рабиндрант', 'Тагор', 80)
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
('Руслан и Людмила', 1),
('Кавказкий пленник', 1),
('Евгений Онегин', 1),
('Радуница', 2),
('Преображение', 2),
('Мартин Иден', 3),
('Морской Волк', 3),
('Белый Клык', 3)
GO

SELECT * FROM Authors
SELECT * FROM Books
GO