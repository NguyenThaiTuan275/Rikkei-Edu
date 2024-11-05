USE companydb;

-- Tạo bảng Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL
);

-- Chèn 3 bản ghi vào bảng Products
INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUES 
('Laptop Dell XPS 13', 'Electronics', 1200.99, 15),
('Bàn làm việc gỗ', 'Furniture', 250.50, 30),
('Đèn bàn LED', 'Home Decor', 45.00, 50);