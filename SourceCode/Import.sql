USE AllSalesDB
GO
DROP TABLE IF EXISTS SalesData;
GO
CREATE TABLE [dbo].[SalesData]
(
    [Sale_Date] date NULL,
    [Receipt_ID] int NULL,
    [Customer_ID] nvarchar(255) NULL,
    [Customer_First_Name] nvarchar(255) NULL,
    [Customer_Surname] varchar(255) NULL,
    [Staff_ID] nvarchar(255) NULL,
    [Staff_First_Name] nvarchar(255) NULL,
    [Staff_Surname] nvarchar(255) NULL,
    [Staff_Office] int NULL,
    [Office_Location] nvarchar(255) NULL,
    [Receipt_Transaction_Row_ID] int NULL,
    [Item_ID] int NULL,
    [Item_Description] [nvarchar](255) NULL,
    [Item_Quantity] [int] NULL,
    [Item_Price] decimal(10, 2) NULL,
    [Row_Total] decimal(10, 2) NULL
)
INSERT INTO [dbo].[SalesData]
    (
    [Sale_Date],
    [Receipt_ID],
    [Customer_ID],
    [Customer_First_Name],
    [Customer_Surname],
    [Staff_ID],
    [Staff_First_Name],
    [Staff_Surname],
    [Staff_Office],
    [Office_Location],
    [Receipt_Transaction_Row_ID],
    [Item_ID],
    [Item_Description],
    [Item_Quantity],
    [Item_Price],
    [Row_Total]
    )
SELECT [Sale Date],
    [Receipt Id],
    [Customer ID],
    [Customer First Name],
    [Customer Surname],
    [Staff ID],
    [Staff First Name],
    [Staff Surname],
    [Staff office],
    [Office Location],
    [Reciept Transaction Row ID],
    [Item ID],
    [Item Description],
    [Item Quantity],
    [Item Price],
    [Row Total]
FROM [dbo].[SalesDataRaw]