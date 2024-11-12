
-- tạo bảng
CREATE TABLE EmployeeSalaries (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    Salary DECIMAL(10, 2)
);

-- Truy vấn tính tổng lương và lương trung bình cho mỗi phòng ban
SELECT 
    DepartmentID,
    SUM(Salary) AS TotalSalary,
    AVG(Salary) AS AverageSalary
FROM 
    EmployeeSalaries
GROUP BY 
    DepartmentID;
