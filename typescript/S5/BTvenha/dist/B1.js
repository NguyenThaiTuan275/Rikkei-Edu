"use strict";
// Lớp Person
class Person {
    constructor(id, name) {
        this.id = id;
        this.name = name;
    }
    getName() {
        return this.name;
    }
}
// Lớp Employee kế thừa Person
class Employee extends Person {
    constructor(id, name, role) {
        super(id, name);
        this.role = role;
    }
    getRole() {
        return this.role;
    }
}
// Lớp Manager kế thừa Employee
class Manager extends Employee {
    constructor(id, name, role, department) {
        super(id, name, role);
        this.department = department;
    }
    getDepartment() {
        return this.department;
    }
}
// Lớp Task
class Task {
    constructor(id, title, deadline) {
        this.id = id;
        this.title = title;
        this.deadline = deadline;
        this.isCompleted = false;
    }
    complete() {
        this.isCompleted = true;
    }
    getDetails() {
        return `Task [ID: ${this.id}, Title: ${this.title}, Deadline: ${this.deadline.toDateString()}, Completed: ${this.isCompleted}]`;
    }
}
// Lớp Assignment
class Assignment {
    constructor(employee, task) {
        this.employee = employee;
        this.task = task;
    }
    getAssignmentDetails() {
        return `Assignment [Employee: ${this.employee.getName()}, Task: ${this.task.title}]`;
    }
}
// Lớp TaskManager
class TaskManager {
    constructor() {
        this.employees = [];
        this.managers = [];
        this.tasks = [];
        this.assignments = [];
    }
    addEmployee(name, role) {
        const id = this.employees.length + 1;
        this.employees.push(new Employee(id, name, role));
    }
    addManager(name, role, department) {
        const id = this.managers.length + 1;
        this.managers.push(new Manager(id, name, role, department));
    }
    addTask(title, deadline) {
        const id = this.tasks.length + 1;
        this.tasks.push(new Task(id, title, new Date(deadline)));
    }
    assignTask(employeeId, taskId) {
        const employee = this.employees.find(emp => emp.id === employeeId);
        const task = this.tasks.find(t => t.id === taskId);
        if (!employee) {
            console.log("Error: Employee not found.");
            return;
        }
        if (!task) {
            console.log("Error: Task not found.");
            return;
        }
        this.assignments.push(new Assignment(employee, task));
    }
    completeTask(taskId) {
        const task = this.tasks.find(t => t.id === taskId);
        if (!task) {
            console.log("Error: Task not found.");
            return;
        }
        task.complete();
    }
    listAssignments() {
        this.assignments.forEach(assignment => {
            console.log(assignment.getAssignmentDetails());
        });
    }
}
// Lớp Main
class Main {
    constructor() {
        this.taskManager = new TaskManager();
    }
    run() {
        while (true) {
            const choice = prompt(`
Menu:
1. Thêm nhân viên.
2. Thêm quản lý.
3. Thêm công việc.
4. Phân công công việc cho nhân viên.
5. Đánh dấu công việc hoàn thành.
6. Hiển thị danh sách công việc đã phân công.
7. Dừng chương trình.
Nhập lựa chọn: `);
            switch (choice) {
                case "1":
                    const empName = prompt("Nhập tên nhân viên: ") || "";
                    const empRole = prompt("Nhập vai trò nhân viên: ") || "";
                    this.taskManager.addEmployee(empName, empRole);
                    break;
                case "2":
                    const mgrName = prompt("Nhập tên quản lý: ") || "";
                    const mgrRole = prompt("Nhập vai trò quản lý: ") || "";
                    const department = prompt("Nhập bộ phận quản lý: ") || "";
                    this.taskManager.addManager(mgrName, mgrRole, department);
                    break;
                case "3":
                    const taskTitle = prompt("Nhập tên công việc: ") || "";
                    const taskDeadline = prompt("Nhập ngày hạn hoàn thành (yyyy-mm-dd): ") || "";
                    this.taskManager.addTask(taskTitle, taskDeadline);
                    break;
                case "4":
                    const empId = parseInt(prompt("Nhập ID nhân viên: ") || "0", 10);
                    const taskId = parseInt(prompt("Nhập ID công việc: ") || "0", 10);
                    this.taskManager.assignTask(empId, taskId);
                    break;
                case "5":
                    const completeTaskId = parseInt(prompt("Nhập ID công việc: ") || "0", 10);
                    this.taskManager.completeTask(completeTaskId);
                    break;
                case "6":
                    this.taskManager.listAssignments();
                    break;
                case "7":
                    console.log("Chương trình kết thúc.");
                    return;
                default:
                    console.log("Lựa chọn không hợp lệ.");
            }
        }
    }
}
// Chạy chương trình
const app = new Main();
app.run();