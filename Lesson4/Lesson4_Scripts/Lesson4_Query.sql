--ADDITIONAL TASK (Normalize DB from lesson3)
USE HRDepartmentDB
GO

SELECT * FROM Department
SELECT * FROM Employee
SELECT * FROM HoursWorkedLastMonth
SELECT * FROM Position
SELECT * FROM Task
GO

--Таблицы базы данных HRDepartmentDB не требуют нормализации, так как они уже нормализованы до 3NF

--TASK2
CREATE DATABASE MilitaryDepartmentDB
ON
(
	NAME = 'MilitaryDepartmentDB',
	FILENAME = 'F:\DB\MilitaryDepartmentDB.mdf',
	SIZE = 30MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME = 'LogMilitaryDepartmentDB',
	FILENAME = 'E:\Logs\MilitaryDepartmentDB.ldf',
	SIZE = 5MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)
COLLATE Cyrillic_General_CI_AS

USE MilitaryDepartmentDB
GO

CREATE TABLE WeaponsAccountingInfo
(
	ID smallint IDENTITY NOT NULL PRIMARY KEY,
	[Name] varchar(50) NOT NULL,
	Platoon smallint NOT NULL,
	Weapon varchar(20) NOT NULL,
	MilitaryProvider varchar(50) NOT NULL,
)
GO

INSERT INTO WeaponsAccountingInfo
VALUES
('Петров В. А., оф.205', 222, 'АК-47', 'Буров О.С., майор'),
('Петров В. А., оф.205', 222, 'Глок20', 'Рыбаков Н.Г., майор'),
('Лодарев П. С., оф.221', 232, 'АК-47', 'Деребанов В. Я., подполковник'),
('Лодарев П. С., оф.221', 232, 'Глок20', 'Рыбаков Н.Г., майор'),
('Леонтьев К. В., оф.201', 212, 'АК-47', 'Буров О.С., майор'),
('Леонтьев К. В., оф.201', 212, 'Глок20', 'Рыбаков Н.Г., майор'),
('Духов Р. М.', 200, 'АК-47', 'Буров О.С., майор')
GO

SELECT * FROM WeaponsAccountingInfo
GO

CREATE TABLE Soldier
(
	SoldierID smallint IDENTITY NOT NULL PRIMARY KEY,
	[Name] varchar(20) NOT NULL,
	[OFF] varchar(10),
	Platoon smallint NOT NULL
)
GO

CREATE TABLE WeaponProvider
(
	WeaponProviderID smallint IDENTITY NOT NULL PRIMARY KEY,
	[Name] varchar(20) NOT NULL,
	[RankID] varchar(15) NOT NULL 
)

CREATE TABLE Weapon
(
	WeaponID smallint IDENTITY NOT NULL PRIMARY KEY,
	Name varchar(20) NOT NULL UNIQUE
)

CREATE TABLE WeaponsAccounting
(
	ID smallint IDENTITY NOT NULL PRIMARY KEY,
	SoldierID smallint NOT NULL FOREIGN KEY REFERENCES Soldier(SoldierID),
	WeaponID smallint NOT NULL FOREIGN KEY REFERENCES  Weapon(WeaponID),
	WeaponProviderID smallint NOT NULL FOREIGN KEY REFERENCES WeaponProvider(WeaponProviderID)
)
GO

INSERT INTO Soldier
VALUES
('Петров В. А.', '205', 222),
('Лодарев П. С.', '221', 232),
('Леонтьев К. В.', '201', 212),
('Духов Р. М.', NULL, 200)
GO

INSERT INTO WeaponProvider
VALUES
('Буров О.С.','майор'),
('Рыбаков Н.Г.','майор'),
('Деребанов В. Я.', 'подполковник')
GO

INSERT INTO Weapon
VALUES
('AK-47'),
('Глок-20')
GO

INSERT INTO WeaponsAccounting
(SoldierID, WeaponID, WeaponProviderID)
VALUES
(1,1,1),
(1,2,2),
(2,1,3),
(2,2,2),
(3,1,1),
(3,2,2),
(4,1,1)
GO

SELECT * FROM WeaponsAccountingInfo
SELECT * FROM Soldier
SELECT * FROM WeaponProvider
SELECT * FROM Weapon
SELECT * FROM WeaponsAccounting
GO