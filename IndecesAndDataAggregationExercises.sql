USE [Gringotts]

--PROBLEM 1

SELECT COUNT(*) AS [Count] FROM [WizzardDeposits]

--PROBLEM 2

SELECT MAX([MagicWandSize]) AS [LongestMagicWand] FROM [WizzardDeposits]

--PROBLEM 3

SELECT [DepositGroup], MAX([MagicWandSize]) AS [LongestMagicWand] FROM [WizzardDeposits]
GROUP BY [DepositGroup]

--PROBLEM 4

SELECT TOP(2) [DepositGroup] FROM [WizzardDeposits]
GROUP BY [DepositGroup]
ORDER BY AVG([MagicWandSize])

--PROBLEM 5

SELECT [DepositGroup], SUM([DepositAmount]) AS [TotalSum] FROM [WizzardDeposits]
GROUP BY [DepositGroup]

--PROBLEM 6

SELECT [DepositGroup], SUM([DepositAmount]) AS TotalSum FROM [WizzardDeposits]
WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]

--PROBLEM 7

SELECT [DepositGroup], SUM([DepositAmount]) AS [TotalSum] FROM [WizzardDeposits]
WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]
HAVING SUM([DepositAmount]) < 150000
ORDER BY [TotalSum] DESC

--PROBLEM 8

SELECT [DepositGroup], [MagicWandCreator], Min([DepositCharge]) AS [MinDepositCharge] FROM [WizzardDeposits]
GROUP BY [DepositGroup], [MagicWandCreator]
ORDER BY [MagicWandCreator], [DepositGroup]

--PROBLEM 9

SELECT *, COUNT(*) AS [WizardCount] FROM
(SELECT 
CASE
 WHEN [Age] between 0 and 10 THEN '[0-10]'
 WHEN [Age] between 11 and 20 THEN '[11-20]'
 WHEN [Age] between 21 and 30 THEN '[21-30]'
 WHEN [Age] between 31 and 40 THEN '[31-40]'
 WHEN [Age] between 41 and 50 THEN '[41-50]'
 WHEN [Age] between 51 and 60 THEN '[51-60]'
 ELSE '[61+]'
 END AS [AgeGroup]
FROM [WizzardDeposits]
) AS [a]
GROUP BY [AgeGroup]
ORDER BY [AgeGroup]

--PROBLEM 10

SELECT LEFT([FirstName], 1) AS [FirstLetter] FROM [WizzardDeposits]
WHERE [DepositGroup] = 'Troll Chest'
GROUP BY LEFT([FirstName], 1)

--PROBLEM 11

SELECT [DepositGroup], [IsDepositExpired], AVG([DepositInterest]) AS [AverageInterest] FROM [WizzardDeposits]
WHERE DATEPART(YEAR, [DepositStartDate]) >= 1985
GROUP BY [DepositGroup], [IsDepositExpired]
ORDER BY [DepositGroup] DESC, [IsDepositExpired]

--PROBLEM 12

SELECT SUM([Difference]) FROM
	(SELECT 
		Wiz1.[FirstName] AS [Host Wizard],
		Wiz1.[DepositAmount] AS [Host Wizard Deposit],
		Wiz2.[FirstName] AS [Guest Wizard],
		Wiz2.[DepositAmount] AS [Guest Wizard Deposit],
		Wiz1.DepositAmount - Wiz2.DepositAmount AS [Difference]
	FROM [WizzardDeposits] AS [Wiz1]
	JOIN [WizzardDeposits] AS [Wiz2] ON Wiz1.[Id] = Wiz2.Id - 1) AS a

USE [SoftUni]

--PROBLEM 13

SELECT [DepartmentId], SUM([Salary]) AS [TotalSalary] FROM [Employees]
GROUP BY [DepartmentID]
ORDER BY [DepartmentID]

--PROBLEM 14

SELECT [DepartmentID], MIN([Salary]) FROM [Employees]
WHERE DATEPART(YEAR, [HireDate]) >= 2000
GROUP BY [DepartmentID]
HAVING [DepartmentID] IN (2, 5, 7)

--PROBLEM 15

SELECT * INTO [EmployeesWithHigherSalaries] FROM [Employees]
WHERE [Salary] > 30000

DELETE FROM [EmployeesWithHigherSalaries]
WHERE [ManagerID] = 42

UPDATE [EmployeesWithHigherSalaries]
SET [Salary] += 5000
WHERE [DepartmentID] = 1

SELECT [DepartmentID], AVG([Salary]) AS [AverageSalary] FROM [EmployeesWithHigherSalaries]
GROUP BY [DepartmentID]
ORDER BY [DepartmentID]

--PROBLEM 16

SELECT [DepartmentID], MAX([Salary]) AS [MaxSalary] FROM [Employees]
GROUP BY [DepartmentID]
HAVING MAX([Salary]) NOT BETWEEN 30000 AND 70000

--PROBLEM 17

SELECT COUNT(*) AS [Count] FROM [Employees]
WHERE [ManagerID] IS NULL

--PROBLEM 18

SELECT [DepartmentID], [Salary] AS [ThirdHighestSalary] FROM (
SELECT [DepartmentID], [Salary], DENSE_RANK() OVER (PARTITION BY [DepartmentID] ORDER BY [SALARY] DESC) AS [SalaryRank]
FROM [Employees]) AS [SalaryRankingsQuery]
	WHERE [SalaryRank] = 3
	GROUP BY [DepartmentID], [Salary]

--PROBLEM 19

SELECT TOP (10) [FirstName], [LastName], [DepartmentID] FROM [Employees] AS e
WHERE [Salary] > ( SELECT AVG([Salary]) FROM [Employees] AS e2
				   WHERE e.[DepartmentID] = e2.[DepartmentID] 
				 )
ORDER BY [DepartmentID]




