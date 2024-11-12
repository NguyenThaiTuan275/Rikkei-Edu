CREATE DATABASE qldanv;
USE qldanv;

-- tạo bảng
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Budget DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeName VARCHAR(100) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectID INT,
    TaskName VARCHAR(100) NOT NULL,
    AssignedTo INT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Status VARCHAR(50) NOT NULL,
    HoursWorked DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (AssignedTo) REFERENCES Employees(EmployeeID)
);

-- thêm dữ liệu
INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget) VALUES
('Project Alpha', '2023-01-01', '2023-12-31', 100000.00),
('Project Beta', '2023-02-01', '2023-11-30', 200000.00),
('Project Gamma', '2023-03-01', '2023-10-31', 150000.00);

INSERT INTO Employees (EmployeeName, Position, HireDate, Salary) VALUES
('Alice Smith', 'Developer', '2022-01-10', 60000.00),
('Bob Johnson', 'Project Manager', '2021-06-15', 80000.00),
('Carol Taylor', 'Designer', '2023-03-01', 50000.00),
('David Brown', 'Developer', '2022-09-20', 60000.00),
('Eve Davis', 'QA Engineer', '2022-11-25', 55000.00);

INSERT INTO Tasks (ProjectID, TaskName, AssignedTo, StartDate, EndDate, Status, HoursWorked) VALUES
(1, 'Task A1', 1, '2023-01-05', '2023-03-01', 'Completed', 15.00),
(1, 'Task A2', 2, '2023-02-01', '2023-04-01', 'In Progress', 20.00),
(2, 'Task B1', 3, '2023-03-05', '2023-05-01', 'Completed', 30.00),
(2, 'Task B2', 4, '2023-04-01', '2023-06-01', 'In Progress', 25.50),
(3, 'Task C1', 5, '2023-05-01', '2023-07-01', 'Completed', 40.00),
(3, 'Task C2', 1, '2023-06-01', '2023-08-01', 'In Progress', 10.00);

-- cập nhật dữ liệu
-- Cập nhật ngân sách của dự án có ProjectID = 2
UPDATE Projects
SET Budget = 50000.00
WHERE ProjectID = 2;

-- Cập nhật số giờ làm việc của công việc có TaskID = 4
UPDATE Tasks
SET HoursWorked = 25.50
WHERE TaskID = 4;

-- xóa dữ liệu 
-- Xóa nhân viên với EmployeeID = 3 khỏi bảng Employees
DELETE FROM Employees
WHERE EmployeeID = 3;

-- Xóa công việc với TaskID = 5 khỏi bảng Tasks
DELETE FROM Tasks
WHERE TaskID = 5;

-- truy vấn
-- Tính Tổng Chi Phí cho Từng Dự Án
SELECT 
    p.ProjectID,
    p.ProjectName,
    SUM(t.HoursWorked * 50.00) AS TotalCost
FROM 
    Projects p
JOIN 
    Tasks t ON p.ProjectID = t.ProjectID
GROUP BY 
    p.ProjectID, p.ProjectName;

-- Thống Kê Dự Án
SELECT 
    p.ProjectID,
    p.ProjectName,
    COUNT(CASE WHEN t.Status = 'Completed' THEN 1 END) AS CompletedTasks,
    COUNT(CASE WHEN t.Status = 'In Progress' THEN 1 END) AS InProgressTasks
FROM 
    Projects p
LEFT JOIN 
    Tasks t ON p.ProjectID = t.ProjectID
GROUP BY 
    p.ProjectID, p.ProjectName;

-- Thống Kê Nhân Viên
SELECT 
    e.EmployeeID,
    e.EmployeeName,
    COUNT(t.TaskID) AS TaskCount,
    SUM(t.HoursWorked) AS TotalHoursWorked
FROM 
    Employees e
LEFT JOIN 
    Tasks t ON e.EmployeeID = t.AssignedTo
GROUP BY 
    e.EmployeeID, e.EmployeeName;

-- Tính Lương Trung Bình Theo Vị Trí
SELECT 
    Position,
    AVG(Salary) AS AverageSalary
FROM 
    Employees
GROUP BY 
    Position;
