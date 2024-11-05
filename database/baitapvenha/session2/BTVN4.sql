use companydb;

-- Tạo bảng Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Thêm ràng buộc CHECK vào bảng Orders hiện có
ALTER TABLE Orders
ADD CONSTRAINT chk_total_amount CHECK (TotalAmount >= 0);

