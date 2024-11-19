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

-- Tạo chỉ số cho cột OrderDate trong bảng Orders
CREATE INDEX idx_OrderDate ON Orders (OrderDate);

-- Tạo chỉ số cho cột SaleDate trong bảng Sales
CREATE INDEX idx_SaleDate ON Sales (SaleDate);

-- Tạo view CustomerMonthlySales
CREATE OR REPLACE VIEW CustomerMonthlySales AS
SELECT 
    C.CustomerID,
    CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
    DATE_FORMAT(S.SaleDate, '%Y-%m') AS MonthYear,
    COALESCE(SUM(S.SaleAmount), 0) AS TotalSales
FROM 
    Customers C
JOIN 
    Sales S ON C.CustomerID = S.CustomerID
GROUP BY 
    C.CustomerID, CustomerName, MonthYear;

-- Truy vấn các khách hàng có tổng doanh thu trong tháng 2024-07 lớn hơn 2000
SELECT 
    CustomerID, 
    CustomerName, 
    MonthYear, 
    TotalSales
FROM 
    CustomerMonthlySales
WHERE 
    MonthYear = '2024-07' AND TotalSales > 2000
ORDER BY 
    TotalSales DESC;
