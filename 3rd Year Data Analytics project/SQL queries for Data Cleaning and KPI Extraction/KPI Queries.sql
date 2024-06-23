
/*Top salesperson for each month out of all offices in $ earned*/
WITH MonthlySales AS
(
    SELECT 
        YEAR([Sale Date]) AS Year,
        MONTH([Sale Date]) AS Month,
		[Office Location],
        [Staff ID],
        [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
        SUM([Row Total]) AS MonthlyTotalSales,
        ROW_NUMBER() OVER (PARTITION BY YEAR([Sale Date]), MONTH([Sale Date]) 
                           ORDER BY SUM([Row Total]) DESC) AS Rank
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        YEAR([Sale Date]),
        MONTH([Sale Date]),
		[Office Location],
        [Staff ID],
        [Staff First Name] + ' ' + [Staff Surname]
)

SELECT
    Year,
    Month,
    [Staff ID],
	[Office Location],
    SalespersonName,
    MonthlyTotalSales
FROM
    MonthlySales
WHERE
    Rank = 1
ORDER BY
    Year,
    Month;

/*Top salesperson for each month at each office in $ earned* */

WITH MonthlySales AS
(
    SELECT 
        YEAR([Sale Date]) AS Year,
        MONTH([Sale Date]) AS Month,
        [Office Location],
        [Staff ID],
        [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
        SUM([Row Total]) AS MonthlyTotalSales,
        ROW_NUMBER() OVER (PARTITION BY YEAR([Sale Date]), MONTH([Sale Date]), [Office Location] 
                           ORDER BY SUM([Row Total]) DESC) AS Rank
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        YEAR([Sale Date]),
        MONTH([Sale Date]),
        [Office Location],
        [Staff ID],
        [Staff First Name] + ' ' + [Staff Surname]
)

SELECT
    Year,
    Month,
    [Office Location],
    [Staff ID],
    SalespersonName,
    MonthlyTotalSales
FROM
    MonthlySales
WHERE
    Rank = 1
ORDER BY
    Year,
    Month,
    [Office Location];

/*Overall top salesperson by $ earned* */

SELECT 
    [Staff ID],
    [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
    [Office Location],
    SUM([Row Total]) AS TotalSales
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY 
    [Staff ID],
    [Staff First Name],
    [Staff Surname],
    [Office Location]
ORDER BY 
    TotalSales DESC;

/*Overall top 10 salesperson by $ earned* */
SELECT TOP 10
    [Staff ID],
    [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
    [Office Location],
    SUM([Row Total]) AS TotalSales
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY 
    [Staff ID],
    [Staff First Name],
    [Staff Surname],
    [Office Location]
ORDER BY 
    TotalSales DESC;


/*Top salesperson for each month out of all offices, based on the number of transactions they've made*/

WITH MonthlyTransactions AS
(
    SELECT 
        YEAR([Sale Date]) AS Year,
        MONTH([Sale Date]) AS Month,
        [Office Location],
        [Staff ID],
        [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
        COUNT(DISTINCT [Receipt Id]) AS TotalTransactions,
        ROW_NUMBER() OVER (PARTITION BY YEAR([Sale Date]), MONTH([Sale Date]) 
                           ORDER BY COUNT(DISTINCT [Receipt Id]) DESC) AS Rank
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        YEAR([Sale Date]),
        MONTH([Sale Date]),
        [Office Location],
        [Staff ID],
        [Staff First Name] + ' ' + [Staff Surname]
)
SELECT
    Year,
    Month,
    [Office Location],
    [Staff ID],
    SalespersonName,
    TotalTransactions
FROM
    MonthlyTransactions
WHERE
    Rank = 1
ORDER BY
    Year,
    Month;

/*Top salesperson for each month based on the number of transactions they've made, at Each office location*/
WITH MonthlyTransactions AS
(
    SELECT 
        YEAR([Sale Date]) AS Year,
        MONTH([Sale Date]) AS Month,
        [Office Location],
        [Staff ID],
        [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
        COUNT(DISTINCT [Receipt Id]) AS TotalTransactions,
        ROW_NUMBER() OVER (PARTITION BY YEAR([Sale Date]), MONTH([Sale Date]), [Office Location] 
                           ORDER BY COUNT(DISTINCT [Receipt Id]) DESC) AS Rank
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        YEAR([Sale Date]),
        MONTH([Sale Date]),
        [Office Location],
        [Staff ID],
        [Staff First Name] + ' ' + [Staff Surname]
)

SELECT
    Year,
    Month,
    [Office Location],
    [Staff ID],
    SalespersonName,
    TotalTransactions
FROM
    MonthlyTransactions
WHERE
    Rank = 1
ORDER BY
    Year,
    Month,
    [Office Location];


SELECT 
    [Staff ID],
    [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
    COUNT(DISTINCT [Receipt Id]) AS TotalTransactions
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY 
    [Staff ID],
    [Staff First Name],
    [Staff Surname]
ORDER BY 
    TotalTransactions DESC;

/*Overall Best salesperson by most transactions made.*/
SELECT 
    [Staff ID],
    [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
    COUNT(DISTINCT [Receipt Id]) AS TotalTransactions
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY 
    [Staff ID],
    [Staff First Name],
    [Staff Surname]
ORDER BY 
    TotalTransactions DESC;

/*Top 10 Overall Best salesperson by most transactions made.*/
SELECT TOP 10
    [Staff ID],
    [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
    [Office Location],
    COUNT(DISTINCT [Receipt Id]) AS TotalTransactions
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY 
    [Staff ID],
    [Staff First Name],
    [Staff Surname],
    [Office Location]
ORDER BY 
    TotalTransactions DESC;

/*Top salesperson based on the most goods sold, out of all office locations for each month.*/
WITH MonthlyGoodsSold AS
(
    SELECT 
        YEAR([Sale Date]) AS Year,
        MONTH([Sale Date]) AS Month,
		[Office Location],
        [Staff ID],
        [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
        SUM([Item Quantity]) AS TotalGoodsSold,
        ROW_NUMBER() OVER (PARTITION BY YEAR([Sale Date]), MONTH([Sale Date]) 
                           ORDER BY SUM([Item Quantity]) DESC) AS Rank
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        YEAR([Sale Date]),
        MONTH([Sale Date]),
		[Office Location],
        [Staff ID],
        [Staff First Name] + ' ' + [Staff Surname]
)

SELECT
    Year,
    Month,
	[Office Location],
    [Staff ID],
    SalespersonName,
    TotalGoodsSold
FROM
    MonthlyGoodsSold
WHERE
    Rank = 1
ORDER BY
    Year,
    Month;


/*Top salesperson based on the most goods sold for each month at each office location.*/
WITH MonthlyGoodsSold AS
(
    SELECT 
        YEAR([Sale Date]) AS Year,
        MONTH([Sale Date]) AS Month,
        [Office Location],
        [Staff ID],
        [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
        SUM([Item Quantity]) AS TotalGoodsSold,
        ROW_NUMBER() OVER (PARTITION BY YEAR([Sale Date]), MONTH([Sale Date]), [Office Location] 
                           ORDER BY SUM([Item Quantity]) DESC) AS Rank
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        YEAR([Sale Date]),
        MONTH([Sale Date]),
        [Office Location],
        [Staff ID],
        [Staff First Name] + ' ' + [Staff Surname]
)

SELECT
    Year,
    Month,
    [Office Location],
    [Staff ID],
    SalespersonName,
    TotalGoodsSold
FROM
    MonthlyGoodsSold
WHERE
    Rank = 1
ORDER BY
    Year,
    Month,
    [Office Location];

/*Top 10 Overall Best salesperson by most goods sold.*/
SELECT TOP 10
    [Staff ID],
    [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
    [Office Location],
    SUM([Item Quantity]) AS TotalGoodsSold
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY 
    [Staff ID],
    [Staff First Name],
    [Staff Surname],
    [Office Location]
ORDER BY 
    TotalGoodsSold DESC;



/*Overall Best salesperson by most goods sold.*/
SELECT 
    [Staff ID],
    [Staff First Name] + ' ' + [Staff Surname] AS SalespersonName,
    [Office Location],
    SUM([Item Quantity]) AS TotalGoodsSold
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY 
    [Staff ID],
    [Staff First Name],
    [Staff Surname],
    [Office Location]
ORDER BY 
    TotalGoodsSold DESC;

/*Total goods sold*/
SELECT 
    SUM([Item Quantity]) AS TotalGoodsSold
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$'];





/*Best-performing stores and number of employees working on that store (This is done for the whole year).(Determining the best-performing 
stores based on total sales while also giving the count of distinct employees working at each store) */
SELECT 
    [Office Location] AS Store,
    SUM([Row Total]) AS TotalSalesAmount,
    COUNT(DISTINCT [Staff ID]) AS NumberOfEmployees
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY 
    [Office Location]
ORDER BY 
    TotalSalesAmount DESC;


/*This script below will calculate the ratio of total sales to the number of employees for each store and 
then list the stores by this ratio in descending order. The store with the highest sales per employee 
will be at the top.*/

WITH StoreSales AS (
    SELECT 
        [Office Location] AS Store,
        SUM([Row Total]) AS TotalSalesAmount,
        COUNT(DISTINCT [Staff ID]) AS NumberOfEmployees
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        [Office Location]
)

SELECT 
    Store,
    TotalSalesAmount,
    NumberOfEmployees,
    (TotalSalesAmount * 1.0 / NumberOfEmployees) AS SalesPerEmployee
FROM 
    StoreSales
ORDER BY 
    SalesPerEmployee DESC;



/*Determining the three most popular items in each store for each month
(This SQL script will give you the three most popular items for each store 
(office location) based on the quantity sold for each month.)*/
WITH MonthlyPopularItems AS
(
    SELECT 
        YEAR([Sale Date]) AS Year,
        MONTH([Sale Date]) AS Month,
        [Office Location],
        [Item ID],
        [Item Description],
        SUM([Item Quantity]) AS TotalQuantitySold,
        ROW_NUMBER() OVER (PARTITION BY YEAR([Sale Date]), MONTH([Sale Date]), [Office Location]
                           ORDER BY SUM([Item Quantity]) DESC) AS Rank
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        YEAR([Sale Date]),
        MONTH([Sale Date]),
        [Office Location],
        [Item ID],
        [Item Description]
)

SELECT
    Year,
    Month,
    [Office Location],
    [Item ID],
    [Item Description],
    TotalQuantitySold
FROM
    MonthlyPopularItems
WHERE
    Rank <= 3
ORDER BY
    Year,
    Month,
    [Office Location],
    Rank;

/* Determining the three most popular items in each store based on the entirety of dataset provided */
WITH PopularItems AS
(
    SELECT 
        [Office Location],
        [Item ID],
        [Item Description],
        SUM([Item Quantity]) AS TotalQuantitySold,
        ROW_NUMBER() OVER (PARTITION BY [Office Location]
                           ORDER BY SUM([Item Quantity]) DESC) AS Rank
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        [Office Location],
        [Item ID],
        [Item Description]
)

SELECT
    [Office Location],
    [Item ID],
    [Item Description],
    TotalQuantitySold
FROM
    PopularItems
WHERE
    Rank <= 3
ORDER BY
    [Office Location],
    Rank;

/* Top 3 items in popularity across all stores */
WITH OverallPopularItems AS
(
    SELECT 
        [Item ID],
        [Item Description],
        SUM([Item Quantity]) AS TotalQuantitySold,
        ROW_NUMBER() OVER (ORDER BY SUM([Item Quantity]) DESC) AS Rank
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        [Item ID],
        [Item Description]
)

SELECT
    [Item ID],
    [Item Description],
    TotalQuantitySold
FROM
    OverallPopularItems
WHERE
    Rank <= 3
ORDER BY
    Rank;

/*Determining the three least popular items in each store for each month*/

WITH MonthlyLeastPopularItems AS
(
    SELECT 
        YEAR([Sale Date]) AS Year,
        MONTH([Sale Date]) AS Month,
        [Office Location],
        [Item ID],
        [Item Description],
        SUM([Item Quantity]) AS TotalQuantitySold,
        ROW_NUMBER() OVER (PARTITION BY YEAR([Sale Date]), MONTH([Sale Date]), [Office Location]
                           ORDER BY SUM([Item Quantity]) ASC) AS Rank  -- Ordering in ascending order
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        YEAR([Sale Date]),
        MONTH([Sale Date]),
        [Office Location],
        [Item ID],
        [Item Description]
)

SELECT
    Year,
    Month,
    [Office Location],
    [Item ID],
    [Item Description],
    TotalQuantitySold
FROM
    MonthlyLeastPopularItems
WHERE
    Rank <= 3
ORDER BY
    Year,
    Month,
    [Office Location],
    Rank;

/* Determining the three least popular items in each store based on the entirety of dataset provided */
WITH OverallLeastPopularItems AS
(
    SELECT 
        [Office Location],
        [Item ID],
        [Item Description],
        SUM([Item Quantity]) AS TotalQuantitySold,
        ROW_NUMBER() OVER (PARTITION BY [Office Location] 
                           ORDER BY SUM([Item Quantity]) ASC) AS Rank  -- Ordering in ascending order
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        [Office Location],
        [Item ID],
        [Item Description]
)

SELECT
    [Office Location],
    [Item ID],
    [Item Description],
    TotalQuantitySold
FROM
    OverallLeastPopularItems
WHERE
    Rank <= 3
ORDER BY
    [Office Location],
    Rank;

/*Top 3 least popular items across all stores*/
WITH OverallLeastPopularItems AS
(
    SELECT 
        [Item ID],
        [Item Description],
        SUM([Item Quantity]) AS TotalQuantitySold,
        ROW_NUMBER() OVER (ORDER BY SUM([Item Quantity]) ASC) AS Rank  -- Ordering in ascending order
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
    GROUP BY 
        [Item ID],
        [Item Description]
)

SELECT
    [Item ID],
    [Item Description],
    TotalQuantitySold
FROM
    OverallLeastPopularItems
WHERE
    Rank <= 3
ORDER BY
    Rank;




/*loyalty program*/
/* 1. Amount discounted due to the loyalty program: */

SELECT 
    SUM([Row Total] * 0.125) AS TotalDiscountedAmount
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
WHERE
    [Receipt Id] IN (
        SELECT [Receipt Id]
        FROM [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
        GROUP BY [Receipt Id]
        HAVING COUNT(DISTINCT [Item ID]) >= 5  -- Transactions with 5 or more different types of items
    )
    AND [Customer ID] IS NOT NULL;  -- Assuming NULL Customer ID means they're not a member of the loyalty program

/*2. Total points to be awarded:*/
SELECT 
    SUM([Row Total]) AS TotalPoints
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
WHERE
    [Customer ID] IS NOT NULL;  -- Assuming customers with a registered ID are the ones who get points

/*3. Future credit based on points:*/
SELECT 
    FLOOR(SUM([Row Total]) / 250) AS TotalFutureDollarCredit
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
WHERE
    [Customer ID] IS NOT NULL;  


/*4. */
SELECT 
    SUM([Row Total]) AS TotalSalesAmount
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$'];

/* Considering the Sale Date to determine the sale frequency of each item,
we can count the number of distinct days each item was sold. 
The slowest moving items will be those sold on the fewest distinct days. Here's an SQL script to achieve that */

/*We should try this for each branch withought entire data set */

SELECT 
    [Item ID],
    [Item Description],
    COUNT(DISTINCT [Sale Date]) AS DaysSold
FROM 
    [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$']
GROUP BY 
    [Item ID], [Item Description]
ORDER BY 
    DaysSold ASC;


/*Bundle items. 
using SQL, you can look at items that appear in the same receipt. 
Below is a SQL script that lists pairs of items that were bought together, 
ordered by the frequency of their co-purchase:*/

WITH ItemPairs AS (
    SELECT
        a.[Receipt Id],
        a.[Item ID] AS ItemID1,
        a.[Item Description] AS ItemDescription1,
        b.[Item ID] AS ItemID2,
        b.[Item Description] AS ItemDescription2
    FROM 
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$'] a
    JOIN
        [EBUS3030_assignment_2].[dbo].['Assignment 2 Data$'] b
    ON
        a.[Receipt Id] = b.[Receipt Id]
    WHERE
        a.[Item ID] < b.[Item ID]
)

SELECT 
    ItemID1,
    ItemDescription1,
    ItemID2,
    ItemDescription2,
    COUNT(*) AS Frequency
FROM 
    ItemPairs
GROUP BY 
    ItemID1, ItemDescription1, ItemID2, ItemDescription2
ORDER BY 
    Frequency DESC;

/*This script joins the table with itself on the Receipt Id to create pairs of items bought together. 
The condition a.[Item ID] < b.[Item ID] ensures that each pair is only counted once
(e.g., if items A and B were bought together, we only want to count the pair (A, B) and not the pair (B, A)).

The result will show you pairs of items and the number of times they were bought together, in descending order 
of frequency. This can give you an idea of which items are often co-purchased and might be suitable
for bundling together in a promotion.*/