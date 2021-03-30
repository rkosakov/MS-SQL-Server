USE [SoftUni]

--PROBELM 1

SELECT TOP (5) e.[EmployeeID], e.[JobTitle], a.[AddressID], a.[AddressText] FROM [Employees] AS e
JOIN [Addresses] AS a ON e.[AddressID] = a.AddressID
ORDER BY a.[AddressID]

--PROBLEM 2

SELECT TOP (50) e.[FirstName], e.[LastName], t.[Name] AS [Town], a.[AddressText] FROM [Employees] AS e
JOIN [Addresses] AS a ON e.[AddressID] = a.[AddressID]
JOIN [Towns] AS t ON a.[TownID] = t.[TownID]
ORDER BY e.[FirstName], e.[LastName]

--PROBLEM 3

SELECT e.[EmployeeID], e.[FirstName], e.[LastName], d.[Name] AS [DepartmentName] FROM [Employees] AS e
JOIN [Departments] AS d ON e.[DepartmentID] = d.[DepartmentID]
WHERE d.[Name] = 'Sales'
ORDER BY e.[EmployeeID]

--PROBLEM 4

SELECT TOP (5) e.[EmployeeID], e.[FirstName], e.[Salary], d.[Name] AS [DepartmentName] FROM [Employees] AS e
JOIN [Departments] AS d ON e.[DepartmentID] = d.[DepartmentID]
WHERE e.[Salary] > 15000
ORDER BY d.[DepartmentID]

--PROBLEM 5

SELECT TOP (3) e.[EmployeeID], e.[FirstName] FROM [Employees] AS e
LEFT JOIN [EmployeesProjects] AS ep ON e.[EmployeeID] = ep.[EmployeeID]
WHERE ep.[EmployeeID] IS NULL
ORDER BY e.[EmployeeID]

--PROBLEM 6

SELECT e.[FirstName], e.[LastName], e.[HireDate], d.[Name]  AS [DeptName] FROM [Employees] AS e
JOIN [Departments] AS d ON e.[DepartmentID] = d.[DepartmentID]
WHERE e.[HireDate] > '1-1-1999' AND d.[Name] IN('Sales', 'Finance')
ORDER BY e.[HireDate]

--PROBLEM 7

SELECT TOP (5) e.[EmployeeID], e.[FirstName], p.[Name] AS [ProjectName] FROM [Employees] AS e
JOIN [EmployeesProjects] AS ep ON e.[EmployeeID] = ep.[EmployeeID]
JOIN [Projects] AS p ON ep.[ProjectID] = p.[ProjectID]
WHERE p.[StartDate] > '08-13-2002' AND p.[EndDate] IS NULL
ORDER BY e.[EmployeeID]

--PROBLEM 8

SELECT 
e.[EmployeeID],
e.[FirstName],
CASE 
WHEN DATEPART(YEAR, p.[StartDate]) >= 2005
THEN NULL
ELSE p.[Name]
END AS [ProjectName]
FROM [Employees] AS e
JOIN [EmployeesProjects] AS ep ON e.[EmployeeID] = ep.[EmployeeID]
JOIN [Projects] AS p ON ep.[ProjectID] = p.[ProjectID]
WHERE e.[EmployeeID] = 24

--PROBLEM 9

SELECT e.[EmployeeID], e.[FirstName], e.[ManagerID], m.[FirstName] AS [ManagerName] FROM [Employees] AS e
JOIN [Employees] AS m ON e.[EmployeeID] = m.[ManagerID]
WHERE m.[ManagerID] IN(3, 7)
ORDER BY e.[EmployeeID]

--PROBLEM 10

SELECT TOP (50)
e.[EmployeeID],
CONCAT(e.[FirstName], ' ', e.[LastName]) AS [EmployeeName],
CONCAT(m.[FirstName], ' ', m.[LastName]) AS [ManagerName],
d.[Name] AS [DepartmentName]
FROM [Employees] AS e
JOIN [Employees] AS m ON e.[ManagerID] = m.[EmployeeID]
JOIN [Departments] AS d ON e.[DepartmentID] = d.[DepartmentID]
ORDER BY e.[EmployeeID]

--PROBLEM 11

SELECT MIN([avg]) FROM
	(SELECT AVG([Salary]) AS [avg] FROM [Employees]
	GROUP BY [DepartmentID]) AS [Average Salary]

USE [Geography]

--PROBLEM 12

SELECT c.[CountryCode], m.[MountainRange], p.[PeakName], p.[Elevation]  FROM [MountainsCountries] AS mc
JOIN [Countries] AS c ON mc.CountryCode = c.CountryCode
JOIN [Mountains] AS m ON mc.[MountainId] = m.[Id]
JOIN [Peaks] AS p ON m.[Id] = p.[MountainId]
WHERE p.[Elevation] > 2835 AND c.[CountryCode] = 'BG'
ORDER BY p.[Elevation] DESC

--PROBLEM 13

SELECT c.[CountryCode], COUNT(m.MountainRange) AS [MountainRanges] FROM [MountainsCountries] AS mc
JOIN [Countries] AS c ON mc.[CountryCode] = c.[CountryCode]
JOIN [Mountains] AS m ON mc.[MountainId] = m.[Id]
WHERE c.[CountryCode] IN('BG', 'US', 'RU')
GROUP BY c.[CountryCode]

--PROBLEM 14

SELECT TOP(5) c.[CountryName], r.[RiverName] FROM [Countries] AS c
JOIN [Continents] AS con ON con.[ContinentCode] = c.[ContinentCode]
LEFT JOIN [CountriesRivers] AS cr ON c.[CountryCode] = cr.[CountryCode]
LEFT JOIN [Rivers] AS r ON cr.[RiverId] = r.[Id]
WHERE con.[ContinentName] = 'Africa' 
ORDER BY c.[CountryName] ASC

--PROBLEM 15

SELECT [OrderedCurrencies].[ContinentCode],
       [OrderedCurrencies].[CurrencyCode],
	   [OrderedCurrencies].[CurrencyUsage]
FROM [Continents] AS c
JOIN(
SELECT [ContinentCode] AS [ContinentCode],
	   COUNT([CurrencyCode]) AS [CurrencyUsage],
	   [CurrencyCode] AS [CurrencyCode],
	   DENSE_RANK() OVER (PARTITION BY [ContinentCode] ORDER BY COUNT(CurrencyCode) DESC) AS [Rank]
FROM [Countries]
GROUP BY [ContinentCode], [CurrencyCode]
HAVING COUNT([CurrencyCode]) > 1
) AS [OrderedCurrencies]
ON c.[ContinentCode] = [OrderedCurrencies].ContinentCode
WHERE [OrderedCurrencies].[Rank] = 1

--PROBLEM 16

SELECT COUNT(*) AS [CountryCode]
FROM (
	SELECT mc.[CountryCode]
	FROM [Countries] AS c
	LEFT JOIN MountainsCountries AS mc ON c.[CountryCode] = mc.[CountryCode]
	WHERE mc.CountryCode IS NULL
) AS [CountriesWithoutMontains]

--PROBLEM 17

SELECT TOP(5) c.[CountryName], 
MAX(p.[Elevation]) AS [HighestPeakElevation], 
MAX(r.[Length]) AS [LongestRiverLength]
FROM [Countries] AS c
LEFT JOIN [MountainsCountries] AS mc ON c.[CountryCode] = mc.[CountryCode]
LEFT JOIN [Mountains] AS m ON mc.[MountainId] = m.[Id]
LEFT JOIN [Peaks] AS p ON m.[Id] = p.[MountainId]
LEFT JOIN [CountriesRivers] AS cr ON c.[CountryCode] = cr.[CountryCode]
LEFT JOIN [Rivers] AS r ON cr.[RiverId] = r.[Id] 
GROUP BY c.[CountryName]
ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, c.[CountryName] ASC

--PROBLEM 18

SELECT [Country], 
	   CASE
		WHEN [PeakName] IS NULL
		THEN 'no highest peak'
		ELSE [PeakName]
		END AS [Highest Peak Name], 
	   CASE 
		WHEN [Elevation] IS NULL
		THEN 0
		ELSE [Elevation]
		END AS [Highest Highest Peak Elevation],
	    CASE 
		WHEN [MountainRange] IS NULL 
		THEN 'no mountain'
		ELSE [MountainRange]
		END AS [Mountain]
		FROM ( SELECT *,
	   DENSE_RANK() OVER (PARTITION BY [Country] ORDER BY [Elevation] DESC) AS [PeakRank]
FROM (
	SELECT [CountryName] AS [Country],
		   p.[PeakName],
		   p.[Elevation],
		   m.[MountainRange]
	FROM [Countries] AS c
	LEFT JOIN [MountainsCountries] AS moncont 
	ON c.[CountryCode] = moncont.[CountryCode]
	LEFT JOIN [Mountains] AS m 
	ON moncont.[CountryCode] = m.[Id]
	LEFT JOIN [Peaks] AS p 
	ON p.[MountainId] = m.[Id]
			  ) AS [FullInfoQueiry]
			  ) AS [PeaksRankingQuery]
WHERE [PeakRank] = 1 
ORDER BY [Country] ASC, [Highest Highest Peak Elevation] ASC