-- TASK2
USE MyJoinsDB
GO

SELECT	i.object_id, t.name, index_id, i.type_desc FROM sys.indexes as i
join sys.tables as t
ON i.object_id = t.object_id
GO

-- Employee - ���������������� ������� (������������ ���������������� ������)
-- Post - ���������������� ������� (������������ ���������������� ������)
-- EmployeeInfo - ���� (������������ Index Allocation Map). ����� ������� ������������������ ������

--TASK3
SET STATISTICS TIME OFF

SELECT * FROM Employee
SELECT * FROM Post
SELECT * FROM EmployeeInfo

--�������� ���������� ������ ��� ������� EmployeeInfo �� ���� EmployeeID ��� �������������� ������ 
CREATE CLUSTERED INDEX IX_CL_EmployeeInfo_ID
ON EmployeeInfo(EmployeeID)
GO

--������� Employee � EmployeeInfo �������� �����������, ��� ��� ������������� ���������������� ������ �� ���������.
--������� �������������� �������� �� ���������, ��� ��� ������ ������ ���������

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
WHERE ei.MaritalStatus = '�� �����'
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
WHERE p.Post = '��������'
GO

SELECT * FROM ManagerInfo
GO