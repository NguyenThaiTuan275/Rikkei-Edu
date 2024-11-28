CREATE DATABASE InventoryManagement;
USE InventoryManagement;

CREATE TABLE Products(
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(50),
    Quantity INT
);
CREATE TABLE InventoryChanges(
    ChangeID  INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    OldQuantity INT,
    NewQuantity  INT,
    ChangeDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Tạo Trigger AfterProductUpdate
DELIMITER $$
CREATE TRIGGER AfterProductUpdate
AFTER UPDATE
ON Products
FOR EACH ROW
BEGIN
    INSERT INTO InventoryChanges(ProductID, OldQuantity, NewQuantity, ChangeDate)
    VALUES(NEW.ProductID, OLD.Quantity, NEW.Quantity, NOW());
END $$
DELIMITER ;

INSERT INTO Products(ProductName, Quantity)
VALUES('Product1', 10)
,('Product2', 20)
,('Product3', 30)
,('Product4', 40);

-- Thực hiện ít nhất 2 cập nhật trên bảng Products để kiểm tra Trigger.
UPDATE Products
SET Quantity = 15
WHERE ProductID = 1;
UPDATE Products
SET Quantity = 25
WHERE ProductID = 2;



-- ex2
-- Tạo Trigger để ngăn không cho xóa sản phẩm nếu số lượng của sản phẩm đó lớn hơn 10.
-- Kiểm tra xóa một sản phẩm có số lượng lớn hơn 10 và kiểm tra thông báo lỗi.


DELIMITER $$
CREATE TRIGGER BeforeProductDelete   
BEFORE DELETE
ON Products
FOR EACH ROW
BEGIN
    IF OLD.Quantity > 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa sản phẩm có số lượng lớn hơn 10';
    END IF;
END $$
DELIMITER ;
DELETE FROM Products
WHERE ProductID = 1;

-- ex3
-- Tạo Trigger để tự động cập nhật trường LastUpdated với thời gian hiện tại mỗi khi có thay đổi trong bảng Products.
-- Thay đổi cấu trúc bảng Products để bao gồm một trường LastUpdated
ALTER TABLE Products
ADD COLUMN LastUpdated DATETIME;

DELIMITER $$
CREATE TRIGGER AfterProductUpdateSetDate 
AFTER UPDATE
ON Products
FOR EACH ROW
BEGIN
    INSERT INTO InventoryChanges(ProductID, OldQuantity, NewQuantity, ChangeDate)
    VALUES(NEW.ProductID, OLD.Quantity, NEW.Quantity, NOW());
END $$
DELIMITER ;

UPDATE Products
SET Quantity = 20,LastUpdated = NOW()
WHERE ProductID = 1;

SHOW TRIGGERS;


-- ex4
-- Tạo bảng ProductSummary: SummaryID(INT, Primary Key), TotalQuantity(INT)
-- Thêm một bản ghi khởi tạo vào bảng ProductSummary
-- Tạo Trigger AfterProductUpdateSummary để cập nhật tổng số lượng hàng trong ProductSummary mỗi khi có thay đổi số lượng hàng trong Products:
CREATE TABLE ProductSummary(
    SummaryID INT PRIMARY KEY AUTO_INCREMENT,
    TotalQuantity INT
);

INSERT INTO ProductSummary(TotalQuantity)
VALUES(0);  

DELIMITER $$
CREATE TRIGGER AfterProductUpdateSummary
AFTER UPDATE
ON Products
FOR EACH ROW
BEGIN
    UPDATE ProductSummary
    SET TotalQuantity = (SELECT SUM(Quantity) FROM Products);
END $$
DELIMITER ;



-- ex5
-- Bảng  InventoryChangeHistory:
-- Tạo Trigger AfterProductUpdateHistory để ghi lại lịch sử thay đổi số lượng và phân loại thay đổi
CREATE TABLE InventoryChangeHistory(
    historyID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    OldQuantity INT,
    NewQuantity INT,
    ChangeDate DATE,
    ChangeType enum('Increase', 'Decrease'),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

DELIMITER $$
CREATE TRIGGER AfterProductUpdateHistory
AFTER UPDATE
ON Products
FOR EACH ROW
BEGIN
    DECLARE changeType enum('Increase', 'Decrease');
    IF OLD.Quantity < NEW.Quantity THEN
        SET changeType = 'Increase';
    ELSE
        SET changeType = 'Decrease';
    END IF;
    INSERT INTO InventoryChangeHistory(ProductID, OldQuantity, NewQuantity, ChangeDate, ChangeType)
    VALUES(NEW.ProductID, OLD.Quantity, NEW.Quantity, NOW(), changeType);
END $$  
DELIMITER ;


-- ex6
-- Tạo Trigger để đồng bộ dữ liệu giữa bảng Products và bảng ProductRestock, khi số lượng sản phẩm trong bảng Products giảm xuống dưới một ngưỡng cụ thể, Trigger sẽ thêm một bản ghi vào bảng ProductRestock để yêu cầu tái cung cấp hàng.
-- Bảng ProductRestock: 
-- Tạo Trigger AfterProductUpdateRestock để tự động thêm bản ghi vào bảng ProductRestock nếu số lượng hàng giảm dưới ngưỡng 10
CREATE TABLE ProductRestock(
    RestockID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    RestockDate DATE,
    RestockQuantity INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

DELIMITER $$
CREATE TRIGGER AfterProductUpdateRestock
AFTER UPDATE
ON Products
FOR EACH ROW
BEGIN
    IF NEW.Quantity < 10 THEN
        INSERT INTO ProductRestock(ProductID, RestockDate, RestockQuantity)
        VALUES(NEW.ProductID, NOW(), 10);
    END IF;
END $$
DELIMITER ;
