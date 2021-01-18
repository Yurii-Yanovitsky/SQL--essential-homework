--ADDITIONAL TASK
CREATE DATABASE EmptyDB
ON
(
	NAME = 'EmptyDB',
	FILENAME = 'F:\DB\EmptyDB.mdf',
	SIZE = 10MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME = 'LogEmptyDB',
	FILENAME = 'F:\DB\EmptyDB.ldf',
	SIZE = 5MB,
	MAXSIZE = 50MB
)
COLLATE Cyrillic_General_CI_AS

--TASK2
CREATE DATABASE MyDB
ON
(
	NAME = 'MyDB',
	FILENAME = 'F:\DB\MyDB.mdf',
	SIZE = 10MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME = 'LogMyDB',
	FILENAME = 'F:\DB\MyDB.ldf',
	SIZE = 5MB,
	MAXSIZE = 50MB
)
COLLATE Cyrillic_General_CI_AS

--TASK3
USE MyDB
GO

CREATE TABLE EmployeeNamesAndPhoneNumbers
(
	FirstName Varchar(20),
	LastName Varchar(20),
	PhoneNumber char(10),
)
GO

CREATE TABLE EmployeeNamesAndPhoneNumbers
(
	FirstName Varchar(20),
	LastName Varchar(20),
	PhoneNumber char(10),
)
GO

CREATE TABLE EmployeeSalaryAndPosition
(
	Salary Money,
	Position Varchar(20),
)
GO

CREATE TABLE EmployeeInfo
(
	MaritalStatus  Varchar(20),
	BirthDate Date,
	Residence Varchar(20)
)
GO