USE btsession3;

-- tạo bảng
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Major VARCHAR(50)
);

CREATE TABLE courses(
	CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Instructor VARCHAR(50) NOT NULL
);

-- Thêm 4 sinh viên vào bảng Students
INSERT INTO Students (StudentID, Name, Age, Major)
VALUES (1, 'Tuan', 20, 'CNTT'),
       (5, 'Duc', 22, 'Du lich'),
       (6, 'Manh', 21, 'Dien tu'),
       (4, 'Linh', 23, 'Dieu duong');

-- Thêm 3 môn học vào bảng Courses
INSERT INTO Courses (CourseID, CourseName, Instructor)
VALUES (1, 'Introduction to Programming', 'Dr. Smith'),
       (2, 'Calculus', 'Dr. Jones'),
       (3, 'Biology 101', 'Dr. Brown');

-- Cập nhật tên môn học có CourseID = 2 thành 'Advanced Mathematics'
UPDATE Courses
SET CourseName = 'Advanced Mathematics'
WHERE CourseID = 2;

-- Cập nhật chuyên ngành của sinh viên có StudentID = 3 thành 'Engineering'
UPDATE Students
SET Major = 'Engineering'
WHERE StudentID = 3;

-- Xóa sinh viên với StudentID = 1 khỏi bảng Students
DELETE FROM Students
WHERE StudentID = 1;

-- Xóa môn học với CourseID = 3 khỏi bảng Courses
DELETE FROM Courses
WHERE CourseID = 3;

-- Truy vấn dữ liệu
SELECT * FROM Students;
SELECT * FROM Courses;

