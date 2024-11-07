USE btsession3;

-- tạo bảng
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Major VARCHAR(50)
);

-- thêm dữ liệu
INSERT INTO Students (StudentID, Name, Age, Major)
VALUES (1, 'Alice', 20, 'Computer Science');

INSERT INTO Students (StudentID, Name, Age, Major)
VALUES (2, 'Bob', 22, 'Mathematics');

INSERT INTO Students (StudentID, Name, Age, Major)
VALUES (3, 'Charlie', 21, 'Physics');

-- cập nhật dữ liệu mới
UPDATE Students
SET Age = 23
WHERE StudentID = 2;
