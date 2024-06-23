
USE master;  
GO  
IF DB_ID (N'EBUS3030_assignment_2') IS NOT NULL --Check if it already exists, if so drop, otherwise create
DROP DATABASE EBUS3030_assignment_2;
GO
CREATE DATABASE EBUS3030_assignment_2;  
GO  

USE [EBUS3030_assignment_2]
GO

DROP TABLE IF EXISTS dbo.FactSale;
DROP TABLE IF EXISTS dbo.DimCustomer;
DROP TABLE IF EXISTS dbo.DimStaff;
DROP TABLE IF EXISTS dbo.DimItem;
DROP TABLE IF EXISTS dbo.DimTransactionRow;
DROP TABLE IF EXISTS dbo.DimDate;


CREATE TABLE DimCustomer
(   
[Customer ID] nvarchar(255),
[Customer First Name] nvarchar(255),
[Customer Surname] nvarchar(255),
Loyalty BIT,
PRIMARY KEY ([Customer ID])
) 
GO

CREATE TABLE DimStaff
(   
[Staff ID] nvarchar(255),
[Staff First Name] nvarchar(255),
[Staff Surname] nvarchar(255)
PRIMARY KEY ([Staff ID])
) 
GO

CREATE TABLE DimItem
(
[Item ID] smallint,
[Item Description] nvarchar(255)
PRIMARY KEY ([Item ID])
)
GO

CREATE TABLE DimTransactionRow
(
[Reciept Transaction Row ID] smallint,
PRIMARY KEY ([Reciept Transaction Row ID])
)
GO

CREATE TABLE DimDate
(
[Sale Date] Date,
SaleMonth smallint,
SaleYear smallint
PRIMARY KEY ([Sale Date])
)
GO

CREATE TABLE FactSale
(
[Receipt ID] int,
[Reciept Transaction Row ID] smallint,
[Customer ID] nvarchar(255),
[Staff ID] nvarchar(255),
[Item ID] smallint,
[Sale Date] date,

[Item Quantity] smallint,
[Item Price] smallmoney,
[Row Total] smallmoney
PRIMARY KEY ([Receipt ID], [Reciept Transaction Row ID])
FOREIGN KEY ([Customer ID]) REFERENCES DimCustomer([Customer ID]),
FOREIGN KEY ([Staff ID]) REFERENCES DimStaff([Staff ID]),
FOREIGN KEY ([Item ID]) REFERENCES DimItem([Item ID]),
FOREIGN KEY ([Reciept Transaction Row ID]) REFERENCES DimTransactionRow([Reciept Transaction Row ID]),
FOREIGN KEY ([Sale Date]) REFERENCES DimDate([Sale Date])
)
GO


INSERT INTO DimCustomer ([Customer ID], [Customer First Name], [Customer Surname])
SELECT DISTINCT [Customer ID], [Customer First Name], [Customer Surname]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$'];

INSERT INTO DimStaff ([Staff ID], [Staff First Name], [Staff Surname])
SELECT DISTINCT [Staff ID], [Staff First Name], [Staff Surname]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$'];

INSERT INTO DimItem ([Item ID], [Item Description])
SELECT DISTINCT [Item ID], [Item Description]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$'];

INSERT INTO DimTransactionRow ([Reciept Transaction Row ID])
SELECT DISTINCT [Reciept Transaction Row ID]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$'];

INSERT INTO DimDate([Sale Date], SaleMonth, SaleYear)
SELECT DISTINCT [Sale Date], month([Sale Date]), year([Sale Date])
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$'];

INSERT INTO FactSale([Receipt ID], [Reciept Transaction Row ID],  [Customer ID], [Staff ID], [Item ID], [Sale Date], [Item Quantity], [Item Price], [Row Total])
SELECT DISTINCT [Receipt ID], [Reciept Transaction Row ID], [Customer ID], [Staff ID], [Item ID], [Sale Date], [Item Quantity], [Item Price], [Row Total]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$'];
