CREATE DATABASE SalesDB;
USE SalesDB;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY, 
    CustomerName VARCHAR(100) NOT NULL,       
    Email VARCHAR(100) NOT NULL UNIQUE,     
    Phone VARCHAR(15),                        
    CreatedAt DATETIME                       
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY, 
    ProductName VARCHAR(255) NOT NULL,        
    Category VARCHAR(255),                    
    Price DECIMAL(10, 2) NOT NULL             
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,   
    CustomerID INT NOT NULL,                 
    OrderDate DATETIME NOT NULL,              
    TotalAmount DECIMAL(10, 2),             
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) 
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY, 
    OrderID INT NOT NULL,                         
    ProductID INT NOT NULL,                       
    Quantity INT NOT NULL,                        
    UnitPrice DECIMAL(10, 2) NOT NULL,            
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE, 
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Hãy tạo một view CustomerOrders với các cột: OrderID, CustomerName (họ và tên của khách hàng), OrderDate, TotalAmount.
CREATE VIEW CustomerOrders AS
SELECT 
    Orders.OrderID,
    Customers.CustomerName,
    Orders.OrderDate,
    Orders.TotalAmount
FROM 
    Orders
JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID;
