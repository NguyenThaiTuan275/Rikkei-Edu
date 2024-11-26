USE salesdb3;

-- Xây dựng một stored procedure nhận đầu vào là startDate, endDate, và revenueThreshold. 
-- Procedure này sẽ tính tổng doanh thu hàng tháng cho từng khách hàng trong khoảng thời gian 
-- và áp dụng khuyến mãi nếu tổng doanh thu hàng tháng vượt qua ngưỡng quy định.
DELIMITER //

CREATE PROCEDURE AnalyzeRevenueAndApplyPromotion (
    IN inStartDate DATE,                 -- Ngày bắt đầu
    IN inEndDate DATE,                   -- Ngày kết thúc
    IN inRevenueThreshold DECIMAL(10,2) -- Ngưỡng doanh thu để áp dụng khuyến mãi
)
BEGIN
    -- Tìm các khách hàng có tổng doanh thu hàng tháng vượt ngưỡng và thêm khuyến mãi
    INSERT INTO Promotions (PromotionName, DiscountPercentage)
    SELECT 
        CONCAT('Promotion for Customer ', O.CustomerID, ' in ', DATE_FORMAT(S.SaleDate, '%Y-%m')) AS PromotionName,
        10.00 AS DiscountPercentage -- Phần trăm giảm giá mặc định
    FROM Sales S
    JOIN Orders O ON S.OrderID = O.OrderID
    WHERE S.SaleDate BETWEEN inStartDate AND inEndDate
    GROUP BY O.CustomerID, DATE_FORMAT(S.SaleDate, '%Y-%m')
    HAVING SUM(S.SaleAmount) > inRevenueThreshold;

    -- Thông báo hoàn tất
    SELECT 'Analysis and promotion application completed.' AS Message;
END //

DELIMITER ;
