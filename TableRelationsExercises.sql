-- PROBLEM 1
CREATE DATABASE [PasportRecords];

USE [PasportRecords];

CREATE TABLE [Passports](
        [PassportId] INT PRIMARY KEY IDENTITY (101, 1) NOT NULL,
        [PassportNumber] NVARCHAR(8) NOT NULL 
);

DROP TABLE [Persons]
DROP TABLE [Passports]
CREATE TABLE [Persons](
    [PersonId] INT PRIMARY KEY IDENTITY,
    [FirstName] NVARCHAR(50) NOT NULL,
    [Salary] DECIMAL(7, 2),
    [PassportId] INT FOREIGN KEY REFERENCES [Passports]([PassportId]) UNIQUE
);

INSERT INTO [Passports]([PassportNumber])
VALUES
		('N34FG21B'),
		('K65LO4R7'),
		('ZE657QP2');

SELECT * FROM [Passports]

INSERT INTO [Persons]([FirstName], [Salary], [PassportId])
VALUES 
		('Roberto', 43300.00, 102),
		('Tom', 56100.00, 103),
		('Yana', 60200.00, 101)

SELECT * FROM [Persons]

-- PROBLEM 2

CREATE DATABASE [Cars];

USE [Cars];

CREATE TABLE [Manufacturers] (
	[ManufacturerID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[EstablishedOn] DATE
	
);

CREATE TABLE [Models] (
	[ModelID] INT PRIMARY KEY IDENTITY(101, 1),
	[Name] NVARCHAR(50) NOT NULL,
	[ManufacturerID] INT FOREIGN KEY REFERENCES [Manufacturers]([ManufacturerID])
)

INSERT INTO [Manufacturers]([Name], [EstablishedOn])
	VALUES
			('BMW', '07/03/1916'),
			('Tesla', '01/01/2003'),
			('Lada', '01/05/1966')

SELECT * FROM [Manufacturers]

INSERT INTO [Models]([Name], [ManufacturerID])
	VALUES
			('X1', 1),
			('i6', 1),
			('Model S', 2),
			('Model X', 2),
			('Model 3', 2),
			('Nova', 3)

SELECT * FROM [Models]

--PROBLEM 3

CREATE DATABASE [School];

USE [School];

CREATE TABLE [Students](
	[StudentID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
);

CREATE TABLE [Exams](
	[ExamID] INT PRIMARY KEY IDENTITY(101, 1),
	[Name] NVARCHAR(50) NOT NULL
);

CREATE TABLE [StudentsExams](

	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]),
	[ExamID] INT FOREIGN KEY REFERENCES [Exams]([ExamID]),
	PRIMARY KEY([StudentID], [ExamID])
	
)



INSERT INTO [Students]([Name])
	VALUES
			('Mila'),
			('Toni'),
			('Ron');

INSERT INTO [Exams]([Name])
	VALUES	
			('SpringMVC'),
			('Neo4j'),
			('Oracle 11g')

INSERT INTO [StudentsExams]([StudentID], [ExamID])
	VALUES
			(1, 101),
			(1, 102),
			(2, 101),
			(3, 103),
			(2, 102),
			(2, 103);

SELECT * FROM [Students]
SELECT * FROM [Exams]
SELECT * FROM [StudentsExams]

CREATE TABLE Teachers(

	[TeacherID] INT PRIMARY KEY IDENTITY(101, 1),
	[Name] NVARCHAR(50) NOT NULL,
	[ManagerID] INT FOREIGN KEY REFERENCES [Teachers]([TeacherID])
	
);

INSERT INTO [Teachers]([Name], [ManagerID])
	VALUES
			('John', NULL),
			('Maya', 106),
			('Silvia', 106),
			('Ted', 105),
			('Mark', 101),
			('Greta', 101);

--PROBLEM 5

CREATE DATABASE [OnlineStoreDatabase];

USE [OnlineStoreDatabase];

CREATE TABLE [Cities](
	[CityID] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
);

CREATE TABLE [Customers](
	[CustomerID] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	[Birthday] DATE,
	[CityID] INT FOREIGN KEY REFERENCES [Cities]([CityID])
);

CREATE TABLE [Orders](
	[OrderID] INT PRIMARY KEY IDENTITY,
	[CustomerID] INT FOREIGN KEY REFERENCES [Customers]([CustomerID])
);

CREATE TABLE [ItemsTypes](
	[ItemTypeID] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,

);

CREATE TABLE [Items](
	[ItemID] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	[ItemTypeID] INT FOREIGN KEY REFERENCES [ItemsTypes]([ItemTypeID])
);

CREATE TABLE [OrderItems](
	[OrderID] INT FOREIGN KEY REFERENCES [Orders]([OrderID]),
	[ItemsID] INT FOREIGN KEY REFERENCES [Items]([ItemId])
);

-- PROBLEM 6

CREATE DATABASE [University];

USE [University];

CREATE TABLE [Majors](
	[MajorID] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
);

CREATE TABLE [Students](
	[StudentID] INT PRIMARY KEY IDENTITY,
	[StudentNumber] VARCHAR(10) NOT NULL,
	[StudentName] VARCHAR(50) NOT NULL,
	[MajorID] INT FOREIGN KEY REFERENCES [Majors]([MajorID])
);

CREATE TABLE [Payments](
	[PaymentID] INT PRIMARY KEY IDENTITY,
	[PaymentDate] Date,
	[PaymentAmount] DECIMAL(7, 2),
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID])

);

CREATE TABLE [Subjects](
	[SubjectID] INT PRIMARY KEY IDENTITY,
	[SubjectName] VARCHAR(50) NOT NULL,
);

CREATE TABLE [Agenda](
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]),
	[SubjectID] INT FOREIGN KEY REFERENCES [Subjects]([SubjectID])
);

--PROBLEM 7

USE [SoftUni];

SELECT * FROM [Addresses]
SELECT * FROM [Departments]
SELECT * FROM [Employees]
SELECT * FROM [EmployeesProjects]
SELECT * FROM [Projects]
SELECT * FROM [Towns]

--PROBLEM 8

USE [Geography];

SELECT * FROM [Continents];
SELECT * FROM [Countries];
SELECT * FROM [CountriesRivers];
SELECT * FROM [Currencies];
SELECT * FROM [Mountains];
SELECT * FROM [MountainsCountries];
SELECT * FROM [Peaks];
SELECT * FROM [Rivers];

--PROBLEM 9

SELECT m.[MountainRange], p.[PeakName], p.[Elevation] FROM [Mountains] AS m
JOIN [Peaks] AS p ON p.MountainId = m.Id
WHERE m.[MountainRange] = 'Rila'
ORDER BY p.[Elevation] DESC