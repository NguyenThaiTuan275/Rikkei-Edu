-- create database BTVN5;
use BTVN5;

-- Tạo bảng Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL
);

-- Tạo bảng Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL ,
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)  
);

-- Chèn 3 sản phẩm vào bảng Products
INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUES 
('Laptop Dell XPS 13', 'Electronics', 1200.99, 15),
('Bàn làm việc gỗ', 'Furniture', 250.50, 30),
('Đèn bàn LED', 'Home Decor', 45.00, 50);

-- Chèn 2 đơn hàng vào bảng Orders
INSERT INTO Orders (OrderDate, ProductID, Quantity, TotalAmount)
VALUES 
('2024-11-01', 1, 2, 2401.98),  -- Giả định ProductID 1 là Laptop
('2024-11-02', 2, 1, 250.50);    -- Giả định ProductID 2 là Bàn làm việcOrderID

-- Cập nhật giá của sản phẩm có ProductID = 1
UPDATE Products SET Price = 1150.99 WHERE ProductID = 1;

-- Cập nhật TotalAmount trong bảng Orders cho MySQL
UPDATE Orders o
JOIN Products p ON o.ProductID = p.ProductID
SET o.TotalAmount = o.Quantity * p.Price
WHERE o.OrderID IS NOT NULL;  -- Điều kiện này đảm bảo có một giá trị cho OrderID


