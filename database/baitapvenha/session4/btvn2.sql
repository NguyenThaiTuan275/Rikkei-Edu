
-- tạo bảng
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    Amount DECIMAL(10, 2)
);

-- Truy vấn đếm số lượng đơn hàng cho mỗi sản phẩm
SELECT 
    ProductID,
    COUNT(SaleID) AS OrderCount
FROM 
    Sales
GROUP BY 
    ProductID;
