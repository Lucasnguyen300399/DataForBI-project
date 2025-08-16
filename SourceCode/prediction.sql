USE AllSalesDB
GO
WITH MonthlySales AS (
    SELECT 
        dbo.DimOffice.Office_Location,
        dbo.DimTime.Date_Year,
        dbo.DimTime.Date_Month,
        CAST(SUM(dbo.SalesTransaction.Row_Total) AS decimal(10,2)) AS Total_Sales
    FROM 
        dbo.DimCustomer
        INNER JOIN dbo.SalesTransaction ON dbo.DimCustomer.Customer_Key = dbo.SalesTransaction.Customer_Key
        INNER JOIN dbo.DimOffice ON dbo.SalesTransaction.Office_Key = dbo.DimOffice.Office_Key
        INNER JOIN dbo.DimTime ON dbo.SalesTransaction.Sale_Date_Key = dbo.DimTime.Date_Key
    GROUP BY 
        dbo.DimOffice.Office_Location,
        dbo.DimTime.Date_Year,
        dbo.DimTime.Date_Month
),
MonthlySalesPercentage AS (
    SELECT 
        Office_Location,
        Date_Year, 
        Date_Month,
        Total_Sales,
        CAST(((Total_Sales - LAG(Total_Sales) OVER (PARTITION BY Office_Location ORDER BY Date_Year, Date_Month)) / LAG(Total_Sales) OVER (PARTITION BY Office_Location ORDER BY Date_Year, Date_Month)) * 100 AS decimal(10,2)) AS Sales_Percentage
    FROM 
        MonthlySales
),
AverageMonthlySalesPercentage AS (
    SELECT 
        Office_Location,
        CAST(AVG(Sales_Percentage) AS decimal(10,2)) AS Avg_Sales_Percentage
    FROM 
        MonthlySalesPercentage
    GROUP BY 
        Office_Location
)
SELECT 
    a.Office_Location,
    a.Avg_Sales_Percentage,
    CAST(b.Total_Sales * (1 + a.Avg_Sales_Percentage / 100) AS decimal(10,2)) AS Forecast_M1,
    CAST(b.Total_Sales * (1 + 2 * a.Avg_Sales_Percentage / 100) AS decimal(10,2)) AS Forecast_M2,
    CAST(b.Total_Sales * (1 + 3 * a.Avg_Sales_Percentage / 100) AS decimal(10,2)) AS Forecast_M3,
    CAST(b.Total_Sales * (1 + 4 * a.Avg_Sales_Percentage / 100) AS decimal(10,2)) AS Forecast_M4,
    CAST(b.Total_Sales * (1 + 5 * a.Avg_Sales_Percentage / 100) AS decimal(10,2)) AS Forecast_M5,
    CAST(b.Total_Sales * (1 + 6 * a.Avg_Sales_Percentage / 100) AS decimal(10,2)) AS Forecast_M6,
    CAST(b.Total_Sales * (1 + 7 * a.Avg_Sales_Percentage / 100) AS decimal(10,2)) AS Forecast_M7,
    CAST(b.Total_Sales * (1 + 8 * a.Avg_Sales_Percentage / 100) AS decimal(10,2)) AS Forecast_M8,
    CAST(b.Total_Sales * (1 + 9 * a.Avg_Sales_Percentage / 100) AS decimal(10,2)) AS Forecast_M9,
    CAST(b.Total_Sales * (1 + 10 * a.Avg_Sales_Percentage / 100) AS decimal(10,2)) AS Forecast_M10,
    CAST(b.Total_Sales * (1 + 11 * a.Avg_Sales_Percentage / 100) AS decimal(10,2)) AS Forecast_M11,
    CAST(b.Total_Sales * (1 + 12 * a.Avg_Sales_Percentage / 100) AS decimal(10,2)) AS Forecast_M12
FROM 
    AverageMonthlySalesPercentage a
    INNER JOIN MonthlySales b ON a.Office_Location = b.Office_Location
WHERE 
    b.Date_Year = (SELECT MAX(Date_Year) FROM MonthlySales) AND 
    b.Date_Month = (SELECT MAX(Date_Month) FROM MonthlySales WHERE Date_Year = (SELECT MAX(Date_Year) FROM MonthlySales))
ORDER BY 
    a.Office_Location;