USE btsession3;

-- Tạo bảng Invoices
CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY,
    InvoiceName VARCHAR(100) NOT NULL,
    InvoiceDate DATETIME
);

-- Tạo bảng InvoiceDetails
CREATE TABLE InvoiceDetails (
    DetailID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    InvoiceID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID)
);

-- Tạo bảng Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

-- thêm dữ liệu
INSERT INTO Products (ProductID, ProductName, Price)
VALUES
(1, 'Sản phẩm A', 50.00),
(2, 'Sản phẩm B', 30.00),
(3, 'Sản phẩm C', 20.00);

INSERT INTO Invoices (InvoiceID, InvoiceName, InvoiceDate)
VALUES
(1, 'Hóa đơn 001', '2024-11-01'),
(2, 'Hóa đơn 002', '2024-11-02');

INSERT INTO InvoiceDetails (DetailID, ProductID, InvoiceID, Quantity, Price)
VALUES
(1, 1, 1, 5, 50.00),  -- Hóa đơn 1, sản phẩm 1, số lượng 5
(2, 2, 1, 3, 30.00),  -- Hóa đơn 1, sản phẩm 2, số lượng 3
(3, 2, 2, 2, 30.00),  -- Hóa đơn 2, sản phẩm 2, số lượng 2
(4, 3, 2, 4, 20.00);  -- Hóa đơn 2, sản phẩm 3, số lượng 4

-- cập nhật dữ liệu
UPDATE Products
SET Price = 55.00
WHERE ProductID = 1;

UPDATE InvoiceDetails
SET Quantity = 10
WHERE DetailID = 2;

-- xóa dữ liệu
DELETE FROM Products
WHERE ProductID = 3;

DELETE FROM InvoiceDetails
WHERE DetailID = 1;

-- truy vấn
SELECT i.InvoiceID, SUM(id.Quantity * id.Price) AS TotalAmount
FROM Invoices i
JOIN InvoiceDetails id ON i.InvoiceID = id.InvoiceID
GROUP BY i.InvoiceID;

SELECT i.InvoiceID, p.ProductName, id.Quantity, id.Price
FROM Invoices i
JOIN InvoiceDetails id ON i.InvoiceID = id.InvoiceID
JOIN Products p ON id.ProductID = p.ProductID
ORDER BY i.InvoiceID;

