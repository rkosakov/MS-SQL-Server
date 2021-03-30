CREATE DATABASE [Minions]

USE [Minions] 

CREATE TABLE [Minions](
	[Id] INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	[Age] TINYINT
)

CREATE TABLE [Towns](
	[Id] INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)

ALTER TABLE [Minions]
ADD TownId INT FOREIGN KEY REFERENCES Towns(Id)

INSERT INTO [Towns] ([Id], [Name])
	VALUES
			(1, 'Sofia'),
			(2, 'Plovdiv'),
			(3, 'Varna')

SELECT [Id], [Name] FROM Towns

SELECT * FROM Towns

SELECT * FROM Minions

INSERT INTO [Minions] ([Id], [Name], [Age], [TownId])
	VALUES
			(1, 'Kevin', 22, 1),
			(2, 'Bob', 15, 3),
			(3, 'Steward', NULL, 2) 

TRUNCATE TABLE Minions
DROP TABLE Minions
DROP TABLE Towns

DROP DATABASE Minions

CREATE TABLE [People] (
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(200) NOT NULL,
	[Picture] VARBINARY(MAX),
	[Height] DECIMAL(5,2),
	[Weight] DECIMAL(5,2),
	[Gender] CHAR(1) NOT NULL
	CHECK (Gender = 'm' Or Gender = 'f'),
	[Birthday] DATE NOT NULL,
	[Biography] NVARCHAR(MAX)
)

SELECT * FROM [People]

INSERT INTO [People] ([Name], [Height], [Weight], [Gender], [Birthday])
	Values
			('John', 175.87, 68.98, 'm', '07-08-1999'),
			('Jane', 168.00, 59.00, 'f', '06-05-1989'),
			('Jim', 185.00, 78.00, 'm', '07-24-1967'),
			('Jorge', 199.00, 91.00, 'm', '12-23-1971'),
			('Sid', 156.00, 61.00, 'm', '11-11-1967')

CREATE TABLE [Users] (
	[Id] BIGINT PRIMARY KEY IDENTITY NOT NULL,
	[Username] VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	[ProfilePicture] VARBINARY(MAX)
	CHECK(DATALENGTH([ProfilePicture]) <= 900 * 1024),
	[LastLoginTime] DATETIME2 NOT NULL,
	[IsDeleted] BIT NOT NULL
)

SELECT * FROM [Users]

INSERT INTO [Users] ([Username], [Password], [LastLoginTime], [IsDeleted])
	Values
			('John', 12345, '07-08-1999', 0),
			('John1', 12345, '07-08-1999', 1),
			('John2', 12345, '07-08-1999', 0),
			('John3', 12345, '07-08-1999', 1),
			('John4', 12345, '07-08-1999', 0)

Alter TABLE [Users]
Drop CONSTRAINT [PK__Users__3214EC07912A6A1A]

ALTER TABLE [Users]
ADD CONSTRAINT [PK_Users_CompositeIdUsername]
PRIMARY KEY(Id, Username)

ALTER TABLE Users
ADD CONSTRAINT [CK_Users_Password_Length]
CHECK(LEN([Password]) >= 5)

Alter TABLE [Users]
DROP CONSTRAINT [Ck_Users_Password_Length]

ALTER TABLE [Users]
ADD CONSTRAINT [DF_Users_Last_Login_Time]
DEFAULT GETDATE() FOR LastLoginTime

INSERT INTO [Users] ([Username], [Password], [IsDeleted])
	Values
			('John5', 12345, 0)

ALTER TABLE [Users]
DROP CONSTRAINT [PK_Users_CompositeIdUsername]

ALTER TABLE [Users]
ADD CONSTRAINT [PK_User_Id]
PRIMARY KEY(Id)

ALTER TABLE [Users]
ADD CONSTRAINT [CK_Users_UsernameLength]
CHECK(LEN([Username]) >= 3)

CREATE DATABASE [Movies]

USE [Movies]

CREATE TABLE [Directors] (

	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[DirectorName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(100)
)

CREATE TABLE [Genres] (
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[GenreName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(100)
)

CREATE TABLE [Categories] (
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[CategoryName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(100)
)

DROP TABLE [Categories]

CREATE TABLE [Movies] (
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[Title] NVARCHAR(50) NOT NULL,
	[DirectorId] INT FOREIGN KEY REFERENCES [Directors](Id),
	[CopyrightYear] DATE,
	[Length] DECIMAL(4, 2),
	[GenreId] INT FOREIGN KEY REFERENCES [Genres](Id),
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories](Id),
	[Rating] DECIMAL(4, 2),
	[Notes] NVARCHAR(100)
)

DROP TABLE [Movies]

INSERT INTO [Directors]([Id], [DirectorName])
	VALUES
			(1, 'Director1'),
			(2, 'Director2'),
			(3, 'Director3'),
			(4, 'Director4'),
			(5, 'Director5')

SELECT * FROM [Directors]

INSERT INTO [Genres]([GenreName])
	VALUES
			('Genre1'),
			('Genre2'),
			('Genre3'),
			('Genre4'),
			('Genre5')

SELECT * FROM [Genres]

INSERT INTO [Categories]([CategoryName])
	VALUES
			('Category1'),
			('Category2'),
			('Category3'),
			('Category4'),
			('Category5')

SELECT * FROM [Categories] 
SELECT * FROM [Movies]

INSERT INTO [Movies]([Title], [DirectorId], [Length], [GenreId], [CategoryId], [Rating])
VALUES
		('Movie1', 1, 1.52, 1, 1, 6.50),
		('Movie2', 2, 2.52, 2, 2, 7.50),
		('Movie3', 3, 3.52, 3, 3, 8.50),
		('Movie4', 4, 4.52, 4, 4, 9.50),
		('Movie5', 5, 5.52, 5, 5, 10.00)


CREATE DATABASE [Hotel]

USE [Hotel]

CREATE TABLE [Employees] (
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[FirstName] NVARCHAR(20) NOT NULL,
	[LastName] NVARCHAR(20) NOT NULL,
	[Title] CHAR(4),
	[Notes] NVARCHAR(100) 
)

SELECT * FROM [Employees]

CREATE TABLE [Customers] (
	[AccountNumber] INT PRIMARY KEY	IDENTITY NOT NULL,
	[FirstName] NVARCHAR(25) NOT NULL,
	[LastName] NVARCHAR(25) NOT NULL,
	[PhoneNumber] VARCHAR(15),
	[EmergencyName] NVARCHAR(25),
	[EmergencyNumber] INT NOT NULL,
	[Notes] NVARCHAR(200)
)


SELECT * FROM [Customers]

CREATE TABLE [RoomStatus] (
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[RoomStatus] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(200)
)

SELECT * FROM [RoomStatus]

CREATE TABLE [RoomTypes]  (
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[RoomType] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(200)
)

SELECT * FROM [RoomStatus]

CREATE TABLE [BedTypes] (
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[BedType] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(200)
)

SELECT * FROM [BedTypes]

CREATE TABLE [Rooms](
	[RoomNumber] INT PRIMARY KEY NOT NULL,
	[RoomType] INT FOREIGN KEY REFERENCES [RoomTypes](Id),
	[BedType] INT FOREIGN KEY REFERENCES [BedTypes](Id),
	[Rate] DECIMAL(5, 2),
	[RoomStatus] INT FOREIGN KEY REFERENCES [RoomStatus](Id),
	[Notes] NVARCHAR(200)
)

CREATE TABLE [Payments](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees](Id) NOT NULL,
	[PaymentDate] DATE NOT NULL,
	[AccountNumber] NVARCHAR(12),
	[FirstDateOccupied] DATE,
	[LastDateOccupied] DATE,
	[TotalDays] AS DATEDIFF(DAY,[FirstDateOccupied],[LastDateOccupied]),
	[AmountCharged] DECIMAL(5, 2),
	[TaxRate] DECIMAL(4, 2),
	[TaxAmount] AS ([AmountCharged] * [TaxRate] * 100),
	[PaymentsTotal] DECIMAL(5, 2),
	[Notes] NVARCHAR(200)
)

DROP TABLE [Payments]

INSERT INTO [Employees]([FirstName], [LastName], [Title])
	VALUES
			('Empl1', 'Emp1', 'Mr.'),
			('Empl2', 'Emp2', 'Mrs.'),
			('Empl3', 'Emp3', 'Mr.')

INSERT INTO [Customers]([AccountNumber], [FirstName], [LastName], [PhoneNumber], [EmergencyName], [EmergencyNumber])
	VALUES
			(1, 'Customer1', 'Customer1', 56789, 'Customer1', 12234),
			(2, 'Customer2', 'Customer2', 56789, 'Customer2', 12234),
			(3, 'Customer3', 'Customer3', 56789, 'Customer3', 12234)

INSERT INTO [RoomStatus]([RoomStatus])
	VALUES
			('RoomStatus1'),
			('RoomStatus2'),
			('RoomStatus3')

SELECT * FROM [RoomStatus]

INSERT INTO [RoomTypes]([RoomType])
	 VALUES	
			('RoomType1'),
			('RoomType2'),
			('RoomType3')

INSERT INTO [BedTypes]([BedType])
	VALUES
			('BedType1'),
			('BedType2'),
			('BedType3')

INSERT INTO [Rooms]([RoomNumber], [RoomType], [BedType], [Rate], [RoomStatus])
	VALUES
			('101', 1, 1, 120.00, 1),
			('102', 2, 2, 122.00, 2),
			('103', 3, 3, 123.00, 3)

SELECT * FROM [Rooms]
SELECT * FROM [Payments]

INSERT INTO [Payments]([EmployeeId], [PaymentDate], [AccountNumber], [FirstDateOccupied], [LastDateOccupied], [AmountCharged], [TaxRate], [PaymentsTotal])
	VALUES
			(1, '3-3-1999', 1234, '3-3-1999', '3-5-1999', 123.000, 20, 340.000),
			(2, '5-3-1999', 12345, '5-3-1999', '5-5-1999', 125.000, 25, 345.000),
			(3, '7-3-1999', 12348, '7-3-1999', '7-5-1999', 128.000, 28, 348.000)

CREATE TABLE [Occupancies](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees]([Id]),
	[DateOccupied] DATE,
	[AccountNumber] INT FOREIGN KEY REFERENCES [Customers]([AccountNumber]),
	[RoomNumber] INT FOREIGN KEY REFERENCES [Rooms]([RoomNumber]),
	[RateApplied] DECIMAL (5, 2),
	[PhoneCharge] DECIMAL (5, 2),
	[Notes] NVARCHAR(200)
)

INSERT INTO [Occupancies] ([EmployeeId], [RateApplied])
	VALUES	
			(1, 230.00),
			(2, 12.00),
			(3, 123.00)

CREATE DATABASE [CarRental]

USE [CarRental]

CREATE TABLE [Categories](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[CategoryName] NVARCHAR(20) NOT NULL,
	[DailyRate] DECIMAL(5, 2),
	[WeeklyRate] DECIMAL(5, 2),
    [MonthlyRate] DECIMAL(5, 2),
	[WeekendRate] DECIMAL (5, 2),
	)

CREATE TABLE [Cars](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[PlateNumber] NVARCHAR(20) NOT NULL,
	[Manufacturer] NVARCHAR(20),
	[Model] NVARCHAR(20),
	[CarYear] CHAR(4),
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories](Id),
	[Doors] TINYINT,
	[Picture] VARBINARY(MAX),
	[Condition] NVARCHAR(20),
	[Available] BIT
)

CREATE TABLE [Employees] (
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[FirstName] NVARCHAR(20) NOT NULL,
	[LastName] NVARCHAR(20) NOT NULL,
	[Title] NVARCHAR(6),
	[NOTES] NVARCHAR(200)
)

CREATE TABLE [Customers](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[DriverLicenceNumber] VARCHAR(23) NOT NULL,
	[FullName] NVARCHAR(50),
	[Address] NVARCHAR(100),
	[City] NVARCHAR(50),
	[ZipCode] NVARCHAR(7),
	[Notes] NVARCHAR(100)
)

CREATE TABLE [RentalOrders](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees]([Id]),
	[CustomerId] INT FOREIGN KEY REFERENCES [Customers]([Id]),
	[CarId] INT FOREIGN KEY REFERENCES [Cars]([Id]),
	[TankLevel] DECIMAL(5, 2),
	[KilometrageStart] INT,
	[KilometrageEnd] INT,
	[TotalKilometrage] INT,
	[StartDate] DATE,
	[EndDate] DATE,
	[TotalDays] DATE,
	[RateApplied] DECIMAL(10, 2),
	[TaxRate] DECIMAL(10, 2),
	[OrderStatus] NVARCHAR(20),
	[Notes] NVARCHAR(200)

)


INSERT INTO [Categories]([CategoryName])
	VALUES
			('Category1'),
			('Category2'),
			('Category3')

INSERT INTO [Cars]([PlateNumber])
	VALUES
			('5678'),
			('765'),
			('123')

INSERT INTO [Employees]([FirstName], [LastName])
	VALUES
			('EMP1','EMP1'),
			('EMP2','EMP2'),
			('EMP3','EMP3')

INSERT INTO [Customers]([DriverLicenceNumber])
	VALUES
			('00000'),
			('11111'),
			('22222')

INSERT INTO [RentalOrders]([EmployeeId], [CustomerId], [CarId])
	VALUES
			(1, 1, 1),
			(2, 2, 2),
			(3, 3, 3)

SELECT * FROM [RentalOrders]

CREATE DATABASE [SoftUni]

USE [SoftUni]

CREATE TABLE [Towns] (
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Addresses] (
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[AddressText] NVARCHAR(50) NOT NULL,
	[TownId] INT FOREIGN KEY REFERENCES [Towns]([Id])
)

CREATE TABLE [Departments](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Employees](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[FirstName] NVARCHAR(50) NOT NULL,
	[MiddleName] NVARCHAR(50),
	[LastName] NVARCHAR(50) NOT NULL,
	[JobTitle] NVARCHAR(30) NOT NULL,
	[DepartmentId] INT FOREIGN KEY REFERENCES [Departments]([Id]) NOT NULL,
	[HireDate] DATE NOT NULL,
	[Salary] DECIMAL(7, 2),
	[AddressId] INT FOREIGN KEY REFERENCES [Addresses]([Id]) NOT NULL
)


INSERT INTO [Towns]([Name])
	VALUES
			('Sofia'),
			('Plovdiv'),
			('Varna'),
			('Burgas')

INSERT INTO [Departments]([Name])
	VALUES
			('Engineering'),
			('Sales'),
			('Marketing'),
			('Software Development'),
			('Quality Assurance')
SELECT * FROM [Departments]

INSERT INTO [Employees]([FirstName], [MiddleName], [LastName], [JobTitle], [DepartmentId], [HireDate], [Salary])
	VALUES
			('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '02/01/2013', 3500.00),
			('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '03/02/2004', 4000.00),
			('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '08/28/2016', 525.25),
			('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '12/09/2007', 3000.00),
			('Peter', 'Pan', 'Pan', 'Intern', 3, '08/28/2016', 599.88)

SELECT * FROM [Towns]

SELECT * FROM [Departments]

SELECT * FROM [Employees]

SELECT * FROM [Towns]
ORDER BY [Name] ASC

SELECT * FROM [Departments]
ORDER BY [Name] ASC

SELECT * FROM [Employees]
ORDER BY [Salary] DESC

SELECT [Name] FROM [Towns]
ORDER BY [Name]

SELECT [Name] FROM [Departments]
ORDER BY [Name] 

SELECT [FirstName], [LastName], [JobTitle], [Salary] FROM [Employees]
ORDER BY [Salary] DESC

UPDATE [Employees]
SET [Salary] += [Salary] * 0.10

SELECT [Salary] FROM [Employees]

USE [Hotel]

UPDATE [Payments]
SET [TaxRate] -= [TaxRate] * 0.03

SELECT [TaxRate] FROM [Payments]

TRUNCATE TABLE [Occupancies]

SELECT * FROM [Occupancies]

DROP DATABASE [SoftUni]