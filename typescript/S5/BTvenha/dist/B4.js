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
// Lớp Customer kế thừa từ Person
class Customer extends Person {
    constructor(id, name, email, phone) {
        super(id, name);
        this.email = email;
        this.phone = phone;
    }
    getContactDetails() {
        return `Email: ${this.email}, Phone: ${this.phone}`;
    }
}
// Lớp Employee kế thừa từ Person
class Employee extends Person {
    constructor(id, name, position) {
        super(id, name);
        this.position = position;
    }
    getPosition() {
        return this.position;
    }
}
// Lớp Product
class Product {
    constructor(id, name, price, quantity) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }
    sell(quantity) {
        if (quantity > this.quantity) {
            console.log(`Error: Not enough stock for product "${this.name}".`);
        }
        else {
            this.quantity -= quantity;
        }
    }
    restock(quantity) {
        this.quantity += quantity;
    }
    getDetails() {
        return `Product [ID: ${this.id}, Name: "${this.name}", Price: ${this.price}, Quantity: ${this.quantity}]`;
    }
}
// Lớp Invoice
class Invoice {
    constructor(customer, employee, products) {
        this.customer = customer;
        this.employee = employee;
        this.products = products;
        this.totalAmount = 0;
        this.calculateTotal();
    }
    calculateTotal() {
        this.totalAmount = this.products.reduce((total, item) => total + item.product.price * item.quantity, 0);
    }
    getInvoiceDetails() {
        return `
Invoice:
Customer: ${this.customer.getName()}
Employee: ${this.employee.getName()}
Products:
${this.products
            .map(item => ` - ${item.product.name}: ${item.quantity} x ${item.product.price} = ${item.quantity * item.product.price}`)
            .join("\n")}
Total Amount: ${this.totalAmount}
`;
    }
}
// Lớp StoreManager
class StoreManager {
    constructor() {
        this.customers = [];
        this.employees = [];
        this.products = [];
        this.invoices = [];
    }
    addCustomer(name, email, phone) {
        const id = this.customers.length + 1;
        this.customers.push(new Customer(id, name, email, phone));
    }
    addEmployee(name, position) {
        const id = this.employees.length + 1;
        this.employees.push(new Employee(id, name, position));
    }
    addProduct(name, price, quantity) {
        const id = this.products.length + 1;
        this.products.push(new Product(id, name, price, quantity));
    }
    sellProduct(customerId, employeeId, productId, quantity) {
        const customer = this.customers.find(c => c.id === customerId);
        const employee = this.employees.find(e => e.id === employeeId);
        const product = this.products.find(p => p.id === productId);
        if (!customer) {
            console.log("Error: Customer not found.");
            return;
        }
        if (!employee) {
            console.log("Error: Employee not found.");
            return;
        }
        if (!product) {
            console.log("Error: Product not found.");
            return;
        }
        if (product.quantity < quantity) {
            console.log(`Error: Not enough stock for product "${product.name}".`);
            return;
        }
        product.sell(quantity);
        const invoice = new Invoice(customer, employee, [{ product, quantity }]);
        this.invoices.push(invoice);
    }
    restockProduct(productId, quantity) {
        const product = this.products.find(p => p.id === productId);
        if (!product) {
            console.log("Error: Product not found.");
            return;
        }
        product.restock(quantity);
    }
    listInvoices() {
        this.invoices.forEach(invoice => {
            console.log(invoice.getInvoiceDetails());
        });
    }
}
// Lớp Main
class Main {
    constructor() {
        this.storeManager = new StoreManager();
    }
    run() {
        while (true) {
            const choice = prompt(`
Menu:
1. Thêm khách hàng.
2. Thêm nhân viên.
3. Thêm sản phẩm.
4. Bán hàng (Tạo hóa đơn).
5. Nhập hàng bổ sung.
6. Hiển thị danh sách hóa đơn.
7. Dừng chương trình.
Nhập lựa chọn: `);
            switch (choice) {
                case "1":
                    const customerName = prompt("Nhập tên khách hàng: ") || "";
                    const email = prompt("Nhập email khách hàng: ") || "";
                    const phone = prompt("Nhập số điện thoại khách hàng: ") || "";
                    this.storeManager.addCustomer(customerName, email, phone);
                    break;
                case "2":
                    const employeeName = prompt("Nhập tên nhân viên: ") || "";
                    const position = prompt("Nhập vị trí công việc: ") || "";
                    this.storeManager.addEmployee(employeeName, position);
                    break;
                case "3":
                    const productName = prompt("Nhập tên sản phẩm: ") || "";
                    const price = parseFloat(prompt("Nhập giá sản phẩm: ") || "0");
                    const quantity = parseInt(prompt("Nhập số lượng sản phẩm: ") || "0", 10);
                    this.storeManager.addProduct(productName, price, quantity);
                    break;
                case "4":
                    const customerId = parseInt(prompt("Nhập ID khách hàng: ") || "0", 10);
                    const employeeId = parseInt(prompt("Nhập ID nhân viên: ") || "0", 10);
                    const productId = parseInt(prompt("Nhập ID sản phẩm: ") || "0", 10);
                    const qty = parseInt(prompt("Nhập số lượng sản phẩm: ") || "0", 10);
                    this.storeManager.sellProduct(customerId, employeeId, productId, qty);
                    break;
                case "5":
                    const restockProductId = parseInt(prompt("Nhập ID sản phẩm: ") || "0", 10);
                    const restockQuantity = parseInt(prompt("Nhập số lượng bổ sung: ") || "0", 10);
                    this.storeManager.restockProduct(restockProductId, restockQuantity);
                    break;
                case "6":
                    this.storeManager.listInvoices();
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