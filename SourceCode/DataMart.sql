USE AllSalesDB
GO

DROP TABLE IF EXISTS SalesTransaction;
DROP TABLE IF EXISTS DimTime;
DROP TABLE IF EXISTS DimCustomer;
DROP TABLE IF EXISTS DimStaff;
DROP TABLE IF EXISTS DimItem;
DROP TABLE IF EXISTS DimOffice;
GO
CREATE TABLE DimTime
(
    Date_Key int identity NOT NULL,
    Date_ID date NOT NULL,
    Date_Month int NULL,
    Date_Quarter int NULL,
    Date_Year int NULL,
    PRIMARY KEY (Date_Key)
)
CREATE TABLE DimCustomer
(
    Customer_Key int identity NOT NULL,
    Customer_ID nvarchar(255) NOT NULL,
    Customer_First_Name nvarchar(255) NULL,
    Customer_Surname nvarchar(255) NULL,
    PRIMARY KEY (Customer_Key)
)
CREATE TABLE DimStaff
(
    Staff_Key int identity NOT NULL,
    Staff_ID nvarchar(255) NULL,
    Staff_First_Name nvarchar(255) NULL,
    Staff_Surname nvarchar(255) NULL,
    PRIMARY KEY (Staff_Key)
)
CREATE TABLE DimOffice
(
    Office_Key int identity NOT NULL,
    Staff_Office int NOT NULL,
    Office_Location nvarchar(255) NULL,
    PRIMARY KEY (Office_Key)
)
CREATE TABLE DimItem
(
    Item_Key int identity NOT NULL,
    Item_ID int NULL,
    Item_Description nvarchar(255) NULL,
    Item_Price decimal(10, 2) NULL,
    PRIMARY KEY (Item_Key)
)
CREATE TABLE SalesTransaction
(
    Sale_Key int identity NOT NULL,
    Receipt_ID int NULL,
    Sale_Date_Key int NULL,
    Customer_Key int NULL,
    Staff_Key int NULL,
    Office_Key int NULL,
    Receipt_Transaction_Row_ID int NULL,
    Item_Key int NULL,
    Item_Quantity int NULL,
    Row_Total float NOT NULL,
    PRIMARY KEY (Sale_Key),
    FOREIGN KEY (Sale_Date_Key) REFERENCES DimTime (Date_Key),
    FOREIGN KEY (Customer_Key) REFERENCES DimCustomer (Customer_Key),
    FOREIGN KEY (Staff_Key) REFERENCES DimStaff (Staff_Key),
    FOREIGN KEY (Office_Key) REFERENCES DimOffice (Office_Key),
    FOREIGN KEY (Item_Key) REFERENCES DimItem (Item_Key)
)
GO