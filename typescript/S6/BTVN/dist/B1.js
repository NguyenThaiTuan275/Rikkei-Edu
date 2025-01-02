"use strict";
// Lớp Person (Người)
class Person {
    constructor(id, name) {
        this.id = id;
        this.name = name;
    }
    getName() {
        return this.name;
    }
}
// Lớp Employee (Nhân viên) kế thừa từ Person
class Employee extends Person {
    constructor(id, name, role) {
        super(id, name);
        this.role = role;
    }
    getRole() {
        return this.role;
    }
}
// Lớp Manager (Quản lý) kế thừa từ Employee
class Manager extends Employee {
    constructor(id, name, role, department) {
        super(id, name, role);
        this.department = department;
    }
    getDepartment() {
        return this.department;
    }
}
// Lớp Task (Công việc)
class Task {
    constructor(id, title, deadline) {
        this.id = id;
        this.title = title;
        this.deadline = deadline;
        this.isCompleted = false;
    }
    complete() {
        this.isCompleted = true;
        console.log(`Task [ID: ${this.id}] is completed.`);
    }
    getDetails() {
        return `Task [ID: ${this.id}, Title: ${this.title}, Deadline: ${this.deadline.toLocaleDateString()}, Completed: ${this.isCompleted}]`;
    }
}
// Lớp Assignment (Phân công công việc)
class Assignment {
    constructor(employee, task) {
        this.employee = employee;
        this.task = task;
    }
    getAssignmentDetails() {
        return `${this.employee.getName()} is assigned to task: ${this.task.getDetails()}`;
    }
}
// Lớp TaskManager (Quản lý công việc)
class TaskManager {
    constructor() {
        this.employees = [];
        this.managers = [];
        this.tasks = [];
        this.assignments = [];
    }
    addEmployee(name, role) {
        const id = this.employees.length + 1;
        const employee = new Employee(id, name, role);
        this.employees.push(employee);
        console.log(`Employee [ID: ${id}] added.`);
    }
    addManager(name, role, department) {
        const id = this.managers.length + 1;
        const manager = new Manager(id, name, role, department);
        this.managers.push(manager);
        console.log(`Manager [ID: ${id}] added.`);
    }
    addTask(title, deadline) {
        const id = this.tasks.length + 1;
        const task = new Task(id, title, new Date(deadline));
        this.tasks.push(task);
        console.log(`Task [ID: ${id}] added.`);
    }
    assignTask(employeeId, taskId) {
        const employee = this.employees.find(e => e.id === employeeId);
        const task = this.tasks.find(t => t.id === taskId);
        if (!employee || !task) {
            console.log("Error: Employee or Task not found.");
            return;
        }
        if (task.isCompleted) {
            console.log("Error: Task is already completed.");
            return;
        }
        const assignment = new Assignment(employee, task);
        this.assignments.push(assignment);
        console.log(`Task [ID: ${taskId}] assigned to Employee [ID: ${employeeId}].`);
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
        console.log("Assignments:");
        this.assignments.forEach(assignment => {
            console.log(assignment.getAssignmentDetails());
        });
    }
}
// Lớp Main (Chương trình chính)
class Main {
    constructor() {
        this.taskManager = new TaskManager();
    }
    run() {
        while (true) {
            console.log(`
Menu:
1. Add Employee
2. Add Manager
3. Add Task
4. Assign Task to Employee
5. Mark Task as Completed
6. List Assignments
7. Exit
            `);
            const choice = Number(prompt("Enter your choice: "));
            try {
                switch (choice) {
                    case 1:
                        const employeeName = prompt("Enter employee name: ");
                        const employeeRole = prompt("Enter employee role: ");
                        this.taskManager.addEmployee(employeeName, employeeRole);
                        break;
                    case 2:
                        const managerName = prompt("Enter manager name: ");
                        const managerRole = prompt("Enter manager role: ");
                        const department = prompt("Enter manager department: ");
                        this.taskManager.addManager(managerName, managerRole, department);
                        break;
                    case 3:
                        const taskTitle = prompt("Enter task title: ");
                        const taskDeadline = prompt("Enter task deadline (YYYY-MM-DD): ");
                        this.taskManager.addTask(taskTitle, taskDeadline);
                        break;
                    case 4:
                        const employeeId = Number(prompt("Enter employee ID: "));
                        const taskId = Number(prompt("Enter task ID: "));
                        this.taskManager.assignTask(employeeId, taskId);
                        break;
                    case 5:
                        const taskIdToComplete = Number(prompt("Enter task ID to complete: "));
                        this.taskManager.completeTask(taskIdToComplete);
                        break;
                    case 6:
                        this.taskManager.listAssignments();
                        break;
                    case 7:
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
