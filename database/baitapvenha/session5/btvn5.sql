CREATE DATABASE SalesDB1;
USE SalesDB1;

-- Bảng Customers
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY, 
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,     
    Email VARCHAR(100) NOT NULL UNIQUE                       
);

-- Bảng Products
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY, 
    ProductName VARCHAR(255) NOT NULL,        
    Price DECIMAL(10, 2) NOT NULL             
);

-- Bảng Orders
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,   
    CustomerID INT NOT NULL,                 
    OrderDate DATETIME NOT NULL,              
    TotalAmount DECIMAL(10, 2),             
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) 
);

-- Bảng OrderItems
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY, 
    OrderID INT NOT NULL,                         
    ProductID INT NOT NULL,                       
    Quantity INT NOT NULL,                        
    Price DECIMAL(10, 2) NOT NULL,            
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE, 
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Bảng Sales
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY, 
    OrderID INT NOT NULL,                
    SaleDate DATETIME NOT NULL,          
    SaleAmount DECIMAL(10, 2) NOT NULL,  
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
);

-- Thêm chỉ số
CREATE INDEX idx_Email ON Customers (Email);
CREATE INDEX idx_OrderDate ON Orders (OrderDate);
CREATE INDEX idx_OrderID ON OrderItems (OrderID);
CREATE INDEX idx_SaleDate ON Sales (SaleDate);

-- View CustomerOrderSummary
CREATE OR REPLACE VIEW CustomerOrderSummary AS
SELECT 
    Customers.CustomerID,
    CONCAT(Customers.firstName, ' ', Customers.lastName) AS CustomerName,
    COUNT(Orders.OrderID) AS TotalOrders,
    COALESCE(SUM(Orders.TotalAmount), 0) AS TotalAmountSpent
FROM 
    Customers
LEFT JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
LEFT JOIN 
    Sales ON Orders.OrderID = Sales.OrderID
GROUP BY 
    Customers.CustomerID, CustomerName;

-- Truy vấn khách hàng có tổng doanh thu vượt 5000
SELECT 
    CustomerID, 
    CustomerName, 
    TotalOrders, 
    TotalAmountSpent
FROM 
    CustomerOrderSummary
WHERE 
    TotalAmountSpent > 5000 OR TotalSaleAmount > 5000;
