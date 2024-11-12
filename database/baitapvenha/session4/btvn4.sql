
-- tạo bảng
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

-- Truy vấn để tìm sản phẩm có giá cao nhất và thấp nhất
SELECT 
    ProductName,
    Price
FROM 
    Products
WHERE 
    Price = (SELECT MAX(Price) FROM Products)
    OR 
    Price = (SELECT MIN(Price) FROM Products);
