USE btsession3;

-- Tạo bảng Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactEmail VARCHAR(100) NOT NULL 
);

-- Tạo bảng Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    SupplierID INT,
    Stock INT NOT NULL DEFAULT 0, 
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- thêm dữ liệu
INSERT INTO Suppliers (SupplierID, SupplierName, ContactEmail)
VALUES (1, 'ABC Supplies', 'abc@supplies.com'),
       (2, 'XYZ Distributors', 'xyz@distributors.com'),
       (3, 'Global Traders', 'global@traders.com');

INSERT INTO Products (ProductID, ProductName, Price, SupplierID, Stock)
VALUES (1, 'Laptop', 899.99, 1, 50),
       (2, 'Keyboard', 45.99, 1, 150),
       (3, 'Monitor', 199.99, 2, 70),
       (4, 'Mouse', 15.99, 3, 200);

-- cập nhật dữ liệu
UPDATE Products
SET Price = 45.99
WHERE ProductID = 2;

UPDATE Suppliers
SET SupplierName = 'ABC Electronics'
WHERE SupplierID = 1;

-- xóa dữ liệu
DELETE FROM Suppliers
WHERE SupplierID = 3;

DELETE FROM Products
WHERE ProductID = 4;

-- truy vấn
SELECT Products.ProductID, Products.ProductName, Products.Price, Products.Stock, Suppliers.SupplierName
FROM Products
JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID;

