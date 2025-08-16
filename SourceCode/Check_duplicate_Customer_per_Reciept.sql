USE AllSalesDB
GO

-- Check duplicate Customer per Receipt Id
SELECT [Receipt Id], COUNT(DISTINCT [Customer ID]) AS [Number of Customers]
FROM [dbo].[SalesDataRaw]
GROUP BY [Receipt Id]
HAVING COUNT
(DISTINCT[Customer ID]) > 1;


SELECT [Receipt Id], (SELECT DISTINCT [Customer ID]) AS [Customer ID]
FROM [dbo].[SalesDataRaw]
WHERE [Receipt Id] IN
(104312, 118551)
GROUP BY [Receipt Id], [Customer ID];


-- Update Receipt Id
UPDATE [dbo].SalesDataRaw
SET [Receipt Id] = (SELECT MAX([Receipt Id])
FROM [dbo].SalesDataRaw) + 1
WHERE [Receipt Id] = 104312 AND [Customer ID] = 'C86'

UPDATE [dbo].SalesDataRaw
SET [Receipt Id] = (SELECT MAX([Receipt Id])
FROM [dbo].SalesDataRaw) + 1
WHERE [Receipt Id] = 118551 AND [Customer ID] = 'C567'

