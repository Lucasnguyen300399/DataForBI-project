-- Total sale per total customer per office
USE AllSalesDB
GO
SELECT dbo.DimOffice.Office_Location,
    COUNT(DISTINCT dbo.DimCustomer.Customer_ID) AS Number_of_Customer,
    CAST(
        SUM(dbo.SalesTransaction.Row_Total) AS decimal(10, 2)
    ) AS Total_Sales,
    CAST(
        (
            SUM(dbo.SalesTransaction.Row_Total) / COUNT(DISTINCT dbo.DimCustomer.Customer_Key)
        ) AS decimal(10, 2)
    ) AS Average_Sales_Per_Customer
FROM dbo.DimCustomer
    INNER JOIN dbo.SalesTransaction ON dbo.DimCustomer.Customer_Key = dbo.SalesTransaction.Customer_Key
    INNER JOIN dbo.DimOffice ON dbo.SalesTransaction.Office_Key = dbo.DimOffice.Office_Key
GROUP BY dbo.DimOffice.Office_Location
ORDER BY Average_Sales_Per_Customer DESC