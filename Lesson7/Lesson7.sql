-- TASK2
USE MyJoinsDB
GO

SELECT	i.object_id, t.name, index_id, i.type_desc FROM sys.indexes as i
join sys.tables as t
ON i.object_id = t.object_id
GO

-- Employee - кластеризованная таблица (используется кластеризованный индекс)
-- Post - кластеризованная таблица (используется кластеризованный индекс)
-- EmployeeInfo - Куча (используется Index Allocation Map). Далее добавим некластеризованный индекс

--TASK3
SET STATISTICS TIME OFF

SELECT * FROM Employee
SELECT * FROM Post
SELECT * FROM EmployeeInfo

--Создадим кластерный индекс для таблицы EmployeeInfo по полю EmployeeID для упорядочивания данных 
CREATE CLUSTERED INDEX IX_CL_EmployeeInfo_ID
ON EmployeeInfo(EmployeeID)
GO

--Таблицы Employee и EmployeeInfo являются кластерными, так как реализовывают кластеризованный индекс по умолчанию.
--Никаких дополнительных индексов не требуется, так как размер таблиц небольшой

--TASK4

--1)
CREATE VIEW ContactInfo
AS SELECT e.[Name], e.Phone, ei.City, ei.[Address] FROM Employee AS e
JOIN EmployeeInfo AS ei
ON
e.EmployeeID = ei.EmployeeID
GO

SELECT * FROM ContactInfo
GO

--2)
CREATE VIEW UnmarriedEmployeeInfo
AS SELECT e.[Name], ei.BirthDate, e.Phone FROM Employee AS e
JOIN EmployeeInfo AS ei
ON
e.EmployeeID = ei.EmployeeID
WHERE ei.MaritalStatus = 'не женат'
GO

SELECT * FROM UnmarriedEmployeeInfo
GO

--3)
CREATE VIEW ManagerInfo
AS SELECT e.[Name], ei.BirthDate, e.Phone FROM Employee AS e
JOIN EmployeeInfo AS ei
ON e.EmployeeID = ei.EmployeeID
JOIN Post AS p
ON e.EmployeeID = p.EmployeeID
WHERE p.Post = 'менеджер'
GO

SELECT * FROM ManagerInfo
GO