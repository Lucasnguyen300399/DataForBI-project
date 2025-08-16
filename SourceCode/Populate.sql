USE AllSalesDB
GO

INSERT INTO DimTime
    (Date_ID, Date_Month, Date_Quarter, Date_Year)
SELECT DISTINCT CAST([SalesData].[Sale_Date] AS DATE),
    DATEPART(MONTH, [SalesData].[Sale_Date]),
    DATEPART(QUARTER, [SalesData].[Sale_Date]),
    DATEPART(YEAR, [SalesData].[Sale_Date])
FROM [dbo].[SalesData]
INSERT INTO DimCustomer
    (
    Customer_ID,
    Customer_First_Name,
    Customer_Surname
    )
SELECT DISTINCT [SalesData].[Customer_ID],
    [SalesData].[Customer_First_Name],
    [SalesData].[Customer_Surname]
FROM [dbo].[SalesData]
INSERT INTO DimStaff
    (Staff_ID, Staff_First_Name, Staff_Surname)
SELECT DISTINCT [SalesData].[Staff_ID],
    [SalesData].[Staff_First_Name],
    [SalesData].[Staff_Surname]
FROM [dbo].[SalesData]
INSERT INTO DimOffice
    (Staff_Office, Office_Location)
SELECT DISTINCT [SalesData].[Staff_Office],
    [SalesData].[Office_Location]
FROM [dbo].[SalesData]
INSERT INTO DimItem
    (Item_ID, Item_Description, Item_Price)
SELECT DISTINCT [SalesData].[Item_ID],
    [SalesData].[Item_Description],
    [SalesData].[Item_Price]
FROM [dbo].[SalesData]
INSERT INTO SalesTransaction
    (
    Receipt_ID,
    Sale_Date_Key,
    Customer_Key,
    Staff_Key,
    Office_Key,
    Receipt_Transaction_Row_ID,
    Item_Key,
    Item_Quantity,
    Row_Total
    )
SELECT DISTINCT x.[Receipt_ID],
    d.Date_Key,
    c.Customer_Key,
    s.Staff_Key,
    o.Office_Key,
    x.[Receipt_Transaction_Row_ID],
    i.Item_Key,
    x.[Item_Quantity],
    x.[Row_Total]
FROM [dbo].[SalesData] x
    LEFT JOIN DimStaff s ON s.Staff_ID = x.[Staff_ID]
    LEFT JOIN DimOffice o ON o.Staff_Office = x.[Staff_Office]
    LEFT JOIN DimCustomer c ON c.Customer_ID = x.[Customer_ID]
    LEFT JOIN DimItem i ON i.Item_ID = x.[Item_ID]
    LEFT JOIN DimTime d ON d.Date_ID = x.[Sale_Date]