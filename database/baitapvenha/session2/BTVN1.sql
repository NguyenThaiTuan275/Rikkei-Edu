-- create database CompanyDB;
USE CompanyDB;

-- Tạo bảng Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL
);

-- Thêm trường Department vào bảng Employees
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- Chỉnh sửa kiểu dữ liệu của trường Salary
ALTER TABLE Employees
MODIFY Salary DECIMAL(10, 2);
