use CompanyDB;

-- Truy vấn tất cả nhân viên thuộc phòng ban cụ thể
SELECT 
    e.EmployeeID, e.FirstName, e.LastName, e.Salary, d.DepartmentName
FROM 
    Employees e
JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID
WHERE 
    d.DepartmentName = 'Tên phòng ban cụ thể';  -- Thay 'Tên phòng ban cụ thể' bằng tên phòng ban bạn muốn tìm

-- Cập nhật thông tin lương của một nhân viên
UPDATE Employees
SET Salary = 70000  -- Thay đổi giá trị lương theo nhu cầu
WHERE EmployeeID = 1;  -- Thay '1' bằng ID của nhân viên cần cập nhật

-- Xóa tất cả nhân viên có mức lương thấp hơn một giá trị nhất định
DELETE FROM Employees
WHERE Salary < 30000;  -- Thay '30000' bằng giá trị lương bạn muốn sử dụng làm tiêu chí
