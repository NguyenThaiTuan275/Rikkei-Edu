// 1. Class Person
// Lớp đại diện cho một người với các thuộc tính cơ bản như id và tên
class Person {
    constructor(
        private id: number, // Mã định danh duy nhất của người
        private name: string // Tên của người
    ) {}

    // Phương thức trả về tên của người
    getName(): string {
        return this.name;
    }
}

// 2. Class Employee
// Lớp đại diện cho nhân viên, kế thừa từ Person
class Employee extends Person {
    constructor(
        id: number,
        name: string,
        private role: string // Vai trò của nhân viên
    ) {
        super(id, name); // Gọi hàm khởi tạo của lớp cha
    }

    // Phương thức trả về vai trò của nhân viên
    getRole(): string {
        return this.role;
    }
}

// 3. Class Manager
// Lớp đại diện cho người quản lý, kế thừa từ Employee
class Manager extends Employee {
    constructor(
        id: number,
        name: string,
        role: string,
        private department: string // Bộ phận mà quản lý phụ trách
    ) {
        super(id, name, role); // Gọi hàm khởi tạo của lớp cha
    }

    // Phương thức trả về bộ phận của quản lý
    getDepartment(): string {
        return this.department;
    }
}

// 4. Class Task
// Lớp đại diện cho công việc
class Task {
    private isCompleted: boolean = false; // Trạng thái hoàn thành của công việc (mặc định là chưa hoàn thành)

    constructor(
        private id: number, // Mã định danh duy nhất của công việc
        private title: string, // Tên công việc
        private deadline: Date // Ngày hạn hoàn thành công việc
    ) {}

    // Đánh dấu công việc là đã hoàn thành
    complete(): void {
        this.isCompleted = true;
    }

    // Lấy thông tin chi tiết về công việc
    getDetails(): string {
        return `Task ID: ${this.id}, Title: ${this.title}, Deadline: ${this.deadline.toDateString()}, Completed: ${this.isCompleted}`;
    }
}

// 5. Class Assignment
// Lớp đại diện cho việc phân công công việc
class Assignment {
    constructor(
        private employee: Employee, // Nhân viên được phân công
        private task: Task // Công việc được phân công
    ) {}

    // Lấy thông tin chi tiết về việc phân công
    getAssignmentDetails(): string {
        return `Employee: ${this.employee.getName()} (${this.employee.getRole()}), Task: ${this.task.getDetails()}`;
    }
}

// 6. Class TaskManager
// Lớp quản lý tổng thể các nhân viên, công việc và phân công
class TaskManager {
    private employees: Employee[] = []; // Danh sách nhân viên
    private managers: Manager[] = []; // Danh sách người quản lý
    private tasks: Task[] = []; // Danh sách công việc
    private assignments: Assignment[] = []; // Danh sách phân công công việc

    // Thêm một nhân viên mới vào danh sách
    addEmployee(name: string, role: string): void {
        const id = this.employees.length + 1;
        this.employees.push(new Employee(id, name, role));
    }

    // Thêm một người quản lý mới vào danh sách
    addManager(name: string, role: string, department: string): void {
        const id = this.managers.length + 1;
        this.managers.push(new Manager(id, name, role, department));
    }

    // Thêm một công việc mới vào danh sách
    addTask(title: string, deadline: string): void {
        const id = this.tasks.length + 1;
        this.tasks.push(new Task(id, title, new Date(deadline)));
    }

    // Phân công một công việc cho một nhân viên
    assignTask(employeeId: number, taskId: number): void {
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
    completeTask(taskId: number): void {
        const task = this.tasks.find(t => t['id'] === taskId);

        if (!task) {
            console.error("Task not found."); // Báo lỗi nếu không tìm thấy công việc
            return;
        }

        task.complete();
    }

    // Hiển thị danh sách phân công công việc
    listAssignments(): void {
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
