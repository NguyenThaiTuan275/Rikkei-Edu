// Lớp Person (Khách hàng)
class Person {
    constructor(
        public id: number,
        public name: string,
        public email: string
    ) {}

    getName(): string {
        return `Customer [ID: ${this.id}, Name: ${this.name}]`;
    }
}

// Lớp BankAccount (Abstract Class)
abstract class BankAccount {
    constructor(
        public accountId: number,
        public owner: Person,
        public balance: number
    ) {}

    deposit(amount: number): void {
        if (amount <= 0) throw new Error("Amount must be greater than 0.");
        this.balance += amount;
        console.log(`Deposited $${amount} into account ${this.accountId}.`);
    }

    withdraw(amount: number): void {
        if (amount <= 0) throw new Error("Amount must be greater than 0.");
        if (amount > this.balance) throw new Error("Insufficient balance.");
        this.balance -= amount;
        console.log(`Withdrew $${amount} from account ${this.accountId}.`);
    }

    getBalance(): number {
        return this.balance;
    }

    abstract applyInterest(): void;
}

// Lớp SavingsAccount
class SavingsAccount extends BankAccount {
    private static readonly INTEREST_RATE = 0.03;
    private static readonly MIN_BALANCE = 500;

    applyInterest(): void {
        const interest = this.balance * SavingsAccount.INTEREST_RATE;
        this.balance += interest;
        console.log(`Applied interest of $${interest.toFixed(2)} to Savings Account ${this.accountId}.`);
    }

    withdraw(amount: number): void {
        if (this.balance - amount < SavingsAccount.MIN_BALANCE) {
            throw new Error("Cannot withdraw below the minimum balance.");
        }
        super.withdraw(amount);
    }
}

// Lớp CheckingAccount
class CheckingAccount extends BankAccount {
    applyInterest(): void {
        console.log(`No interest applied to Checking Account ${this.accountId}.`);
    }
}

// Lớp BusinessAccount
class BusinessAccount extends BankAccount {
    private static readonly INTEREST_RATE = 0.01;
    private static readonly TRANSACTION_FEE = 0.02;

    applyInterest(): void {
        const interest = this.balance * BusinessAccount.INTEREST_RATE;
        this.balance += interest;
        console.log(`Applied interest of $${interest.toFixed(2)} to Business Account ${this.accountId}.`);
    }

    deposit(amount: number): void {
        const fee = amount * BusinessAccount.TRANSACTION_FEE;
        super.deposit(amount - fee);
        console.log(`Transaction fee of $${fee.toFixed(2)} applied.`);
    }

    withdraw(amount: number): void {
        const fee = amount * BusinessAccount.TRANSACTION_FEE;
        if (amount + fee > this.balance) throw new Error("Insufficient balance.");
        super.withdraw(amount + fee);
        console.log(`Transaction fee of $${fee.toFixed(2)} applied.`);
    }
}

// Lớp Transaction
class Transaction {
    constructor(
        public transactionId: number,
        public account: BankAccount,
        public type: string,
        public amount: number,
        public timestamp: Date = new Date()
    ) {}

    getDetails(): string {
        return `Transaction [ID: ${this.transactionId}, Account: ${this.account.accountId}, Type: ${this.type}, Amount: $${this.amount}, Date: ${this.timestamp.toLocaleString()}]`;
    }
}

// Lớp BankManager
class BankManager {
    private customers: Person[] = [];
    private accounts: BankAccount[] = [];
    private transactions: Transaction[] = [];

    addCustomer(name: string, email: string): void {
        const id = this.customers.length + 1;
        const customer = new Person(id, name, email);
        this.customers.push(customer);
        console.log(`Customer [ID: ${id}] added successfully.`);
    }

    createAccount(customerId: number, type: string): void {
        const customer = this.customers.find(c => c.id === customerId);
        if (!customer) throw new Error("Customer not found.");

        const accountId = this.accounts.length + 1;
        let account: BankAccount;

        switch (type.toLowerCase()) {
            case "savings":
                account = new SavingsAccount(accountId, customer, 0);
                break;
            case "checking":
                account = new CheckingAccount(accountId, customer, 0);
                break;
            case "business":
                account = new BusinessAccount(accountId, customer, 0);
                break;
            default:
                throw new Error("Invalid account type.");
        }

        this.accounts.push(account);
        console.log(`Account [ID: ${accountId}, Type: ${type}] created successfully.`);
    }

    performTransaction(accountId: number, type: string, amount: number): void {
        const account = this.accounts.find(a => a.accountId === accountId);
        if (!account) throw new Error("Account not found.");

        switch (type.toLowerCase()) {
            case "deposit":
                account.deposit(amount);
                break;
            case "withdraw":
                account.withdraw(amount);
                break;
            default:
                throw new Error("Invalid transaction type.");
        }

        const transactionId = this.transactions.length + 1;
        const transaction = new Transaction(transactionId, account, type, amount);
        this.transactions.push(transaction);

        console.log(transaction.getDetails());
    }

    applyMonthlyInterest(): void {
        this.accounts.forEach(account => account.applyInterest());
    }
}

// Lớp BankApp (Chương trình chính)
class BankApp {
    private manager: BankManager;

    constructor() {
        this.manager = new BankManager();
    }

    run(): void {
        while (true) {
            console.log(`
Menu:
1. Add Customer
2. Create Account
3. Perform Transaction
4. Apply Monthly Interest
5. Exit
            `);

            const choice = Number(prompt("Enter your choice: "));
            try {
                switch (choice) {
                    case 1:
                        const name = prompt("Enter customer name: ");
                        const email = prompt("Enter customer email: ");
                        this.manager.addCustomer(name, email);
                        break;

                    case 2:
                        const customerId = Number(prompt("Enter customer ID: "));
                        const accountType = prompt("Enter account type (Savings/Checking/Business): ");
                        this.manager.createAccount(customerId, accountType);
                        break;

                    case 3:
                        const accountId = Number(prompt("Enter account ID: "));
                        const transactionType = prompt("Enter transaction type (Deposit/Withdraw): ");
                        const amount = Number(prompt("Enter amount: "));
                        this.manager.performTransaction(accountId, transactionType, amount);
                        break;

                    case 4:
                        this.manager.applyMonthlyInterest();
                        break;

                    case 5:
                        console.log("Exiting program...");
                        return;

                    default:
                        console.log("Invalid choice. Please try again.");
                }
            } catch (error: any) {
                console.error(error.message);
            }
        }
    }
}

// Khởi tạo và chạy ứng dụng
const bankApp = new BankApp();
bankApp.run();
