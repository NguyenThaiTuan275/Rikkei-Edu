USE btth_qlct;

-- 1. Hiển thị tên công trình, tên chủ nhân và tên chủ thầu của công trình đó
SELECT b.name AS building_name, h.name AS host_name, c.name AS contractor_name
FROM building b
JOIN host h ON b.host_id = h.id
JOIN contractor c ON b.contractor_id = c.id;

-- 2. Hiển thị tên công trình (building), tên kiến trúc sư (architect) và thù lao của kiến trúc sư ở mỗi công trình (design)
SELECT b.name AS building_name, a.name AS architect_name, d.benefit AS architect_fee
FROM building b
JOIN design d ON b.id = d.building_id
JOIN architect a ON d.architect_id = a.id;

-- 3. Tên và địa chỉ công trình (building) do chủ thầu Công ty xây dựng số 6 thi công (contractor)
SELECT b.name AS building_name, b.address AS building_address
FROM building b
JOIN contractor c ON b.contractor_id = c.id
WHERE c.name = 'cty xd so 6';

-- 4. Tên và địa chỉ liên lạc của các chủ thầu (contractor) thi công công trình ở Cần Thơ (building) do kiến trúc sư Lê Kim Dung thiết kế (architect, design)
SELECT c.name AS contractor_name, c.address AS contractor_address
FROM contractor c
JOIN building b ON c.id = b.contractor_id
JOIN design d ON b.id = d.building_id
JOIN architect a ON d.architect_id = a.id
WHERE b.city = 'can tho' AND a.name = 'le kim dung';

-- 5. Nơi tốt nghiệp của các kiến trúc sư (architect) đã thiết kế (design) công trình Khách Sạn Quốc Tế ở Cần Thơ (building)
SELECT DISTINCT a.place
FROM architect a
JOIN design d ON a.id = d.architect_id
JOIN building b ON d.building_id = b.id
WHERE b.name = 'khach san quoc te' AND b.city = 'can tho';

-- 6. Họ tên, năm sinh, năm vào nghề của các công nhân có chuyên môn hàn hoặc điện (worker) đã tham gia các công trình (work) mà chủ thầu Lê Văn Sơn (contractor) đã trúng thầu (building)
SELECT w.name AS worker_name, w.birthday, w.year AS year_of_entry
FROM worker w
JOIN work ww ON w.id = ww.worker_id
JOIN building b ON ww.building_id = b.id
JOIN contractor c ON b.contractor_id = c.id
WHERE (w.skill = 'han' OR w.skill = 'dien') AND c.name = 'le van son';

-- 7. Họ tên công nhân (worker) đã bắt đầu tham gia công trình Khách sạn Quốc Tế ở Cần Thơ (building) trong giai đoạn từ ngày 15/12/1994 đến 31/12/1994 (work) số ngày tương ứng là bao nhiêu
SELECT w.name AS worker_name, DATEDIFF(ww.date, '1994-12-15') AS days
FROM worker w
JOIN work ww ON w.id = ww.worker_id
JOIN building b ON ww.building_id = b.id
WHERE b.name = 'khach san quoc te' AND b.city = 'can tho'
AND ww.date BETWEEN '1994-12-15' AND '1994-12-31';

-- 8. Họ tên và năm sinh của các kiến trúc sư đã tốt nghiệp ở TP Hồ Chí Minh (architect) và đã thiết kế ít nhất một công trình (design) có kinh phí đầu tư trên 400 triệu đồng (building)
SELECT DISTINCT a.name AS architect_name, a.birthday
FROM architect a
JOIN design d ON a.id = d.architect_id
JOIN building b ON d.building_id = b.id
WHERE a.place = 'tp hcm' AND b.cost > 400000000;

-- 9. Tên công trình có kinh phí cao nhất
SELECT name FROM building
WHERE cost = (SELECT MAX(cost) FROM building);

-- 10. Các kiến trúc sư (architect) vừa thiết kế các công trình (design) do Phòng dịch vụ sở xây dựng (contractor) thi công vừa thiết kế các công trình do chủ thầu Lê Văn Sơn thi công
SELECT DISTINCT a.name AS architect_name
FROM architect a
JOIN design d1 ON a.id = d1.architect_id
JOIN building b1 ON d1.building_id = b1.id
JOIN contractor c1 ON b1.contractor_id = c1.id
JOIN design d2 ON a.id = d2.architect_id
JOIN building b2 ON d2.building_id = b2.id
JOIN contractor c2 ON b2.contractor_id = c2.id
WHERE c1.name = 'phong dich vu so xd' AND c2.name = 'le van son';

-- 11. Họ tên công nhân (worker) có tham gia (work) các công trình ở Cần Thơ (building) nhưng không có tham gia công trình ở Vĩnh Long
SELECT DISTINCT w.name AS worker_name
FROM worker w
JOIN work ww1 ON w.id = ww1.worker_id
JOIN building b1 ON ww1.building_id = b1.id
WHERE b1.city = 'can tho' AND w.id NOT IN (
    SELECT DISTINCT w2.id
    FROM worker w2
    JOIN work ww2 ON w2.id = ww2.worker_id
    JOIN building b2 ON ww2.building_id = b2.id
    WHERE b2.city = 'vinh long'
);

-- 12. Tên các chủ thầu đã thi công các công trình có kinh phí lớn hơn tất cả các công trình do chủ thầu Phòng Dịch vụ Sở xây dựng thi công
SELECT DISTINCT c.name AS contractor_name
FROM contractor c
JOIN building b ON c.id = b.contractor_id
WHERE b.cost > ALL (
    SELECT cost
    FROM building
    WHERE contractor_id = (SELECT id FROM contractor WHERE name = 'phong dich vu so xd')
);

-- 13. Họ tên các kiến trúc sư có thù lao thiết kế một công trình nào đó dưới giá trị trung bình thù lao thiết kế cho một công trình
SELECT DISTINCT a.name AS architect_name
FROM architect a
JOIN design d ON a.id = d.architect_id
WHERE d.benefit < (SELECT AVG(benefit) FROM design);

-- 14. Tên và địa chỉ những chủ thầu đã trúng thầu công trình có kinh phí thấp nhất
SELECT c.name AS contractor_name, c.address AS contractor_address
FROM contractor c
JOIN building b ON c.id = b.contractor_id
WHERE b.cost = (SELECT MIN(cost) FROM building);

-- 15. Họ tên và chuyên môn của các công nhân (worker) tham gia (work) các công trình do kiến trúc sư Le Thanh Tung thiết kế (architect) (design)
SELECT w.name AS worker_name, w.skill
FROM worker w
JOIN work ww ON w.id = ww.worker_id
JOIN building b ON ww.building_id = b.id
JOIN design d ON b.id = d.building_id
JOIN architect a ON d.architect_id = a.id
WHERE a.name = 'le thanh tung';

-- 16. Các cặp tên của chủ thầu có trúng thầu các công trình tại cùng một thành phố
SELECT c1.name AS contractor_1, c2.name AS contractor_2
FROM contractor c1
JOIN building b1 ON c1.id = b1.contractor_id
JOIN contractor c2 ON b1.city = (SELECT city FROM building WHERE contractor_id = c2.id)
WHERE c1.id != c2.id;

-- 17. Tổng kinh phí của tất cả các công trình theo từng chủ thầu
SELECT c.name AS contractor_name, SUM(b.cost) AS total_cost
FROM contractor c
JOIN building b ON c.id = b.contractor_id
GROUP BY c.id;

-- 18. Họ tên các kiến trúc sư có tổng thù lao thiết kế các công trình lớn hơn 25 triệu
SELECT a.name AS architect_name
FROM architect a
JOIN design d ON a.id = d.architect_id
GROUP BY a.id
HAVING SUM(d.benefit) > 25000000;

-- 19. Số lượng các kiến trúc sư có tổng thù lao thiết kế các công trình lớn hơn 25 triệu
SELECT COUNT(DISTINCT a.id) AS architect_count
FROM architect a
JOIN design d ON a.id = d.architect_id
GROUP BY a.id
HAVING SUM(d.benefit) > 25000000;

-- 20. Tổng số công nhân đã tham gia ở mỗi công trình
SELECT b.name AS building_name, COUNT(ww.worker_id) AS worker_count
FROM building b
