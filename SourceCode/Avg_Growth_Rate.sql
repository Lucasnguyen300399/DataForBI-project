USE AllSalesDB
GO
WITH
    MonthlySales
    AS
    (
        SELECT dbo.DimOffice.Office_Location,
            dbo.DimTime.Date_Year,
            dbo.DimTime.Date_Month,
            CAST(
                SUM(dbo.SalesTransaction.Row_Total) AS decimal(10, 2)
            ) AS Total_Sales
        FROM dbo.DimCustomer
            INNER JOIN dbo.SalesTransaction ON dbo.DimCustomer.Customer_Key = dbo.SalesTransaction.Customer_Key
            INNER JOIN dbo.DimOffice ON dbo.SalesTransaction.Office_Key = dbo.DimOffice.Office_Key
            INNER JOIN dbo.DimTime ON dbo.SalesTransaction.Sale_Date_Key = dbo.DimTime.Date_Key
        GROUP BY dbo.DimOffice.Office_Location,
            dbo.DimTime.Date_Year,
            dbo.DimTime.Date_Month
    ),
    MonthlySalesGrowth
    AS
    (
        SELECT Office_Location,
            Date_Year,
            Date_Month,
            Total_Sales,
            CAST(
                (
                    Total_Sales - LAG(Total_Sales) OVER (
                        PARTITION BY Office_Location
                        ORDER BY Date_Year,
                            Date_Month
                    )
                ) / LAG(Total_Sales) OVER (
                    PARTITION BY Office_Location
                    ORDER BY Date_Year,
                        Date_Month
                ) * 100 AS decimal(5, 2)
            ) AS Sales_Percentage_Difference
        FROM MonthlySales
    )
SELECT Office_Location,
    CAST(
        AVG(Sales_Percentage_Difference) AS decimal(5, 2)
    ) AS Average_Growth_Rate
FROM MonthlySalesGrowth
GROUP BY Office_Location
ORDER BY Office_Location;