
-- Top 3 and last 3 Items Sold by Office Location
USE AllSalesDB
GO

-- Top 3 items
SELECT Office_Location, Item_Description, Total_Items
FROM (
    SELECT Office_Location, Item_Description, Total_Items,
        ROW_NUMBER() OVER (PARTITION BY Office_Location ORDER BY Total_Items DESC) as rn
    FROM (
        SELECT dbo.DimOffice.Office_Location, dbo.DimItem.Item_Description, COUNT(dbo.DimItem.Item_Description) AS Total_Items
        FROM dbo.SalesTransaction
        INNER JOIN dbo.DimOffice ON dbo.SalesTransaction.Office_Key = dbo.DimOffice.Office_Key
        INNER JOIN dbo.DimItem ON dbo.SalesTransaction.Item_Key = dbo.DimItem.Item_Key
        GROUP BY dbo.DimOffice.Office_Location, dbo.DimItem.Item_Description
    ) subquery
) t
WHERE rn <= 3

-- Bottom 3 items
SELECT Office_Location, Item_Description, Total_Items
FROM (
    SELECT Office_Location, Item_Description, Total_Items,
        ROW_NUMBER() OVER (PARTITION BY Office_Location ORDER BY Total_Items ASC) as rn
    FROM (
        SELECT dbo.DimOffice.Office_Location, dbo.DimItem.Item_Description, COUNT(dbo.DimItem.Item_Description) AS Total_Items
        FROM dbo.SalesTransaction
        INNER JOIN dbo.DimOffice ON dbo.SalesTransaction.Office_Key = dbo.DimOffice.Office_Key
        INNER JOIN dbo.DimItem ON dbo.SalesTransaction.Item_Key = dbo.DimItem.Item_Key
        GROUP BY dbo.DimOffice.Office_Location, dbo.DimItem.Item_Description
    ) subquery
) t
WHERE rn <= 3

