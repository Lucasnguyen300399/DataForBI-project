-- Bottom 3 items sold in all offices
USE AllSalesDB
GO
SELECT TOP 3
    dbo.DimItem.Item_Description, CAST(SUM(dbo.SalesTransaction.Row_Total) AS decimal(10, 2)) AS Total_Sales
FROM dbo.SalesTransaction INNER JOIN
    dbo.DimItem ON dbo.SalesTransaction.Item_Key = dbo.DimItem.Item_Key
GROUP BY dbo.DimItem.Item_Description
ORDER BY Total_Sales

SELECT TOP 3
    dbo.DimItem.Item_ID, dbo.DimItem.Item_Description, SUM(dbo.SalesTransaction.Item_Quantity) AS Total_Item_Sold
FROM dbo.DimItem INNER JOIN
    dbo.SalesTransaction ON dbo.DimItem.Item_Key = dbo.SalesTransaction.Item_Key
GROUP BY dbo.DimItem.Item_ID, dbo.DimItem.Item_Description
ORDER BY Total_Item_Sold