-- 1. CREATE DATABASE
IF DB_ID('Axia_Stores2') IS NOT NULL
    DROP DATABASE Axia_Stores2;
GO

CREATE DATABASE Axia_Stores2;
GO

USE Axia_Stores2;
GO

-- 2. CREATE TABLE: CustomerTB
CREATE TABLE CustomerTB (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(50)
);

-- INSERT INTO CustomerTB
INSERT INTO CustomerTB (CustomerID, FirstName, LastName, Email, Phone, City)
VALUES 
(1, 'Musa', 'Ahmed', 'musa.ahmed@hotmail.com', '0803-123-0001', 'Lagos'),
(2, 'Ray', 'Samson', 'ray.samson@yahoo.com', '0803-123-0002', 'Ibadan'),
(3, 'Chinedu', 'Okafor', 'chinedu.ok@yahoo.com', '0803-123-0003', 'Enugu'),
(4, 'Dare', 'Adewale', 'dare.ad@hotmail.com', '0803-123-0004', 'Abuja'),
(5, 'Efe', 'Ojo', 'efe.oj@gmail.com', '0803-123-0005', 'Port Harcourt'),
(6, 'Aisha', 'Bello', 'aisha.bello@hotmail.com', '0803-123-0006', 'Kano'),
(7, 'Tunde', 'Salami', 'tunde.salami@yahoo.com', '0803-123-0007', 'Ilorin'),
(8, 'Nneka', 'Umeh', 'nneka.umeh@gmail.com', '0803-123-0008', 'Owerri'),
(9, 'Kelvin', 'Peters', 'kelvin.peters@hotmail.com', '0803-123-0009', 'Asaba'),
(10, 'Blessing', 'Mark', 'blessing.mark@gmail.com', '0803-123-0010', 'Uyo');

-- 3. CREATE TABLE: ProductTB
CREATE TABLE ProductTB (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    UnitPrice DECIMAL(12, 2),
    StockQty INT
);

-- INSERT INTO ProductTB
INSERT INTO ProductTB (ProductID, ProductName, Category, UnitPrice, StockQty)
VALUES
(1, 'Wireless Mouse', 'Accessories', 7500.00, 120),
(2, 'USB-C Charger 65W', 'Electronics', 14500.00, 75),
(3, 'Noise-Cancel Headset', 'Audio', 85500.00, 50),
(4, '27" 4K Monitor', 'Displays', 185000.00, 20),
(5, 'Laptop Stand', 'Accessories', 19500.00, 90),
(6, 'Bluetooth Speaker', 'Audio', 52000.00, 60),
(7, 'Mechanical Keyboard', 'Accessories', 18500.00, 40),
(8, 'WebCam 1080p', 'Electronics', 25000.00, 55),
(9, 'Smartwatch Series 5', 'Wearables', 320000.00, 30),
(10, 'Portable SSD 1TB', 'Storage', 125000.00, 35);

-- 4. CREATE TABLE: OrdersTB
CREATE TABLE OrdersTB (
    OrderID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES CustomerTB(CustomerID),
    ProductID INT FOREIGN KEY REFERENCES ProductTB(ProductID),
    OrderDate DATE,
    Quantity INT
);

-- INSERT INTO OrdersTB
INSERT INTO OrdersTB (OrderID, CustomerID, ProductID, OrderDate, Quantity)
VALUES
(1001, 1, 3, '2025-06-01', 1),
(1002, 2, 1, '2025-06-03', 2),
(1003, 3, 5, '2025-06-05', 1),
(1004, 4, 4, '2025-06-10', 1),
(1005, 5, 2, '2025-06-12', 3),
(1006, 6, 7, '2025-06-15', 1),
(1007, 7, 6, '2025-06-18', 2),
(1008, 8, 8, '2025-06-20', 1),
(1009, 9, 9, '2025-06-22', 1),
(1010, 10, 10, '2025-06-25', 2);

-- 5. QUERIES

-- a. FirstName and Email of customers who bought "Wireless Mouse"
SELECT DISTINCT C.FirstName, C.Email
FROM CustomerTB C
JOIN OrdersTB O ON C.CustomerID = O.CustomerID
JOIN ProductTB P ON O.ProductID = P.ProductID
WHERE P.ProductName = 'Wireless Mouse';

-- b. List all customers’ full names in ascending alphabetical order
SELECT LastName + ' ' + FirstName AS FullName
FROM CustomerTB
ORDER BY LastName ASC, FirstName ASC;

-- c. Every order with customer name, product, quantity, unit price, total price, and date
SELECT 
    O.OrderID,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    P.ProductName,
    O.Quantity,
    P.UnitPrice,
    (O.Quantity * P.UnitPrice) AS TotalPrice,
    O.OrderDate
FROM OrdersTB O
JOIN CustomerTB C ON O.CustomerID = C.CustomerID
JOIN ProductTB P ON O.ProductID = P.ProductID
ORDER BY O.OrderDate;

-- d. Average sales per product category, descending
SELECT 
    P.Category,
    AVG(O.Quantity * P.UnitPrice) AS AverageSales
FROM OrdersTB O
JOIN ProductTB P ON O.ProductID = P.ProductID
GROUP BY P.Category
ORDER BY AverageSales DESC;

-- e. City with the highest revenue
SELECT TOP 1 
    C.City,
    SUM(O.Quantity * P.UnitPrice) AS TotalRevenue
FROM OrdersTB O
JOIN CustomerTB C ON O.CustomerID = C.CustomerID
JOIN ProductTB P ON O.ProductID = P.ProductID
GROUP BY C.City
ORDER BY TotalRevenue DESC;
