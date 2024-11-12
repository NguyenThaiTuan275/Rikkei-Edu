CREATE DATABASE btvn;
USE btvn;

-- tạo bảng
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Truy vấn danh sách đơn hàng cùng với tên và email khách hàng
SELECT 
    Orders.OrderID,
    Orders.OrderDate,
    Customers.CustomerName,
    Customers.Email
FROM 
    Orders
JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID;


