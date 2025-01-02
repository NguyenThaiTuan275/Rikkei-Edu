// Lớp Person
class Person {
    constructor(public id: number, public name: string) {}

    getName(): string {
        return this.name;
    }
}

// Lớp Member kế thừa Person
class Member extends Person {
    constructor(id: number, name: string, public membershipType: string) {
        super(id, name);
    }

    getMembershipType(): string {
        return this.membershipType;
    }
}

// Lớp Librarian kế thừa Person
class Librarian extends Person {
    constructor(id: number, name: string, public position: string) {
        super(id, name);
    }

    getPosition(): string {
        return this.position;
    }
}

// Lớp Book
class Book {
    isBorrowed: boolean = false;

    constructor(
        public id: number,
        public title: string,
        public author: string
    ) {}

    borrow(): void {
        if (this.isBorrowed) {
            console.log(`Error: Book "${this.title}" is already borrowed.`);
        } else {
            this.isBorrowed = true;
        }
    }

    returnBook(): void {
        this.isBorrowed = false;
    }

    getDetails(): string {
        return `Book [ID: ${this.id}, Title: "${this.title}", Author: "${this.author}", Borrowed: ${this.isBorrowed}]`;
    }
}

// Lớp BorrowRecord
class BorrowRecord {
    constructor(public member: Member, public book: Book) {}

    getRecordDetails(): string {
        return `Record [Member: ${this.member.getName()}, Book: "${this.book.title}"]`;
    }
}

// Lớp LibraryManager
class LibraryManager {
    members: Member[] = [];
    librarians: Librarian[] = [];
    books: Book[] = [];
    borrowRecords: BorrowRecord[] = [];

    addMember(name: string, membershipType: string): void {
        const id = this.members.length + 1;
        this.members.push(new Member(id, name, membershipType));
    }

    addLibrarian(name: string, position: string): void {
        const id = this.librarians.length + 1;
        this.librarians.push(new Librarian(id, name, position));
    }

    addBook(title: string, author: string): void {
        const id = this.books.length + 1;
        this.books.push(new Book(id, title, author));
    }

    borrowBook(memberId: number, bookId: number): void {
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

    returnBook(bookId: number): void {
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

    listBorrowRecords(): void {
        this.borrowRecords.forEach(record => {
            console.log(record.getRecordDetails());
        });
    }
}

// Lớp Main
class Main {
    private libraryManager = new LibraryManager();

    run(): void {
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
