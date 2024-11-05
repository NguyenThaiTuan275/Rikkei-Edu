-- create database btvn6;

use btvn6;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)  -- Giả định bảng Products đã tồn tại
);

-- Chèn 2 khách hàng vào bảng Customers
INSERT INTO Customers (CustomerName, Email, Phone)
VALUES 
('Nguyen Van A', 'nguyenvana@example.com', '0123456789'),
('Tran Thi B', 'tranthib@example.com', '0987654321');

-- Chèn 3 đơn hàng vào bảng Orders
INSERT INTO Orders (OrderDate, CustomerID)
VALUES 
('2024-11-01', 1),
('2024-11-02', 2),
('2024-11-03', 1);

-- Chèn 5 chi tiết đơn hàng vào bảng OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES 
(1, 1, 2, 1200.99),   -- Đơn hàng 1, sản phẩm 1
(1, 2, 1, 250.50),    -- Đơn hàng 1, sản phẩm 2
(2, 3, 3, 45.00),     -- Đơn hàng 2, sản phẩm 3
(2, 1, 1, 1200.99),   -- Đơn hàng 2, sản phẩm 1
(3, 2, 2, 250.50);    -- Đơn hàng 3, sản phẩm 2

-- Cập nhật số điện thoại của khách hàng có CustomerID = 1
UPDATE Customers
SET Phone = '0912345678'
WHERE CustomerID = 1;

-- Xóa các đơn hàng của khách hàng không còn tồn tại trong bảng Customers
DELETE FROM Orders
WHERE CustomerID NOT IN (SELECT CustomerID FROM Customers);

SELECT 
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.CustomerName;

SELECT 
    od.OrderID,
    p.ProductName,
    od.Quantity,
    (od.Quantity * od.UnitPrice) AS TotalAmount
FROM 
    OrderDetails od
JOIN 
    Products p ON od.ProductID = p.ProductID
ORDER BY 
    od.OrderID;


