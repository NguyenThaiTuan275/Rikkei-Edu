-- Tạo cơ sở dữ liệu SaleDB
CREATE DATABASE SaleDB;
USE SaleDB;

-- Tạo bảng customers
CREATE TABLE `customers` (
  `CustomerID` INT AUTO_INCREMENT, -- Thêm AUTO_INCREMENT cho khóa chính
  `CustomerName` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(100) NOT NULL UNIQUE,  
  `Phone` VARCHAR(15),
  `CreateAt` DATETIME,
  PRIMARY KEY (`CustomerID`)
);

-- Tạo bảng products
CREATE TABLE `products` (
  `ProductID` INT AUTO_INCREMENT, -- Thêm AUTO_INCREMENT cho khóa chính
  `ProductName` VARCHAR(255) NOT NULL,
  `Category` VARCHAR(255),
  `Price` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`ProductID`)
);

-- Tạo bảng orders
CREATE TABLE `orders` (
  `OrderID` INT AUTO_INCREMENT, -- Thêm AUTO_INCREMENT cho khóa chính
  `CustomerID` INT,
  `OrderDate` DATETIME NOT NULL, 
  `TotalAmount` DECIMAL(10, 2),
  PRIMARY KEY (`OrderID`),
  FOREIGN KEY (`CustomerID`) REFERENCES `customers`(`CustomerID`)
);

-- Tạo bảng orderdetails
CREATE TABLE `orderdetails` (
  `OrderDetailID` INT AUTO_INCREMENT, -- Thêm AUTO_INCREMENT cho khóa chính
  `OrderID` INT,
  `ProductID` INT,
  `Quantity` INT NOT NULL,
  `UnitPrice` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`OrderDetailID`),
  FOREIGN KEY (`OrderID`) REFERENCES `orders`(`OrderID`) ON DELETE CASCADE, -- Xóa bản ghi liên quan khi đơn hàng bị xóa
  FOREIGN KEY (`ProductID`) REFERENCES `products`(`ProductID`) ON DELETE CASCADE
);

-- Thêm chỉ số vào cột Phone trong bảng Customers
CREATE INDEX idx_Email ON Customers (`Email`);

-- Thêm chỉ số vào cột OrderDate trong bảng Orders
CREATE INDEX idx_OrderDate ON orders (`OrderDate`);
