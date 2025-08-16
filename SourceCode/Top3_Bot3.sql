-- Top 3 and last 3 Items Sold by Office Location
USE AllSalesDB
GO
SELECT TOP (3)
    dbo.DimItem.Item_ID, dbo.DimItem.Item_Description, SUM(dbo.SalesTransaction.Item_Quantity) AS Total_Item_Sold
FROM dbo.DimItem INNER JOIN
    dbo.SalesTransaction ON dbo.DimItem.Item_Key = dbo.SalesTransaction.Item_Key
GROUP BY dbo.DimItem.Item_ID, dbo.DimItem.Item_Description
ORDER BY Total_Item_Sold DESC


SELECT TOP (3)
    dbo.DimItem.Item_ID, dbo.DimItem.Item_Description, SUM(dbo.SalesTransaction.Item_Quantity) AS Total_Item_Sold
FROM dbo.DimItem INNER JOIN
    dbo.SalesTransaction ON dbo.DimItem.Item_Key = dbo.SalesTransaction.Item_Key
GROUP BY dbo.DimItem.Item_ID, dbo.DimItem.Item_Description
ORDER BY Total_Item_Sold