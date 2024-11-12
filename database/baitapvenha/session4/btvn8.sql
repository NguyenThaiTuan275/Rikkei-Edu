
-- tạo bảng
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),         -- Thêm số điện thoại
    CreatedAt DATE             -- Thêm ngày tạo tài khoản
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)       -- Thêm danh mục sản phẩm
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),  -- Thêm giá đơn vị của sản phẩm
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Truy vấn để tạo báo cáo hàng tháng về tổng doanh thu, số lượng đơn hàng và tỷ lệ giữ chân khách hàng
WITH MonthlyOrders AS (
    SELECT
        YEAR(OrderDate) AS Year,
        MONTH(OrderDate) AS Month,
        CustomerID,
        SUM(TotalAmount) AS MonthlyRevenue,
        COUNT(OrderID) AS OrderCount
    FROM
        Orders
    GROUP BY
        YEAR(OrderDate), MONTH(OrderDate), CustomerID
),
NewCustomers AS (
    SELECT
        YEAR(OrderDate) AS Year,
        MONTH(OrderDate) AS Month,
        COUNT(DISTINCT CustomerID) AS NewCustomersCount
    FROM
        Orders
    WHERE
        OrderDate BETWEEN '2023-01-01' AND '2023-12-31'  -- Thay đổi phạm vi thời gian theo yêu cầu
    GROUP BY
        YEAR(OrderDate), MONTH(OrderDate)
),
ReturningCustomers AS (
    SELECT
        YEAR(OrderDate) AS Year,
        MONTH(OrderDate) AS Month,
        COUNT(DISTINCT o.CustomerID) AS ReturningCustomersCount
    FROM
        Orders o
    JOIN
        Orders o2 ON o.CustomerID = o2.CustomerID
    WHERE
        o.OrderDate < o2.OrderDate  -- Tính khách hàng quay lại
    GROUP BY
        YEAR(o.OrderDate), MONTH(o.OrderDate)
)
SELECT
    mo.Year,
    mo.Month,
    SUM(mo.MonthlyRevenue) AS TotalRevenue,
    SUM(mo.OrderCount) AS TotalOrders,
    COALESCE(SUM(rc.ReturningCustomersCount), 0) AS ReturningCustomers,
    COALESCE(SUM(nc.NewCustomersCount), 0) AS NewCustomers,
    CASE 
        WHEN COALESCE(SUM(nc.NewCustomersCount), 0) = 0 THEN 0
        ELSE (COALESCE(SUM(rc.ReturningCustomersCount), 0) * 1.0) / COALESCE(SUM(nc.NewCustomersCount), 1)
    END AS CustomerRetentionRate
FROM
    MonthlyOrders mo
LEFT JOIN
    NewCustomers nc ON mo.Year = nc.Year AND mo.Month = nc.Month
LEFT JOIN
    ReturningCustomers rc ON mo.Year = rc.Year AND mo.Month = rc.Month
GROUP BY
    mo.Year, mo.Month
ORDER BY
    mo.Year, mo.Month;
