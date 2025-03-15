/*incorrect data types for some entities, these will be changed */

ALTER TABLE [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
ALTER COLUMN [Reciept Transaction Row ID] smallint ; 

ALTER TABLE [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
ALTER COLUMN [Item Price] smallmoney ;

ALTER TABLE [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
ALTER COLUMN [Item Price] smallmoney ;

ALTER TABLE [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
ALTER COLUMN [Row Total] smallmoney ;

ALTER TABLE [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
ALTER COLUMN [Item Quantity] smallint ;

ALTER TABLE [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
ALTER COLUMN [Item ID] smallint ;

ALTER TABLE [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
ALTER COLUMN [Receipt ID] int ;

/*Changing format of date */
ALTER TABLE [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
ALTER COLUMN [Sale Date] date;
/* Renamed Reciept ID and Reciept Transaction Row ID capitalize and spell correctly, this will be done by changing the excel file's alias*/


/* Checking for duplicate Item ID's with Item Descriptions */
SELECT [Item Description] 
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']

GROUP BY [Item Description]
HAVING COUNT(DISTINCT [Item ID]) > 1;

SELECT DISTINCT[Item ID], [Item Description]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
ORDER BY [Item ID]

/*
Identified no duplicates
*/

/* Identifying duplicate reciept ids */
SELECT [Receipt ID], COUNT(DISTINCT [Customer ID])
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY [Receipt ID]
HAVING COUNT(DISTINCT "Customer ID") > 1


/* Finds duplicate Reciept ID's */

SELECT [Receipt ID], COUNT(DISTINCT [Customer ID])
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY [Receipt ID]
HAVING COUNT(DISTINCT "Customer ID") > 1

/* Removes duplicate reciept ID's */ 

UPDATE [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
SET [Receipt ID] = (
    SELECT MAX([Receipt ID]) + 1
    FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
)
WHERE [Receipt ID] = '104312'
AND [Customer ID] = 'C148';

UPDATE [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
SET [Receipt ID] = (
    SELECT MAX([Receipt ID]) + 1
    FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
)
WHERE [Receipt ID] = '118551'
AND [Customer ID] = 'C423';

/* All duplicate receipt id's have been removed and given new id's */

/* Identifying duplicate item descriptions per transaction */

WITH cnt([Receipt ID], "Rows") AS (
    SELECT [Receipt ID], COUNT([Receipt ID]) AS "Rows"
    FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY [Receipt ID]
)

SELECT ['Assignment 2 Data$'].[Receipt ID], "Rows", COUNT(DISTINCT "Item ID") AS "Number of Items"
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
JOIN cnt ON ['Assignment 2 Data$'].[Receipt ID] = cnt.[Receipt ID]
GROUP BY ['Assignment 2 Data$'].[Receipt ID], "Rows"
HAVING COUNT(DISTINCT "Item ID") != "Rows";

/* No duplication found */


/* Identifying which reciept Id's contain multiple staff ID */

WITH ROW_UPDATE AS (
    SELECT [Receipt ID], "Staff ID",[Staff First Name], [Staff Surname], ROW_NUMBER() OVER (PARTITION BY [Receipt ID] ORDER BY [Reciept Transaction Row ID]) AS new_row_number
    FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
	WHERE [Receipt ID] IN (
SELECT [Receipt ID]  
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY  [Receipt ID]
HAVING COUNT(DISTINCT "Staff ID") > 1
                    )
)

UPDATE sss
SET sss.[Staff ID] = ROW_UPDATE.[Staff ID], sss.[Staff First Name] = ROW_UPDATE.[Staff First Name], sss.[Staff Surname] = ROW_UPDATE.[Staff Surname]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$'] sss
INNER JOIN ROW_UPDATE ON sss.[Receipt ID] = ROW_UPDATE.[Receipt ID]
WHERE ROW_UPDATE.new_row_number = 1;

/* All receipts with multiple Staff ID's have been set to the first Staff ID listed on the entire receipt */


/* Check for duplicate staff ID's */

SELECT DISTINCT[Staff ID], [Staff First Name], [Staff Surname]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
ORDER BY [Staff ID]

SELECT [Staff ID],COUNT(DISTINCT [Staff First Name]), COUNT(DISTINCT [Staff Surname])
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY [Staff ID]
HAVING COUNT(DISTINCT [Staff First Name])> 1 OR COUNT(DISTINCT [Staff Surname])> 1

/* Finds no duplicated staff id's*/

-- Staff IDs are unique across offices. This also means that no staff member have been working at multiple offices
SELECT [Staff ID]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY [Staff ID]
HAVING COUNT(DISTINCT [Staff office]) > 1
ORDER BY [Staff ID]

-- Receipt ideas are unique across stores
SELECT [Receipt ID]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY [Receipt ID]
HAVING COUNT(DISTINCT [Staff Office]) > 1
ORDER BY [Receipt ID]

---------------------------------------------------------------------------------------------
-- THERE ARE TWO BRANCHES WITH AN EMPLOYEE NAMED ISABELLA GREEN
---------------------------------------------------------------------------------------------

SELECT [Staff First Name], [Staff Surname], MAX([Staff Office]) AS [Staff Office]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY [Staff First Name], [Staff Surname]
HAVING COUNT(DISTINCT [Staff Office]) > 1
ORDER BY [Staff Surname];

SELECT [Staff First Name], [Staff Surname], [Staff Office], [Office Location]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
WHERE [Staff First Name] = 'Isabella' AND [Staff Surname] = 'Green';

-- All offices have a unique Staff Office (Next 2)

SELECT TOP 10 [Staff Office], MAX([Office Location]) AS [Office Location]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY [Staff Office]
HAVING COUNT(DISTINCT [Office Location]) > 1;

SELECT TOP 10 MAX([Staff Office]) AS [Staff Office], [Office Location]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY [Office Location]
HAVING COUNT(DISTINCT [Staff Office]) > 1;

-- All Item IDs and Item Descriptions Match (Next 2)
SELECT [Item ID], MAX([Item Description]) AS [Item Description]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY [Item ID]
HAVING COUNT(DISTINCT [Item Description]) > 1
ORDER BY [Item ID];

SELECT [Item Description], MIN([Item ID]) AS [Item ID]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY [Item Description]
HAVING COUNT(DISTINCT [Item ID]) > 1
ORDER BY [Item Description];

-- All stores have the same item offerings (Next 2)

SELECT DISTINCT([Staff office]), count(DISTINCT[Item ID]) as NrOfItems
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY[Staff office]

SELECT COUNT(DISTINCT[Item ID]) as NrOfItems
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']

-- Count how many staff members are at each store

SELECT COUNT(DISTINCT [Staff ID]) AS [Count], [Office Location], [Staff Office]
FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY [Office Location], [Staff Office]
ORDER BY [Count] DESC;


