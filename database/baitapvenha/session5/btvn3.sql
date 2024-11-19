CREATE DATABASE SalesDB1;
USE SalesDB1;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY, 
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,     
    Email VARCHAR(100) NOT NULL UNIQUE                       
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY, 
    ProductName VARCHAR(255) NOT NULL,        
    Price DECIMAL(10, 2) NOT NULL             
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,   
    CustomerID INT NOT NULL,                 
    OrderDate DATETIME NOT NULL,              
    TotalAmount DECIMAL(10, 2),             
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) 
);

CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY, 
    OrderID INT NOT NULL,                         
    ProductID INT NOT NULL,                       
    Quantity INT NOT NULL,                        
    Price DECIMAL(10, 2) NOT NULL,            
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE, 
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Tạo chỉ số cho cột OrderID trong bảng OrderItems
CREATE INDEX idx_OrderID ON OrderItems (OrderID);
