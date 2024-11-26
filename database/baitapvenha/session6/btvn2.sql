USE salesdb3;

-- Xây dựng một stored procedure nhận đầu vào là thông tin của khách hàng và thêm thông tin đó vào bảng Customers.
DELIMITER //

CREATE PROCEDURE AddNewCustomer (
    IN inFirstName VARCHAR(50),  -- Tên của khách hàng
    IN inLastName VARCHAR(50),   -- Họ của khách hàng
    IN inEmail VARCHAR(100)      -- Email của khách hàng
)
BEGIN
    -- Thêm khách hàng mới vào bảng Customers
    INSERT INTO Customers (FirstName, LastName, Email)
    VALUES (inFirstName, inLastName, inEmail);
    
    -- Thông báo kết quả
    SELECT 'New customer has been added successfully.' AS Message;
END //

DELIMITER ;


