
-- tạo bảng
CREATE TABLE Regions (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    RegionID INT,
    SaleDate DATE,
    Quantity INT,
    Amount DECIMAL(10, 2),  -- Cột Amount thay cho Price
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

-- Truy vấn để phân tích hiệu suất bán hàng theo khu vực
SELECT 
    Regions.RegionName,
    SUM(Sales.Amount) AS TotalRevenue,  -- Tổng doanh thu
    SUM(Sales.Quantity) AS TotalQuantitySold,  -- Tổng số lượng bán
    (SELECT TOP 1 
         Products.ProductName
     FROM 
         Sales 
     JOIN 
         Products ON Sales.ProductID = Products.ProductID
     WHERE 
         Sales.RegionID = Regions.RegionID
     GROUP BY 
         Products.ProductName
     ORDER BY 
         SUM(Sales.Quantity) DESC) AS BestSellingProduct
FROM 
    Sales
JOIN 
    Regions ON Sales.RegionID = Regions.RegionID
GROUP BY 
    Regions.RegionID, Regions.RegionName
ORDER BY 
    TotalRevenue DESC;
