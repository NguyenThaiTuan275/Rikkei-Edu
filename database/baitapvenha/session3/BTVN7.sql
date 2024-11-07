USE btsession3;

-- Tạo bảng Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    JoinDate DATE NOT NULL
);

-- Tạo bảng Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- thêm dữ liệu
INSERT INTO Customers (CustomerID, CustomerName, Email, JoinDate)
VALUES (1, 'John Doe', 'johndoe@example.com', '2023-01-15'),
       (2, 'Jane Smith', 'janesmith@example.com', '2023-02-20'),
       (3, 'Emily Davis', 'emilydavis@example.com', '2023-03-25'),
       (4, 'Michael Brown', 'michaelbrown@example.com', '2023-04-10');

INSERT INTO Orders (OrderID, OrderDate, CustomerID, TotalAmount)
VALUES (1, '2023-10-01', 1, 150.00),
       (2, '2023-10-05', 2, 200.00),
       (3, '2023-10-10', 3, 300.00),
       (4, '2023-10-15', 1, 250.00),
       (5, '2023-10-20', 4, 100.00);

-- cập nhật dữ liệu
UPDATE Orders
SET TotalAmount = 350.00
WHERE OrderID = 3;

UPDATE Customers
SET Email = 'jane.newemail@example.com'
WHERE CustomerID = 2;

-- xóa dữ liệu
DELETE FROM Customers
WHERE CustomerID = 4;

DELETE FROM Orders
WHERE OrderID = 1;

-- truy vấn
SELECT Orders.OrderID, Orders.OrderDate, Orders.TotalAmount, Customers.CustomerName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

SELECT CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Orders
GROUP BY CustomerID;
