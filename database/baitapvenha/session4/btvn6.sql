
-- tạo bảng
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    SaleDate DATE,
    Price DECIMAL(10, 2)
);

-- Truy vấn tổng hợp doanh thu theo tháng
SELECT 
    YEAR(SaleDate) AS Year,
    MONTH(SaleDate) AS Month,
    SUM(Price) AS TotalRevenue,
    COUNT(SaleID) AS OrderCount,
    AVG(Price) AS AverageRevenuePerOrder
FROM 
    Sales
GROUP BY 
    YEAR(SaleDate), MONTH(SaleDate)
ORDER BY 
    Year, Month;
