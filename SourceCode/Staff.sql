USE AllSalesDB
GO

-- Total transaction per staff
SELECT dbo.DimStaff.Staff_ID,
    dbo.DimStaff.Staff_First_Name,
    dbo.DimStaff.Staff_Surname,
    COUNT(dbo.SalesTransaction.Receipt_ID) AS Total_Transaction
FROM dbo.SalesTransaction
    INNER JOIN dbo.DimStaff ON dbo.SalesTransaction.Staff_Key = dbo.DimStaff.Staff_Key
GROUP BY dbo.DimStaff.Staff_ID,
    dbo.DimStaff.Staff_First_Name,
    dbo.DimStaff.Staff_Surname
ORDER BY Total_Transaction DESC


-- Total sales per staff
USE AllSalesDB
GO
SELECT dbo.DimStaff.Staff_ID, dbo.DimStaff.Staff_First_Name, dbo.DimStaff.Staff_Surname, CAST(SUM(dbo.SalesTransaction.Row_Total) AS decimal(10, 2)) AS Total_Sales
FROM dbo.SalesTransaction INNER JOIN
    dbo.DimStaff ON dbo.SalesTransaction.Staff_Key = dbo.DimStaff.Staff_Key
GROUP BY dbo.DimStaff.Staff_ID, dbo.DimStaff.Staff_First_Name, dbo.DimStaff.Staff_Surname
ORDER BY Total_Sales DESC

-- Total item sold per staff
SELECT dbo.DimStaff.Staff_ID, dbo.DimStaff.Staff_First_Name, dbo.DimStaff.Staff_Surname, SUM(dbo.DimItem.Item_ID) AS Total_Items_Sold
FROM dbo.SalesTransaction INNER JOIN
    dbo.DimStaff ON dbo.SalesTransaction.Staff_Key = dbo.DimStaff.Staff_Key INNER JOIN
    dbo.DimItem ON dbo.SalesTransaction.Item_Key = dbo.DimItem.Item_Key
GROUP BY dbo.DimStaff.Staff_ID, dbo.DimStaff.Staff_First_Name, dbo.DimStaff.Staff_Surname
ORDER BY Total_Items_Sold DESC