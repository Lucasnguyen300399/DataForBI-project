-- Total Sales by Office Location
USE AllSalesDB
GO

SELECT dbo.DimOffice.Office_Location,
    CAST(
        SUM(dbo.SalesTransaction.Row_Total) AS decimal(10, 2)
    ) AS Total_Sales
FROM dbo.SalesTransaction
    INNER JOIN dbo.DimOffice ON dbo.SalesTransaction.Office_Key = dbo.DimOffice.Office_Key
GROUP BY dbo.DimOffice.Office_Location 
ORDER BY Total_Sales DESC