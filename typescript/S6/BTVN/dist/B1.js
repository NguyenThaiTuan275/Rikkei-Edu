"use strict";
// 1. Class Person
// Lớp đại diện cho một người với các thuộc tính cơ bản như id và tên
class Person {
    constructor(id, // Mã định danh duy nhất của người
    name // Tên của người
    ) {
        this.id = id;
        this.name = name;
    }
    // Phương thức trả về tên của người
    getName() {
        return this.name;
    }
}
// 2. Class Employee
// Lớp đại diện cho nhân viên, kế thừa từ Person
class Employee extends Person {
    constructor(id, name, role // Vai trò của nhân viên
    ) {
        super(id, name); // Gọi hàm khởi tạo của lớp cha
        this.role = role;
    }
    // Phương thức trả về vai trò của nhân viên
    getRole() {
        return this.role;
    }
}
// 3. Class Manager
// Lớp đại diện cho người quản lý, kế thừa từ Employee
class Manager extends Employee {
    constructor(id, name, role, department // Bộ phận mà quản lý phụ trách
    ) {
        super(id, name, role); // Gọi hàm khởi tạo của lớp cha
        this.department = department;
    }
    // Phương thức trả về bộ phận của quản lý
    getDepartment() {
        return this.department;
    }
}
// 4. Class Task
// Lớp đại diện cho công việc
class Task {
    constructor(id, // Mã định danh duy nhất của công việc
    title, // Tên công việc
    deadline // Ngày hạn hoàn thành công việc
    ) {
        this.id = id;
        this.title = title;
        this.deadline = deadline;
        this.isCompleted = false; // Trạng thái hoàn thành của công việc (mặc định là chưa hoàn thành)
    }
    // Đánh dấu công việc là đã hoàn thành
    complete() {
        this.isCompleted = true;
    }
    // Lấy thông tin chi tiết về công việc
    getDetails() {
        return `Task ID: ${this.id}, Title: ${this.title}, Deadline: ${this.deadline.toDateString()}, Completed: ${this.isCompleted}`;
    }
}
// 5. Class Assignment
// Lớp đại diện cho việc phân công công việc
class Assignment {
    constructor(employee, // Nhân viên được phân công
    task // Công việc được phân công
    ) {
        this.employee = employee;
        this.task = task;
    }
    // Lấy thông tin chi tiết về việc phân công
    getAssignmentDetails() {
        return `Employee: ${this.employee.getName()} (${this.employee.getRole()}), Task: ${this.task.getDetails()}`;
    }
}
// 6. Class TaskManager
// Lớp quản lý tổng thể các nhân viên, công việc và phân công
class TaskManager {
    constructor() {
        this.employees = []; // Danh sách nhân viên
        this.managers = []; // Danh sách người quản lý
        this.tasks = []; // Danh sách công việc
        this.assignments = []; // Danh sách phân công công việc
    }
    // Thêm một nhân viên mới vào danh sách
    addEmployee(name, role) {
        const id = this.employees.length + 1;
        this.employees.push(new Employee(id, name, role));
    }
    // Thêm một người quản lý mới vào danh sách
    addManager(name, role, department) {
        const id = this.managers.length + 1;
        this.managers.push(new Manager(id, name, role, department));
    }
    // Thêm một công việc mới vào danh sách
    addTask(title, deadline) {
        const id = this.tasks.length + 1;
        this.tasks.push(new Task(id, title, new Date(deadline)));
    }
    // Phân công một công việc cho một nhân viên
    assignTask(employeeId, taskId) {
        const employee = this.employees.find(e => e['id'] === employeeId);
        const task = this.tasks.find(t => t['id'] === taskId);
        if (!employee) {
            console.error("Employee not found."); // Báo lỗi nếu không tìm thấy nhân viên
            return;
        }
        if (!task) {
            console.error("Task not found."); // Báo lỗi nếu không tìm thấy công việc
            return;
        }
        this.assignments.push(new Assignment(employee, task));
    }
    // Đánh dấu một công việc là đã hoàn thành
    completeTask(taskId) {
        const task = this.tasks.find(t => t['id'] === taskId);
        if (!task) {
            console.error("Task not found."); // Báo lỗi nếu không tìm thấy công việc
            return;
        }
        task.complete();
    }
    // Hiển thị danh sách phân công công việc
    listAssignments() {
        this.assignments.forEach(assignment => {
            console.log(assignment.getAssignmentDetails());
        });
    }
}
// 7. Main Program
// Giao diện dòng lệnh để người dùng tương tác
const taskManager = new TaskManager();
let isRunning = true;
while (isRunning) {
    console.log("\nMenu:");
    console.log("1. Add Employee");
    console.log("2. Add Manager");
    console.log("3. Add Task");
    console.log("4. Assign Task");
    console.log("5. Complete Task");
    console.log("6. List Assignments");
    console.log("7. Exit");
    const choice = parseInt(prompt("Choose an option:") || "0", 10);
    switch (choice) {
        case 1:
            const empName = prompt("Enter employee name:") || "";
            const empRole = prompt("Enter employee role:") || "";
            taskManager.addEmployee(empName, empRole);
            break;
        case 2:
            const mgrName = prompt("Enter manager name:") || "";
            const mgrRole = prompt("Enter manager role:") || "";
            const dept = prompt("Enter department:") || "";
            taskManager.addManager(mgrName, mgrRole, dept);
            break;
        case 3:
            const taskTitle = prompt("Enter task title:") || "";
            const taskDeadline = prompt("Enter task deadline (YYYY-MM-DD):") || "";
            taskManager.addTask(taskTitle, taskDeadline);
            break;
        case 4:
            const empId = parseInt(prompt("Enter employee ID:") || "0", 10);
            const taskId = parseInt(prompt("Enter task ID:") || "0", 10);
            taskManager.assignTask(empId, taskId);
            break;
        case 5:
            const compTaskId = parseInt(prompt("Enter task ID to complete:") || "0", 10);
            taskManager.completeTask(compTaskId);
            break;
        case 6:
            taskManager.listAssignments();
            break;
        case 7:
            isRunning = false;
            break;
        default:
            console.error("Invalid choice. Please try again.");
    }
}
