"use strict";
class Person {
    constructor(name) {
        this._id = ++Person.idCounter;
        this._name = name;
    }
    get id() {
        return this._id;
    }
    get name() {
        return this._name;
    }
    set name(name) {
        this.name = name;
    }
}
Person.idCounter = 0;
class Member extends Person {
    constructor(name, membershipType) {
        super(name);
        this._membershipType = membershipType;
    }
    get membershipType() {
        return this._membershipType;
    }
    set membershipType(membershipType) {
        this._membershipType = membershipType;
    }
}
class Librarian extends Person {
    constructor(name, position) {
        super(name);
        this._position = position;
    }
    get position() {
        return this._position;
    }
}
class CD {
    constructor(title, artist, isBorrowed) {
        this._id = ++CD.idCounter;
        this._title = title;
        this._artist = artist;
        this._isBorrowed = isBorrowed;
    }
    get title() {
        return this._title;
    }
    get artist() {
        return this._artist;
    }
    get isBorrowed() {
        return this._isBorrowed;
    }
    borrowed() {
        if (this._isBorrowed = true) {
            console.log("CD đã được mượn");
        }
    }
    returnCD() {
        if (this._isBorrowed = false) {
            console.log("CD chưa được mượn");
        }
    }
    getDetails() {
        return `CD [ID: ${this._id}, Title: ${this._title}, Artist: ${this._artist}, Borrowed: ${this._isBorrowed}]`;
    }
    get id() {
        return this._id;
    }
}
CD.idCounter = 0;
class BorrowRecord {
    constructor(member, cd) {
        this._cd = cd;
        this._member = member;
    }
    getRecordDetails() {
        return `Borrowed record [Member: ${this._member.name}, CD: ${this._cd.getDetails()}]`;
    }
}
class LibraryManager {
    constructor() {
        this.members = [];
        this.librarians = [];
        this.cds = [];
        this.borrowRecords = [];
    }
    addMember(name, membershipType) {
        this.members.push(new Member(name, membershipType));
        console.log("*************************");
        if (this.members.length === 0) {
            console.log("Không có bất kỳ nhân viên nào");
        }
        else {
            this.members.forEach(function (element, index) {
                console.log(`${index + 1}.${element.name} - ${element.membershipType}`);
            });
        }
    }
    addLibrarian(name, position) {
        this.librarians.push(new Librarian(name, position));
        console.log("*************************");
        if (this.librarians.length === 0) {
            console.log("Không có bất kỳ nhân viên nào");
        }
        else {
            this.librarians.forEach(function (element, index) {
                console.log(`${index + 1}.${element.name} - ${element.position}`);
            });
        }
    }
    addCD(title, artist, isBorrowed) {
        let cd = new CD(title, artist, false);
        this.cds.push(cd);
        console.log("*************************");
        if (this.cds.length === 0) {
            console.log("Không có bất kỳ nhân viên nào");
        }
        else {
            this.cds.forEach(function (element, index) {
                console.log(`${index + 1}.${element.getDetails()}`);
            });
        }
    }
    borrowCD(memberId, cdId) {
        let member = this.members.find(m => m.id === memberId);
        let cd = this.cds.find(c => c.id === cdId);
        if (!member) {
            console.log("Không tìm thấy thành viên với ID: " + memberId);
        }
        if (!cd) {
            console.log("Không tìm thấy CD với ID: " + cdId);
        }
        let borrowRecord = new BorrowRecord(member, cd);
        this.borrowRecords.push(borrowRecord);
        console.log(`Đã cho thành viên ${member === null || member === void 0 ? void 0 : member.name} mượn CD ${cd === null || cd === void 0 ? void 0 : cd.title}`);
    }
    returnCD(cdId) {
        let cd = this.cds.find(c => c.id === cdId);
        if (!cd)
            throw new Error("CD not found.");
        cd.returnCD();
    }
    listBorrowRecords() {
        this.borrowRecords.forEach(record => {
            console.log(record.getRecordDetails());
        });
    }
}
class Main {
    constructor() {
        this._libraryManager = new LibraryManager;
    }
    bootstrap() {
        let loop = true;
        while (loop) {
            console.log("Menu chức năng:");
            console.log("1, Thêm thành viên");
            console.log("2. Thêm thủ thư");
            console.log("3. Thêm CD");
            console.log("4. Mượn CD");
            console.log("5. Trả CD");
            console.log("6. Hiển thị danh sách bản ghi mượn CD");
            console.log("7. Dừng chương trình");
            let choice = prompt("Mời bạn nhập vào lựa chọn (1 - 7)");
            switch (choice) {
                case "1":
                    let membermemberName = prompt("Nhập tên thành viên: ");
                    let membershipType = prompt("Nhập loại thẻ thành viên (VIP, Thường): ");
                    this._libraryManager.addMember(membermemberName, membershipType);
                    console.log("Thêm thành viên thành công.");
                    break;
                case "2":
                    let librarianName = prompt("Nhập tên thủ thư: ");
                    let position = prompt("Nhập vị trí công việc: ");
                    this._libraryManager.addLibrarian(librarianName, position);
                    console.log("Thêm thủ thư thành công.");
                    break;
                case "3":
                    let title = prompt("Nhập tên CD: ");
                    let artist = prompt("Nhập nghệ sĩ/ban nhạc: ");
                    this._libraryManager.addCD(title, artist, false);
                    console.log("Thêm CD thành công.");
                    break;
                case "4":
                    let memberId = parseInt(prompt("Nhập ID thành viên: "));
                    let cdId_m = parseInt(prompt("Nhập ID CD: "));
                    this._libraryManager.borrowCD(memberId, cdId_m);
                    console.log("Mượn CD thành công.");
                    break;
                case "5":
                    let cdId_t = parseInt(prompt("Nhập ID CD: "));
                    this._libraryManager.returnCD(cdId_t);
                    console.log("Trả CD thành công.");
                    break;
                case "6":
                    console.log("Danh sách bản ghi mượn CD:");
                    this._libraryManager.listBorrowRecords();
                    break;
                case "7":
                    loop = false;
                    console.log("Chương trình kết thúc.");
                    break;
                default:
                    console.log("Lựa chọn không hợp lệ.");
                    break;
            }
        }
    }
}
let app = new Main();
app.bootstrap();
