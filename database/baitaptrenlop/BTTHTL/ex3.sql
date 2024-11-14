USE btth_qlct;

-- 1. Hiển thị thông tin công trình có chi phí cao nhất
SELECT * FROM building
WHERE cost = (SELECT MAX(cost) FROM building);

-- 2. Hiển thị thông tin công trình có chi phí lớn hơn tất cả các công trình được xây dựng ở Cần Thơ
SELECT * FROM building
WHERE cost > ALL 
(
	SELECT cost FROM building
	WHERE city = 'can tho'
);

-- 3. Hiển thị thông tin công trình có chi phí lớn hơn một trong các công trình được xây dựng ở Cần Thơ
SELECT * FROM building
WHERE cost > ANY 
(
	SELECT cost FROM building 
    WHERE city = 'can tho'
);

-- 4. Hiển thị thông tin công trình chưa có kiến trúc sư thiết kế
SELECT * FROM building
WHERE id NOT IN 
(
	SELECT building_id 
    FROM design
);

-- 5. Hiển thị thông tin các kiến trúc sư cùng năm sinh và cùng nơi tốt nghiệp
SELECT * FROM architect a1
WHERE EXISTS (
    SELECT 1 FROM architect a2
    WHERE a1.birthday = a2.birthday AND a1.place = a2.place AND a1.id != a2.id
);
