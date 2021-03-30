USE [SoftUni];

--PROBLEM 1

SELECT [FirstName], [LastName] FROM [Employees]
WHERE [FirstName] LIKE 'Sa%';

--PROBLEM 2

SELECT [FirstName], [LastName] FROM [Employees]
WHERE [LastName] LIKE '%ei%';

--PROBLEM 3

SELECT [FirstName] FROM [Employees]
WHERE ([DepartmentID] = 3 OR [DepartmentID] = 10) AND DATEPART(YEAR, [HireDate]) BETWEEN 1995 AND 2005;

--PROBLEM 4

SELECT [FirstName], [LastName] FROM [Employees]
WHERE [JobTitle] NOT LIKE '%engineer%';

--PROBLEM 5

SELECT [Name] FROM [Towns]
WHERE LEN([Name]) = 5 OR LEN([Name]) = 6
ORDER BY [NAME];

--PROBLEM 6

SELECT * FROM [Towns]
WHERE LEFT([Name], 1) LIKE '[MKBE]'
ORDER BY [Name];

--PROBLEM 7

SELECT * FROM [Towns]
WHERE LEFT([Name], 1) NOT LIKE '[RBD]'
ORDER BY [Name];

GO
--PROBLEM 8

CREATE VIEW V_EmployeesHiredAfter2000 
AS
	SELECT [FirstName], [LastName] FROM [Employees]
	WHERE DATEPART(YEAR, [HireDate]) > 2000;

GO

SELECT * FROM [V_EmployeesHiredAfter2000]

--PROBLEM 9

SELECT [FirstName], [LastName] FROM [Employees]
WHERE LEN([LastName]) = 5

--PROBLEM 10

SELECT [EmployeeID], [FirstName], [LastName], [Salary], 
	DENSE_RANK() 
	OVER (PARTITION BY [Salary] ORDER BY [EmployeeId]) AS [Rank]
FROM [Employees]
WHERE [Salary] BETWEEN 10000 AND 50000
ORDER BY [Salary] DESC

--PROBLEM 11

SELECT * FROM (SELECT [EmployeeID], [FirstName], [LastName], [Salary], 
	DENSE_RANK() 
	OVER (PARTITION BY [Salary] ORDER BY [EmployeeId]) AS [Rank]
FROM [Employees]
WHERE [Salary] BETWEEN 10000 AND 50000) AS [Rank Table]
WHERE [Rank] = 2
ORDER BY [Salary] DESC

USE [Geography]

--PROBLEM 12

SELECT [CountryName], [IsoCode] FROM [Countries]
WHERE [CountryName] LIKE '%a%a%a%'
ORDER BY [IsoCode]

--PROBLEM 13

SELECT [Peaks].[PeakName], 
	   [Rivers].[RiverName], 
	   LOWER(CONCAT(LEFT([Peaks].[PeakName], LEN([Peaks].[PeakName]) - 1), [Rivers].[RiverName])) AS [Mix]
FROM [Peaks]
	JOIN [Rivers] ON RIGHT([Peaks].[PeakName], 1) = LEFT([Rivers].[RiverName], 1)
ORDER BY [Mix]

USE [Diablo]

--PROBLEM 14

SELECT TOP 50 [Name], 
FORMAT(CAST([Start] AS DATE), 'yyyy-MM-dd') AS [Start]
FROM [Games]
WHERE DATEPART(YEAR, [Start]) BETWEEN 2011 AND 2012
ORDER BY [Start], [Name]

--PROBLEM 15

SELECT [Username],
RIGHT([Email], LEN([Email]) - CHARINDEX('@', [Email])) AS [Email Provider]
FROM [Users]
ORDER BY [Email Provider], [Username]

--PROBLEM 16

SELECT [Username], [IpAddress] FROM [Users]
WHERE [IpAddress] LIKE '___.1_%._%.___'
ORDER BY [Username] 

--PROBLEM 17

SELECT [Name], 
	CASE 
		WHEN DATEPART(HOUR, START) BETWEEN 0 AND 11
		THEN 'Morning'
		WHEN DATEPART(HOUR, START) BETWEEN 12 AND 17
		THEN 'Afternoon'
		WHEN DATEPART(HOUR, START) BETWEEN 18 AND 23
		THEN 'Evening'
		ELSE 'Error'
	END AS [Part of the Day],
	CASE	
		WHEN [Duration] <= 3
		THEN 'Extra Short'
		WHEN [Duration] BETWEEN 4 AND 6
		THEN 'Short'
		WHEN [Duration] > 6
		THEN 'Long'
		WHEN [Duration] IS NULL
		THEN 'Extra Long'
		ELSE 'Error'
		END AS [Duration]
FROM [Games]
ORDER BY [Name], [Duration], [Part of the Day]

USE [Orders]

--PROBLEM 18

SELECT [ProductName],
	   [OrderDate],
	   DATEADD(DAY, 3, [OrderDate]) AS [Pay Due],
	   DATEADD(MONTH, 1, [OrderDate]) AS [Deliver Due]
FROM [Orders]

--PROBLEM 19

CREATE TABLE [People](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[Birthdate] DATETIME2 NOT NULL
)

INSERT INTO [People]([Name], [Birthdate])
VALUES
		('Victor', '2000-12-07 00:00:00.000'),
		('Steven', '1992-09-10 00:00:00.000'),
		('Stephen', '1910-09-19 00:00:00.000'),
		('John', '2010-01-06 00:00:00.000')

SELECT [Name],
	   DATEDIFF(YEAR, [Birthdate], GETDATE()) AS [Age in Years],
	   DATEDIFF(MONTH, [Birthdate], GETDATE()) AS [Age in Months],
	   DATEDIFF(DAY, [Birthdate], GETDATE()) AS [Age in Days],
	   DATEDIFF(MINUTE, [Birthdate], GETDATE()) AS [Age in Minutes]
FROM [People]

DROP TABLE [People]
