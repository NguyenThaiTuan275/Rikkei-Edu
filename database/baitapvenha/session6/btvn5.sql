USE salesdb3;

-- Xây dựng một stored procedure nhận đầu vào là CustomerID và monthYear để tính tổng doanh thu của khách hàng trong tháng và năm cụ thể.
DELIMITER //

CREATE PROCEDURE GetMonthlyRevenueByCustomer (
    IN inCustomerID INT,       -- ID của khách hàng
    IN inMonthYear VARCHAR(7)  -- Tháng và năm (ví dụ: '2024-07')
)
BEGIN
    DECLARE totalRevenue DECIMAL(10, 2);  -- Biến lưu tổng doanh thu

    -- Tính tổng doanh thu cho tháng và năm chỉ định
    SELECT SUM(S.SaleAmount) INTO totalRevenue
    FROM Sales S
    JOIN Orders O ON S.OrderID = O.OrderID
    WHERE O.CustomerID = inCustomerID
      AND DATE_FORMAT(S.SaleDate, '%Y-%m') = inMonthYear;

    -- Trả kết quả
    SELECT IFNULL(totalRevenue, 0) AS TotalRevenue;
END //

DELIMITER ;
