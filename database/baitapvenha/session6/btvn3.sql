USE salesdb3;

-- Xây dựng một stored procedure nhận đầu vào là OrderID và newTotalAmount để cập nhật tổng số tiền của đơn hàng.
DELIMITER //

CREATE PROCEDURE UpdateOrderTotalAmount (
    IN inOrderID INT,                  -- ID của đơn hàng
    IN inNewTotalAmount DECIMAL(10,2)  -- Tổng số tiền mới
)
BEGIN
    -- Kiểm tra nếu đơn hàng tồn tại
    IF EXISTS (SELECT 1 FROM Orders WHERE OrderID = inOrderID) THEN
        -- Cập nhật tổng số tiền của đơn hàng
        UPDATE Orders
        SET TotalAmount = inNewTotalAmount
        WHERE OrderID = inOrderID;

        -- Thông báo kết quả thành công
        SELECT CONCAT('Order ID ', inOrderID, ' has been updated successfully.') AS Message;
    ELSE
        -- Thông báo lỗi nếu đơn hàng không tồn tại
        SELECT CONCAT('Order ID ', inOrderID, ' does not exist.') AS Message;
    END IF;
END //

DELIMITER ;
