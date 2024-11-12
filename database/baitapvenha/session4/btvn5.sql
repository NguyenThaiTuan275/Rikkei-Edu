-- tạo bảng
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Truy vấn lấy danh sách sản phẩm với tổng số lượng bán được
SELECT 
    Products.ProductID,
    Products.ProductName,
    SUM(OrderDetails.Quantity) AS TotalQuantitySold
FROM 
    OrderDetails
JOIN 
    Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY 
    Products.ProductID, Products.ProductName
ORDER BY 
    TotalQuantitySold DESC;
