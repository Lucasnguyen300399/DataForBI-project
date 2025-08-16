USE AllSalesDB
GO

WITH Score AS (
    SELECT 
        dbo.DimOffice.Office_Location,
        CAST(SUM(dbo.SalesTransaction.Row_Total) AS decimal(10,2)) / COUNT(DISTINCT dbo.DimStaff.Staff_ID) AS Avg_Sales_Per_Staff,
        CAST(SUM(dbo.SalesTransaction.Row_Total) AS decimal(10,2)) / COUNT(DISTINCT dbo.DimCustomer.Customer_Key) AS Avg_Sales_Per_Cus,
        CAST(((SUM(dbo.SalesTransaction.Row_Total) - LAG(SUM(dbo.SalesTransaction.Row_Total)) OVER (PARTITION BY dbo.DimOffice.Office_Location ORDER BY dbo.DimTime.Date_Year, dbo.DimTime.Date_Month)) / LAG(SUM(dbo.SalesTransaction.Row_Total)) OVER (PARTITION BY dbo.DimOffice.Office_Location ORDER BY dbo.DimTime.Date_Year, dbo.DimTime.Date_Month)) * 100 AS decimal(10,2)) / 12 AS Avg_Growth
    FROM 
        dbo.DimCustomer
        INNER JOIN dbo.SalesTransaction ON dbo.DimCustomer.Customer_Key = dbo.SalesTransaction.Customer_Key
        INNER JOIN dbo.DimItem ON dbo.SalesTransaction.Item_Key = dbo.DimItem.Item_Key
        INNER JOIN dbo.DimOffice ON dbo.SalesTransaction.Office_Key = dbo.DimOffice.Office_Key
        INNER JOIN dbo.DimStaff ON dbo.SalesTransaction.Staff_Key = dbo.DimStaff.Staff_Key
        INNER JOIN dbo.DimTime ON dbo.SalesTransaction.Sale_Date_Key = dbo.DimTime.Date_Key
    GROUP BY 
        dbo.DimOffice.Office_Location,
        dbo.DimTime.Date_Year,
        dbo.DimTime.Date_Month
)
SELECT 
    Office_Location,
    SUM(
        (CASE 
            WHEN Avg_Sales_Per_Staff BETWEEN 50000 AND 55000 THEN 1
            WHEN Avg_Sales_Per_Staff BETWEEN 55000 AND 60000 THEN 2
            WHEN Avg_Sales_Per_Staff BETWEEN 60000 AND 65000 THEN 3
            WHEN Avg_Sales_Per_Staff > 65000 THEN 4
            ELSE 0
        END * 0.5) +
        (CASE 
            WHEN Avg_Sales_Per_Cus BETWEEN 1500 AND 2000 THEN 1
            WHEN Avg_Sales_Per_Cus BETWEEN 2000 AND 2500 THEN 2
            WHEN Avg_Sales_Per_Cus BETWEEN 2500 AND 3000 THEN 3
            WHEN Avg_Sales_Per_Cus > 3000 THEN 4
            ELSE 0
        END * 0.2) +
        (CASE 
            WHEN Avg_Growth BETWEEN -100 AND 0 THEN 0
            WHEN Avg_Growth BETWEEN 0 AND 10 THEN 1
            WHEN Avg_Growth BETWEEN 10 AND 20 THEN 2
            WHEN Avg_Growth BETWEEN 20 AND 30 THEN 3
            ELSE 4
        END * 0.3)
    ) AS Total_Score
FROM 
    Score
GROUP BY 
    Office_Location
ORDER BY 
    Office_Location;