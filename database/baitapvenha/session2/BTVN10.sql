use ECommerceDB1;

-- Thêm ràng buộc vào bảng Users để đảm bảo Username và Email không bị trùng lặp
ALTER TABLE Users
ADD CONSTRAINT UQ_Username UNIQUE (Username);

ALTER TABLE Users
ADD CONSTRAINT UQ_Email UNIQUE (Email);

-- Thêm ràng buộc vào bảng Products để đảm bảo ProductName, Price, và Stock không được để trống (NOT NULL)
ALTER TABLE Products
MODIFY ProductName VARCHAR(100) NOT NULL;

ALTER TABLE Products
MODIFY Price DECIMAL(10, 2) NOT NULL;

ALTER TABLE Products
ADD COLUMN Stock INT NOT NULL DEFAULT 0;  -- Thêm cột Stock nếu chưa tồn tại và không cho phép NULL

-- Thêm ràng buộc vào bảng Orders để đảm bảo TotalAmount không được âm
ALTER TABLE Orders
ADD CONSTRAINT CHK_TotalAmount CHECK (TotalAmount >= 0);

-- Thêm ràng buộc vào bảng OrderDetails để đảm bảo Quantity và PriceAtOrder không được âm
ALTER TABLE OrderDetails
ADD CONSTRAINT CHK_Quantity CHECK (Quantity >= 0);

ALTER TABLE OrderDetails
ADD CONSTRAINT CHK_PriceAtOrder CHECK (PriceAtOrder >= 0);

-- Thêm ràng buộc vào bảng Reviews để đảm bảo Rating nằm trong khoảng từ 1 đến 5
ALTER TABLE Reviews
ADD CONSTRAINT CHK_Rating CHECK (Rating BETWEEN 1 AND 5);
