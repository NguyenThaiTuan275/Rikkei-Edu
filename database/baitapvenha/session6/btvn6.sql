USE salesdb3;

-- Xây dựng một stored procedure nhận đầu vào là OrderID và newTotalAmount. 
-- Nếu tổng doanh thu mới của đơn hàng vượt qua một ngưỡng, thêm một khuyến mãi vào bảng Promotions.
DELIMITER //

CREATE PROCEDURE UpdateOrderTotalAndApplyPromotion (
    IN inOrderID INT,                    -- ID của đơn hàng
    IN inNewTotalAmount DECIMAL(10,2),   -- Tổng doanh thu mới
    IN inRevenueThreshold DECIMAL(10,2) -- Ngưỡng doanh thu để áp dụng khuyến mãi
)
BEGIN
    -- Kiểm tra nếu đơn hàng tồn tại
    IF EXISTS (SELECT 1 FROM Orders WHERE OrderID = inOrderID) THEN
        -- Cập nhật tổng doanh thu của đơn hàng
        UPDATE Orders
        SET TotalAmount = inNewTotalAmount
        WHERE OrderID = inOrderID;

        -- Kiểm tra nếu tổng doanh thu mới vượt ngưỡng
        IF inNewTotalAmount > inRevenueThreshold THEN
            -- Thêm một khuyến mãi vào bảng Promotions
            INSERT INTO Promotions (PromotionName, DiscountPercentage)
            VALUES (
                CONCAT('Promotion for Order ', inOrderID),
                10.00 -- Phần trăm giảm giá mặc định, có thể điều chỉnh
            );

            -- Thông báo thành công và khuyến mãi đã được thêm
            SELECT CONCAT('Order ID ', inOrderID, ' updated successfully. Promotion applied.') AS Message;
        ELSE
            -- Chỉ thông báo cập nhật thành công nếu không vượt ngưỡng
            SELECT CONCAT('Order ID ', inOrderID, ' updated successfully. No promotion applied.') AS Message;
        END IF;
    ELSE
        -- Thông báo nếu đơn hàng không tồn tại
        SELECT CONCAT('Order ID ', inOrderID, ' does not exist.') AS Message;
    END IF;
END //

DELIMITER ;
