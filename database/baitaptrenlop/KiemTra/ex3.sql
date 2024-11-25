USE shopee;

-- Liệt kê tất cả các thông tin về sản phẩm (products).
SELECT * FROM `products`;

-- Tìm tất cả các đơn hàng (orders) có tổng giá trị (totalPrice) lớn hơn 500,000.
SELECT * FROM `orders` 
WHERE `totalPrice` > 500000;

-- Liệt kê tên và địa chỉ của tất cả các cửa hàng (stores).
SELECT `storeName`, `addressStore` FROM `stores`;

-- Tìm tất cả người dùng (users) có địa chỉ email kết thúc bằng '@gmail.com'.
SELECT `userName`, `fullName`, `email`  FROM `users`
WHERE `email` LIKE '%@gmail.com';

-- Hiển thị tất cả các đánh giá (reviews) với mức đánh giá (rate) bằng 5.
SELECT `content`,`rate` FROM `reviews`
WHERE `rate` = 5;

-- Liệt kê tất cả các sản phẩm có số lượng (quantity) dưới 10.
SELECT `productId`, `productName`, `quantity` FROM products
WHERE `quantity` < 10;

-- Tìm tất cả các sản phẩm thuộc danh mục categoryId = 1.
SELECT `productId`, `productName`, `categoryId` FROM `products`
WHERE `categoryId` = 1;

-- Đếm số lượng người dùng (users) có trong hệ thống.
SELECT COUNT(*) AS `totalUsers` FROM `users`;

-- Tính tổng giá trị của tất cả các đơn hàng (orders).
SELECT SUM(`totalPrice`) AS `totalOrderValue`
FROM `orders`;

-- Tìm sản phẩm có giá cao nhất (price).
SELECT * FROM `products`
WHERE `price` = (SELECT MAX(`price`) FROM `products`);

-- Liệt kê tất cả các cửa hàng đang hoạt động (statusStore = 1).
SELECT * FROM `stores`
WHERE `statusStore` = 1;

-- Đếm số lượng sản phẩm theo từng danh mục (categories).
SELECT c.categoryName, COUNT(p.productId) AS productCount
FROM categories c
LEFT JOIN products p ON c.categoryId = p.categoryId
GROUP BY c.categoryId, c.categoryName;

-- Tìm tất cả các sản phẩm mà chưa từng có đánh giá
SELECT p.productId, p.productName, r.content
FROM products p
LEFT JOIN reviews r ON p.productId = r.productId
WHERE r.reviewId IS NULL;

-- Hiển thị tổng số lượng hàng đã bán (quantityOrder) của từng sản phẩm
SELECT 
    p.productId, 
    p.productName, 
    SUM(od.quantityOrder) AS totalQuantitySold
FROM products p
JOIN order_details od ON p.productId = od.productId
GROUP BY p.productId, p.productName;

-- Tìm tất cả các sản phẩm mà chưa từng có đánh giá.
SELECT u.* FROM users u
LEFT JOIN orders o ON u.userId = o.userId
WHERE o.orderId IS NULL;

-- Hiển thị tên cửa hàng và tổng số đơn hàng được thực hiện tại từng cửa hàng.
SELECT 
    s.storeName, 
    COUNT(o.orderId) AS totalOrders
FROM stores s
LEFT JOIN orders o ON s.storeId = o.storeId
GROUP BY s.storeId, s.storeName;

-- Hiển thị thông tin của sản phẩm, kèm số lượng hình ảnh liên quan.
SELECT 
    p.productId, 
    p.productName, 
    p.price, 
    p.quantity, 
    COUNT(i.imageId) AS imageCount
FROM products p
LEFT JOIN images i ON p.productId = i.productId
GROUP BY p.productId, p.productName, p.price, p.quantity;

-- Hiển thị các sản phẩm kèm số lượng đánh giá và đánh giá trung bình.
SELECT 
    p.productId, 
    p.productName, 
    COUNT(r.reviewId) AS reviewCount, 
    COALESCE(AVG(r.rate), 0) AS averageRating
FROM products p
LEFT JOIN reviews r ON p.productId = r.productId
GROUP BY p.productId, p.productName;

-- Tìm người dùng có số lượng đánh giá nhiều nhất.
SELECT 
    u.userId, 
    u.userName, 
    COUNT(r.reviewId) AS reviewCount
FROM users u
JOIN reviews r ON u.userId = r.userId
GROUP BY u.userId, u.userName
ORDER BY reviewCount DESC
LIMIT 1;

-- Hiển thị top 3 sản phẩm bán chạy nhất (dựa trên số lượng đã bán).
SELECT 
    p.productId, 
    p.productName, 
    SUM(od.quantityOrder) AS totalSold
FROM products p
JOIN order_details od ON p.productId = od.productId
GROUP BY p.productId, p.productName
ORDER BY totalSold DESC
LIMIT 3;

-- Tìm sản phẩm bán chạy nhất tại cửa hàng có storeId = 'S001'.
SELECT 
    p.productId, 
    p.productName, 
    SUM(od.quantityOrder) AS totalSold
FROM products p
JOIN order_details od ON p.productId = od.productId
WHERE p.storeId = 'S001'
GROUP BY p.productId, p.productName
ORDER BY totalSold DESC
LIMIT 1;

-- Hiển thị danh sách tất cả các sản phẩm có giá trị tồn kho lớn hơn 1 triệu (giá * số lượng).
SELECT 
    productId, 
    productName, 
    price, 
    quantity, 
    (price * quantity) AS inventoryValue
FROM products
WHERE (price * quantity) > 1000000;

-- Tìm cửa hàng có tổng doanh thu cao nhất.
SELECT 
    s.storeId, 
    s.storeName, 
    SUM(o.totalPrice) AS totalRevenue
FROM stores s
JOIN orders o ON s.storeId = o.storeId
GROUP BY s.storeId, s.storeName
ORDER BY totalRevenue DESC
LIMIT 1;

-- Hiển thị danh sách người dùng và tổng số tiền họ đã chi tiêu.
SELECT 
    u.userId, 
    u.userName, 
    u.fullName, 
    SUM(o.totalPrice) AS totalSpent
FROM users u
LEFT JOIN orders o ON u.userId = o.userId
GROUP BY u.userId, u.userName, u.fullName;

-- Tìm đơn hàng có tổng giá trị cao nhất và liệt kê thông tin chi tiết.
SELECT * FROM orders
WHERE totalPrice = (SELECT MAX(totalPrice) FROM orders);

-- Tính số lượng sản phẩm trung bình được bán ra trong mỗi đơn hàng.
SELECT AVG(totalQuantity) AS averageProductsPerOrder
FROM (
    SELECT 
        o.orderId, 
        SUM(od.quantityOrder) AS totalQuantity
    FROM orders o
    JOIN order_details od ON o.orderId = od.orderId
    GROUP BY o.orderId
) AS orderQuantities;

-- Hiển thị tên sản phẩm và số lần sản phẩm đó được thêm vào giỏ hàng.
SELECT 
    p.productName, 
    COUNT(c.cartId) AS timesAddedToCart
FROM products p
LEFT JOIN carts c ON p.productId = c.productId
GROUP BY p.productId, p.productName;

-- Tìm tất cả các sản phẩm đã bán nhưng không còn tồn kho trong kho hàng.
SELECT 
    p.productId, 
    p.productName, 
    p.quantity, 
    SUM(od.quantityOrder) AS totalSold
FROM products p
JOIN order_details od ON p.productId = od.productId
WHERE p.quantity = 0
GROUP BY p.productId, p.productName, p.quantity
HAVING totalSold > 0;

-- Tìm các đơn hàng được thực hiện bởi người dùng có email là duong@gmail.com'.
SELECT o.* FROM orders o
JOIN users u ON o.userId = u.userId
WHERE u.email = 'duong@gmail.com';

-- Hiển thị danh sách các cửa hàng kèm theo tổng số lượng sản phẩm mà họ sở hữu.
SELECT 
    s.storeId, 
    s.storeName, 
    SUM(p.quantity) AS totalProducts
FROM stores s
LEFT JOIN products p ON s.storeId = p.storeId
GROUP BY s.storeId, s.storeName;
