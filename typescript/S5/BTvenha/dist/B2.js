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
// Lớp Member kế thừa Person
class Member extends Person {
    constructor(id, name, membershipType) {
        super(id, name);
        this.membershipType = membershipType;
    }
    getMembershipType() {
        return this.membershipType;
    }
}
// Lớp Librarian kế thừa Person
class Librarian extends Person {
    constructor(id, name, position) {
        super(id, name);
        this.position = position;
    }
    getPosition() {
        return this.position;
    }
}
// Lớp Book
class Book {
    constructor(id, title, author) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.isBorrowed = false;
    }
    borrow() {
        if (this.isBorrowed) {
            console.log(`Error: Book "${this.title}" is already borrowed.`);
        }
        else {
            this.isBorrowed = true;
        }
    }
    returnBook() {
        this.isBorrowed = false;
    }
    getDetails() {
        return `Book [ID: ${this.id}, Title: "${this.title}", Author: "${this.author}", Borrowed: ${this.isBorrowed}]`;
    }
}
// Lớp BorrowRecord
class BorrowRecord {
    constructor(member, book) {
        this.member = member;
        this.book = book;
    }
    getRecordDetails() {
        return `Record [Member: ${this.member.getName()}, Book: "${this.book.title}"]`;
    }
}
// Lớp LibraryManager
class LibraryManager {
    constructor() {
        this.members = [];
        this.librarians = [];
        this.books = [];
        this.borrowRecords = [];
    }
    addMember(name, membershipType) {
        const id = this.members.length + 1;
        this.members.push(new Member(id, name, membershipType));
    }
    addLibrarian(name, position) {
        const id = this.librarians.length + 1;
        this.librarians.push(new Librarian(id, name, position));
    }
    addBook(title, author) {
        const id = this.books.length + 1;
        this.books.push(new Book(id, title, author));
    }
    borrowBook(memberId, bookId) {
        const member = this.members.find(m => m.id === memberId);
        const book = this.books.find(b => b.id === bookId);
        if (!member) {
            console.log("Error: Member not found.");
            return;
        }
        if (!book) {
            console.log("Error: Book not found.");
            return;
        }
        if (book.isBorrowed) {
            console.log(`Error: Book "${book.title}" is already borrowed.`);
            return;
        }
        book.borrow();
        this.borrowRecords.push(new BorrowRecord(member, book));
    }
    returnBook(bookId) {
        const book = this.books.find(b => b.id === bookId);
        if (!book) {
            console.log("Error: Book not found.");
            return;
        }
        if (!book.isBorrowed) {
            console.log(`Error: Book "${book.title}" is not borrowed.`);
            return;
        }
        book.returnBook();
    }
    listBorrowRecords() {
        this.borrowRecords.forEach(record => {
            console.log(record.getRecordDetails());
        });
    }
}
// Lớp Main
class Main {
    constructor() {
        this.libraryManager = new LibraryManager();
    }
    run() {
        while (true) {
            const choice = prompt(`
Menu:
1. Thêm thành viên.
2. Thêm thủ thư.
3. Thêm sách.
4. Mượn sách.
5. Trả sách.
6. Hiển thị danh sách bản ghi mượn sách.
7. Dừng chương trình.
Nhập lựa chọn: `);
            switch (choice) {
                case "1":
                    const memberName = prompt("Nhập tên thành viên: ") || "";
                    const membershipType = prompt("Nhập loại thẻ (VIP/Thường): ") || "";
                    this.libraryManager.addMember(memberName, membershipType);
                    break;
                case "2":
                    const librarianName = prompt("Nhập tên thủ thư: ") || "";
                    const position = prompt("Nhập vị trí công việc: ") || "";
                    this.libraryManager.addLibrarian(librarianName, position);
                    break;
                case "3":
                    const bookTitle = prompt("Nhập tên sách: ") || "";
                    const bookAuthor = prompt("Nhập tên tác giả: ") || "";
                    this.libraryManager.addBook(bookTitle, bookAuthor);
                    break;
                case "4":
                    const memberId = parseInt(prompt("Nhập ID thành viên: ") || "0", 10);
                    const bookId = parseInt(prompt("Nhập ID sách: ") || "0", 10);
                    this.libraryManager.borrowBook(memberId, bookId);
                    break;
                case "5":
                    const returnBookId = parseInt(prompt("Nhập ID sách: ") || "0", 10);
                    this.libraryManager.returnBook(returnBookId);
                    break;
                case "6":
                    this.libraryManager.listBorrowRecords();
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
