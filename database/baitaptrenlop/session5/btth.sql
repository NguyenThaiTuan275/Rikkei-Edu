CREATE DATABASE view_index;
USE view_index;

-- Bảng Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    ContactName VARCHAR(255),
    Country VARCHAR(50)
);

-- Bảng Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Bảng Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Price DECIMAL(10, 2)
);

-- Bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers (CustomerID, CustomerName, ContactName, Country)
VALUES
    (1, 'John Doe', 'John', 'USA'),
    (2, 'Jane Smith', 'Jane', 'Canada'),
    (3, 'Alice Johnson', 'Alice', 'UK'),
    (4, 'Michael Brown', 'Michael', 'Australia'),
    (5, 'Emily Davis', 'Emily', 'France');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
    (1, 1, '2024-11-01', 150.00),
    (2, 2, '2024-11-02', 200.00),
    (3, 3, '2024-11-03', 75.50),
    (4, 4, '2024-11-04', 120.75),
    (5, 5, '2024-11-05', 300.00);

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
    (1, 'Laptop', 1000.00),
    (2, 'Smartphone', 500.00),
    (3, 'Tablet', 300.00),
    (4, 'Headphones', 100.00),
    (5, 'Charger', 20.00);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (1, 1, 1, 1, 1000.00),  -- Order 1: 1 Laptop
    (2, 2, 2, 2, 500.00),   -- Order 2: 2 Smartphones
    (3, 3, 3, 1, 300.00),   -- Order 3: 1 Tablet
    (4, 4, 4, 3, 100.00),   -- Order 4: 3 Headphones
    (5, 5, 5, 5, 20.00);    -- Order 5: 5 Chargers

-- Tạo view hiển thị thông tin đơn hàng
CREATE VIEW `Thông tin đơn hàng` AS 
SELECT 
    Orders.OrderID,
    Orders.OrderDate,
    Orders.TotalAmount,
    Customers.CustomerID,
    Customers.CustomerName,
    Customers.ContactName,
    Customers.Country
FROM 
    Orders
JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID;

-- Tạo view hiển thị chi tiết đơn hàng
CREATE VIEW `chi tiết đơn hàng` AS
SELECT 
    OrderDetails.OrderDetailID,
    Orders.OrderID,
    Orders.OrderDate,
    Products.ProductID,
    Products.ProductName,
    OrderDetails.Quantity,
    OrderDetails.UnitPrice,
    (OrderDetails.Quantity * OrderDetails.UnitPrice) AS TotalPrice
FROM 
    OrderDetails
JOIN 
    Orders ON OrderDetails.OrderID = Orders.OrderID
JOIN 
    Products ON OrderDetails.ProductID = Products.ProductID;

-- Tạo chỉ mục cho bảng Orders
CREATE INDEX idx_orders_orderdate ON Orders(OrderDate);

-- Tạo chỉ mục cho bảng OrderDetails
CREATE INDEX idx_orderdetails_orderid ON OrderDetails(OrderID);
