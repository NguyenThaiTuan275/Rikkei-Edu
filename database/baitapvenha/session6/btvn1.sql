-- Tạo cơ sở dữ liệu SalesDB
CREATE DATABASE SalesDB3;
USE SalesDB3;

-- Bảng Customers
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);

-- Bảng Promotions
CREATE TABLE Promotions (
    PromotionID INT AUTO_INCREMENT PRIMARY KEY,
    PromotionName VARCHAR(100) NOT NULL,
    DiscountPercentage DECIMAL(5, 2) NOT NULL
);

-- Bảng Products
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    PromotionID INT,
    FOREIGN KEY (PromotionID) REFERENCES Promotions(PromotionID)
);

-- Bảng Orders
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Bảng Sales
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Tạo chỉ số (indexes) để cải thiện hiệu suất truy vấn
CREATE INDEX idx_OrderID ON Sales(OrderID);
CREATE INDEX idx_SaleDate ON Sales(SaleDate);

CREATE INDEX idx_CustomerID ON Orders(CustomerID);
CREATE INDEX idx_OrderDate ON Orders(OrderDate);

CREATE INDEX idx_OrderID_OrderDetails ON OrderDetails(OrderID);
CREATE INDEX idx_ProductID_OrderDetails ON OrderDetails(ProductID);

CREATE INDEX idx_PromotionID_Products ON Products(PromotionID);

CREATE INDEX idx_Email_Customers ON Customers(Email);

-- Xây dựng một stored procedure nhận đầu vào là CustomerID, startDate, và endDate 
-- để tính tổng doanh thu của khách hàng trong khoảng thời gian đó.
DELIMITER //

CREATE PROCEDURE GetCustomerTotalRevenue (
    IN inCustomerID INT,       -- ID của khách hàng
    IN inStartDate DATE,       -- Ngày bắt đầu
    IN inEndDate DATE          -- Ngày kết thúc
)
BEGIN
    DECLARE totalRevenue DECIMAL(10, 2);  -- Biến lưu tổng doanh thu

    -- Tính tổng doanh thu
    SELECT SUM(S.SaleAmount) INTO totalRevenue
    FROM Sales S
    JOIN Orders O ON S.OrderID = O.OrderID
    WHERE O.CustomerID = inCustomerID
      AND S.SaleDate BETWEEN inStartDate AND inEndDate;

    -- Trả kết quả
    SELECT IFNULL(totalRevenue, 0) AS TotalRevenue;
END //

DELIMITER ;


