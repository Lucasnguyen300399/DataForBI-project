-- Total sale per total employee per office
USE AllSalesDB
GO
SELECT dbo.DimOffice.Office_Location,
    COUNT(DISTINCT dbo.DimStaff.Staff_ID) AS Number_of_Staff,
    CAST(
        SUM(dbo.SalesTransaction.Row_Total) AS decimal(10, 2)
    ) AS Total_Sales,
    CAST((SUM(dbo.SalesTransaction.Row_Total) / COUNT(DISTINCT dbo.DimStaff.Staff_ID)) AS decimal(10,2)) AS Average_Sales_Per_Staff
    
FROM dbo.DimCustomer
    INNER JOIN dbo.SalesTransaction ON dbo.DimCustomer.Customer_Key = dbo.SalesTransaction.Customer_Key
    INNER JOIN dbo.DimOffice ON dbo.SalesTransaction.Office_Key = dbo.DimOffice.Office_Key
    INNER JOIN dbo.DimStaff ON dbo.SalesTransaction.Staff_Key = dbo.DimStaff.Staff_Key
GROUP BY dbo.DimOffice.Office_Location
ORDER BY Average_Sales_Per_Staff DESC
