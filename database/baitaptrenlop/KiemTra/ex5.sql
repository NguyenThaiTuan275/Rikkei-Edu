USE shopee;

-- Làm thế nào để tạo một index trên cột productName của bảng products?
CREATE INDEX idx_productName ON products(productName);

-- Hiển thị danh sách các index trong cơ sở dữ liệu?
SHOW INDEX FROM products;

-- Trình bày cách xóa index idx_productName đã tạo trước đó?
DROP INDEX idx_productName ON products;

-- Tạo một procedure tên getProductByPrice để lấy danh sách sản phẩm với giá lớn hơn một giá trị đầu vào (priceInput)?
DELIMITER $$

CREATE PROCEDURE getProductByPrice(IN priceInput DECIMAL(10, 2))
BEGIN
    SELECT productId, productName, price 
    FROM products
    WHERE price > priceInput;
END $$

DELIMITER ;

-- Làm thế nào để gọi procedure getProductByPrice với đầu vào là 500000?
CALL getProductByPrice(500000);

-- Tạo một procedure getOrderDetails trả về thông tin chi tiết đơn hàng với đầu vào là orderId?
DELIMITER $$

CREATE PROCEDURE getOrderDetails(IN orderIdInput VARCHAR(255))
BEGIN
    SELECT 
        od.orderDetailId,
        od.orderId,
        od.productId,
        p.productName,
        od.quantityOrder,
        od.priceOrder
    FROM order_details od
    JOIN products p ON od.productId = p.productId
    WHERE od.orderId = orderIdInput;
END $$

DELIMITER ;

-- Làm thế nào để xóa procedure getOrderDetails?
DROP PROCEDURE IF EXISTS getOrderDetails;

-- Tạo một procedure tên addNewProduct để thêm mới một sản phẩm vào bảng products. 
-- Các tham số gồm productName, price, description, và quantity.
DELIMITER $$

CREATE PROCEDURE addNewProduct(
    IN productNameInput VARCHAR(255),
    IN priceInput DECIMAL(10, 2),
    IN descriptionInput TEXT,
    IN quantityInput INT
)
BEGIN
    INSERT INTO products (productName, price, description, quantity)
    VALUES (productNameInput, priceInput, descriptionInput, quantityInput);
END $$

DELIMITER ;

-- Tạo một procedure tên deleteProductById để xóa sản phẩm khỏi bảng products dựa trên tham số productId.
DELIMITER $$

CREATE PROCEDURE deleteProductById(
    IN productId INT
)
BEGIN
    DELETE FROM products 
    WHERE id = productId;
END $$

DELIMITER ;

-- Tạo một procedure tên searchProductByName để tìm kiếm sản phẩm theo tên (tìm kiếm gần đúng) từ bảng products.
DELIMITER $$
CREATE PROCEDURE searchProductByName (
    IN searchName VARCHAR(255)
)
BEGIN
    SELECT * 
    FROM products
    WHERE productname LIKE CONCAT('%', searchName, '%');
END $$
DELIMITER ;

-- Tạo một procedure tên filterProductsByPriceRange để lấy danh sách sản phẩm có giá trong khoảng từ minPrice đến maxPrice.
DELIMITER $$
CREATE PROCEDURE filterProductsByPriceRange (
    IN minPrice INT, 
    IN maxPrice INT
)
BEGIN
    SELECT * 
    FROM products
    WHERE price BETWEEN minPrice AND maxPrice;
END $$
DELIMITER ;

-- Tạo một procedure tên paginateProducts để phân trang danh sách sản phẩm, với hai tham số pageNumber và pageSize.
DELIMITER $$
CREATE PROCEDURE paginateProducts (
    IN pageNumber INT, 
    IN pageSize INT
)
BEGIN
    DECLARE pageOffset INT;
    SET pageOffset = pageSize * (pageNumber - 1);
    
    SELECT * 
    FROM products
    LIMIT pageOffset, pageSize;
END $$
DELIMITER ;
