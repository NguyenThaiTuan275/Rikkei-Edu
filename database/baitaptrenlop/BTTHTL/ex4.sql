USE btth_qlct;

-- 1. Hiển thị thù lao trung bình của từng kiến trúc sư
SELECT a.name AS architect_name, AVG(d.benefit) AS average_benefit
FROM architect a
JOIN design d ON a.id = d.architect_id
GROUP BY a.id;

-- 2. Hiển thị chi phí đầu tư cho các công trình ở mỗi thành phố
SELECT city, SUM(cost) AS total_investment
FROM building
GROUP BY city;

-- 3. Tìm các công trình có chi phí trả cho kiến trúc sư lớn hơn 50
SELECT b.*
FROM building b
JOIN design d ON b.id = d.building_id
WHERE d.benefit > 50;

-- 4. Tìm các thành phố có ít nhất một kiến trúc sư tốt nghiệp
SELECT DISTINCT b.city
FROM building b
JOIN design d ON b.id = d.building_id
JOIN architect a ON d.architect_id = a.id
WHERE a.place IS NOT NULL;



