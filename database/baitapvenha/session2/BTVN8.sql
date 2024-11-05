-- create database btvn8;

use btvn8;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL
);
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    SaleDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)  -- Giả định bảng Customers đã tồn tại
);
CREATE TABLE SalesDetails (
    SalesDetailID INT PRIMARY KEY AUTO_INCREMENT,
    SaleID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- câu lệnh T-SQL để tính toán doanh thu hàng tháng của năm trước
SELECT 
    MONTH(SaleDate) AS SaleMonth,
    SUM(TotalAmount) AS TotalRevenue
FROM 
    Sales
WHERE 
    YEAR(SaleDate) = YEAR(GETDATE()) - 1  -- Lấy dữ liệu của năm trước
GROUP BY 
    MONTH(SaleDate)
ORDER BY 
    SaleMonth;

-- Tính doanh thu dự báo cho tháng hiện tại dựa trên tháng tương ứng năm trước
SELECT 
    SUM(TotalAmount) * 1.05 AS PredictedRevenue  -- Áp dụng hệ số tăng trưởng 5%
FROM 
    Sales
WHERE 
    YEAR(SaleDate) = YEAR(GETDATE()) - 1
    AND MONTH(SaleDate) = MONTH(GETDATE());
