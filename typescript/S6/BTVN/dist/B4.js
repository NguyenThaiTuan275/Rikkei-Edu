"use strict";
// Lớp Person (Người dùng)
class Person {
    constructor(id, name, email) {
        this.id = id;
        this.name = name;
        this.email = email;
    }
    getDetails() {
        return `User [ID: ${this.id}, Name: ${this.name}, Email: ${this.email}]`;
    }
}
// Lớp Student (Học viên)
class Student extends Person {
    constructor(id, name, email) {
        super(id, name, email);
        this.enrolledCourses = [];
    }
    enroll(course) {
        this.enrolledCourses.push(course);
        console.log(`${this.name} has enrolled in ${course.title}`);
    }
}
// Lớp Course (Khóa học - Abstract Class)
class Course {
    constructor(courseId, title, duration, // Duration in hours
    price // Price in currency
    ) {
        this.courseId = courseId;
        this.title = title;
        this.duration = duration;
        this.price = price;
    }
    getDetails() {
        return `Course [ID: ${this.courseId}, Title: ${this.title}, Duration: ${this.duration} hours, Price: ${this.price}]`;
    }
}
// Lớp BasicCourse (Khóa học cơ bản)
class BasicCourse extends Course {
    constructor(courseId, title, duration, price) {
        super(courseId, title, duration, price);
    }
    calculatePrice() {
        return this.price; // Fixed price for basic course
    }
}
// Lớp PremiumCourse (Khóa học cao cấp)
class PremiumCourse extends Course {
    constructor(courseId, title, duration, price) {
        super(courseId, title, duration, price);
    }
    calculatePrice() {
        return this.price + 50; // Additional fee for premium course
    }
}
// Lớp LiveCourse (Khóa học trực tiếp)
class LiveCourse extends Course {
    constructor(courseId, title, duration, price) {
        super(courseId, title, duration, price);
    }
    calculatePrice() {
        return this.price + 100; // Additional fee for live course
    }
}
// Lớp Enrollment (Đăng ký)
class Enrollment {
    constructor(student, course, enrollmentDate) {
        this.student = student;
        this.course = course;
        this.enrollmentDate = enrollmentDate;
    }
    getDetails() {
        return `Enrollment [Student: ${this.student.name}, Course: ${this.course.title}, Date: ${this.enrollmentDate.toDateString()}]`;
    }
}
// Lớp CourseManager (Quản lý khóa học)
class CourseManager {
    constructor() {
        this.students = [];
        this.courses = [];
        this.enrollments = [];
    }
    addCourse(type, title, duration, price) {
        const courseId = this.courses.length + 1;
        let course;
        if (type === 'Basic') {
            course = new BasicCourse(courseId, title, duration, price);
        }
        else if (type === 'Premium') {
            course = new PremiumCourse(courseId, title, duration, price);
        }
        else if (type === 'Live') {
            course = new LiveCourse(courseId, title, duration, price);
        }
        else {
            console.log("Invalid course type.");
            return;
        }
        this.courses.push(course);
        console.log(`${type} course [ID: ${courseId}] added.`);
    }
    addStudent(name, email) {
        const studentId = this.students.length + 1;
        const student = new Student(studentId, name, email);
        this.students.push(student);
        console.log(`Student [ID: ${studentId}] added.`);
    }
    enrollStudent(studentId, courseId) {
        const student = this.students.find(s => s.id === studentId);
        const course = this.courses.find(c => c.courseId === courseId);
        if (!student || !course) {
            console.log("Error: Student or Course not found.");
            return;
        }
        student.enroll(course);
        const enrollmentDate = new Date();
        const enrollment = new Enrollment(student, course, enrollmentDate);
        this.enrollments.push(enrollment);
        console.log(`Student [ID: ${studentId}] enrolled in Course [ID: ${courseId}].`);
    }
    listCourses() {
        console.log("Available Courses:");
        this.courses.forEach(course => {
            console.log(course.getDetails());
        });
    }
}
// Chương trình chính
class Main {
    constructor() {
        this.courseManager = new CourseManager();
    }
    run() {
        while (true) {
            console.log(`
Menu:
1. Add Course
2. Add Student
3. Enroll Student
4. List Courses
5. Exit
            `);
            const choice = Number(prompt("Enter your choice: "));
            try {
                switch (choice) {
                    case 1:
                        const courseType = prompt("Enter course type (Basic/Premium/Live): ");
                        const courseTitle = prompt("Enter course title: ");
                        const courseDuration = Number(prompt("Enter course duration (hours): "));
                        const coursePrice = Number(prompt("Enter course price: "));
                        this.courseManager.addCourse(courseType, courseTitle, courseDuration, coursePrice);
                        break;
                    case 2:
                        const studentName = prompt("Enter student name: ");
                        const studentEmail = prompt("Enter student email: ");
                        this.courseManager.addStudent(studentName, studentEmail);
                        break;
                    case 3:
                        const studentId = Number(prompt("Enter student ID: "));
                        const courseId = Number(prompt("Enter course ID: "));
                        this.courseManager.enrollStudent(studentId, courseId);
                        break;
                    case 4:
                        this.courseManager.listCourses();
                        break;
                    case 5:
                        console.log("Exiting...");
                        return;
                    default:
                        console.log("Invalid choice. Please try again.");
                }
            }
            catch (error) {
                console.error(error.message);
            }
        }
    }
}
// Khởi tạo và chạy ứng dụng
const app = new Main();
app.run();
