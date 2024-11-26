USE salesdb3;

-- Xây dựng một stored procedure nhận đầu vào là OrderID để xóa đơn hàng và tất cả các bản ghi liên quan từ bảng Sales.
DELIMITER //

CREATE PROCEDURE DeleteOrderAndSales (
    IN inOrderID INT -- ID của đơn hàng cần xóa
)
BEGIN
    -- Kiểm tra nếu đơn hàng tồn tại
    IF EXISTS (SELECT 1 FROM Orders WHERE OrderID = inOrderID) THEN
        -- Xóa các bản ghi liên quan từ bảng Sales
        DELETE FROM Sales
        WHERE OrderID = inOrderID;

        -- Xóa đơn hàng từ bảng Orders
        DELETE FROM Orders
        WHERE OrderID = inOrderID;

        -- Thông báo kết quả thành công
        SELECT CONCAT('Order ID ', inOrderID, ' and related Sales records have been deleted successfully.') AS Message;
    ELSE
        -- Thông báo lỗi nếu đơn hàng không tồn tại
        SELECT CONCAT('Order ID ', inOrderID, ' does not exist.') AS Message;
    END IF;
END //

DELIMITER ;
