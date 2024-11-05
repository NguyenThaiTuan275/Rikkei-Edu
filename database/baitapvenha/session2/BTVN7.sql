-- create database btvn7;

use btvn7;
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

-- câu lệnh T-SQL để tìm tổng doanh thu theo danh mục sản phẩm trong quý gần nhất
SELECT 
    p.Category,
    SUM(sd.Quantity * sd.UnitPrice) AS TotalRevenue
FROM 
    Sales s
JOIN 
    SalesDetails sd ON s.SaleID = sd.SaleID
JOIN 
    Products p ON sd.ProductID = p.ProductID
WHERE 
    DATEPART(QUARTER, s.SaleDate) = DATEPART(QUARTER, GETDATE()) - 1
    AND DATEPART(YEAR, s.SaleDate) = DATEPART(YEAR, GETDATE())
GROUP BY 
    p.Category
ORDER BY 
    TotalRevenue DESC;

-- Xác định danh mục sản phẩm nào có doanh thu cao nhất và hiển thị thông tin về doanh thu tổng cộng của danh mục đó.
WITH CategoryRevenue AS (
    SELECT 
        p.Category,
        SUM(sd.Quantity * sd.UnitPrice) AS TotalRevenue
    FROM 
        Sales s
    JOIN 
        SalesDetails sd ON s.SaleID = sd.SaleID
    JOIN 
        Products p ON sd.ProductID = p.ProductID
    GROUP BY 
        p.Category
)
SELECT 
    Category,
    TotalRevenue
FROM 
    CategoryRevenue
ORDER BY 
    TotalRevenue DESC
LIMIT 1;  -- Nếu hệ quản trị CSDL không hỗ trợ LIMIT, dùng TOP 1 hoặc FETCH FIRST 1 ROWS ONLY

