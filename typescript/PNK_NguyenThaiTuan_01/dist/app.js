"use strict";
// Lớp Person (Khách hàng)
class Person {
    constructor(id, name, email, phone) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
    }
    getDetails() {
        return `Khách hàng [ID: ${this.id}, Name: ${this.name}, Email: ${this.email}, Phone: ${this.phone}]`;
    }
}
// Lớp Room (Phòng - Abstract Class)
class Room {
    constructor(roomId, type, pricePerNight) {
        this.roomId = roomId;
        this.type = type;
        this.pricePerNight = pricePerNight;
        this.isAvailable = true;
    }
    bookRoom() {
        this.isAvailable = false;
    }
    releaseRoom() {
        this.isAvailable = true;
    }
}
// Lớp StandardRoom (Phòng tiêu chuẩn)
class StandardRoom extends Room {
    constructor(roomId, pricePerNight) {
        super(roomId, "Standard", pricePerNight);
    }
    calculateCost(nights) {
        return this.pricePerNight * nights;
    }
    getAdditionalServices() {
        return [];
    }
    applyDiscount(discountRate) {
        return this.pricePerNight * (1 - discountRate);
    }
    getCancellationPolicy() {
        return "Hoàn tiền 100% nếu hủy phòng trước 1 ngày check-in.";
    }
}
// Lớp DeluxeRoom (Phòng cao cấp)
class DeluxeRoom extends Room {
    constructor(roomId, pricePerNight) {
        super(roomId, "Deluxe", pricePerNight);
    }
    calculateCost(nights) {
        return this.pricePerNight * nights;
    }
    getAdditionalServices() {
        return ["Breakfast"];
    }
    applyDiscount(discountRate) {
        return this.pricePerNight * (1 - discountRate);
    }
    getCancellationPolicy() {
        return "Hoàn tiền 50% nếu hủy phòng trước 2 ngày check-in.";
    }
}
// Lớp SuiteRoom (Phòng hạng sang)
class SuiteRoom extends Room {
    constructor(roomId, pricePerNight) {
        super(roomId, "Suite", pricePerNight);
    }
    calculateCost(nights) {
        return this.pricePerNight * nights;
    }
    getAdditionalServices() {
        return ["Spa", "Minibar"];
    }
    applyDiscount(discountRate) {
        return this.pricePerNight * (1 - discountRate);
    }
    getCancellationPolicy() {
        return "Không hoàn tiền nếu hủy phòng.";
    }
}
// Lớp Booking (Đặt phòng)
class Booking {
    constructor(bookingId, customer, room, nights) {
        this.bookingId = bookingId;
        this.customer = customer;
        this.room = room;
        this.nights = nights;
        this.totalCost = room.calculateCost(nights);
    }
    getDetails() {
        return `Booking [ID: ${this.bookingId}, Khách hàng: ${this.customer.name}, Phòng: ${this.room.type}, Số đêm: ${this.nights}, Tổng chi phí: ${this.totalCost}]`;
    }
}
// Lớp HotelManager (Quản lý khách sạn)
class HotelManager {
    constructor() {
        this.rooms = [];
        this.bookings = [];
        this.customers = [];
    }
    addRoom(type, pricePerNight) {
        const roomId = this.rooms.length + 1;
        let room;
        if (type === "Standard") {
            room = new StandardRoom(roomId, pricePerNight);
        }
        else if (type === "Deluxe") {
            room = new DeluxeRoom(roomId, pricePerNight);
        }
        else if (type === "Suite") {
            room = new SuiteRoom(roomId, pricePerNight);
        }
        else {
            console.log("Loại phòng không hợp lệ.");
            return;
        }
        this.rooms.push(room);
        console.log(`Phòng [ID: ${roomId}] đã được thêm vào.`);
    }
    addCustomer(name, email, phone) {
        const customerId = this.customers.length + 1;
        const customer = new Person(customerId, name, email, phone);
        this.customers.push(customer);
        console.log(`Khách hàng [ID: ${customerId}] đã được thêm vào.`);
    }
    bookRoom(customerId, roomId, nights) {
        const customer = this.customers.find(c => c.id === customerId);
        const room = this.rooms.find(r => r.roomId === roomId);
        if (!customer || !room) {
            console.log("Lỗi: Không tìm thấy khách hàng hoặc phòng.");
            return;
        }
        if (!room.isAvailable) {
            console.log("Phòng đã được đặt.");
            return;
        }
        room.bookRoom();
        const bookingId = this.bookings.length + 1;
        const booking = new Booking(bookingId, customer, room, nights);
        this.bookings.push(booking);
        console.log(`Đặt phòng [ID: ${bookingId}] đã được xác nhận.`);
        return booking;
    }
    releaseRoom(roomId) {
        const room = this.rooms.find(r => r.roomId === roomId);
        if (room) {
            room.releaseRoom();
            console.log(`phòng [ID: ${roomId}] đã được trả.`);
        }
        else {
            console.log("Không tìm thấy phòng.");
        }
    }
    listAvailableRooms() {
        const availableRooms = this.rooms.filter(r => r.isAvailable);
        console.log("Phòng có sẵn:");
        availableRooms.forEach(room => {
            console.log(`Phòng [ID: ${room.roomId}, Loại: ${room.type}, Giá mỗi đêm: ${room.pricePerNight}]`);
        });
    }
    listBookingsByCustomer(customerId) {
        const customerBookings = this.bookings.filter(b => b.customer.id === customerId);
        console.log(`Đặt phòng cho Khách hàng [ID: ${customerId}]:`);
        customerBookings.forEach(booking => {
            console.log(booking.getDetails());
        });
    }
    calculateTotalRevenue() {
        const totalRevenue = this.bookings.reduce((sum, booking) => sum + booking.totalCost, 0);
        console.log(`Tổng doanh thu: ${totalRevenue}`);
        return totalRevenue;
    }
    getRoomTypesCount() {
        const roomTypesCount = this.rooms.reduce((count, room) => {
            count[room.type] = (count[room.type] || 0) + 1;
            return count;
        }, {});
        console.log("Số lượng các loại phòng:", roomTypesCount);
    }
    applyDiscountToRoom(roomId, discountRate) {
        const roomIndex = this.rooms.findIndex(r => r.roomId === roomId);
        if (roomIndex !== -1) {
            const room = this.rooms[roomIndex];
            const newPrice = room.applyDiscount(discountRate);
            console.log(`Giảm giá đã được áp dụng. Giá mới của phòng [ID: ${roomId}] is ${newPrice}`);
        }
        else {
            console.log("Không tìm thấy phòng.");
        }
    }
    getRoomServices(roomId) {
        const room = this.rooms.find(r => r.roomId === roomId);
        if (room) {
            console.log(`Dịch vụ bổ sung cho phòng [ID: ${roomId}]:`, room.getAdditionalServices());
        }
        else {
            console.log("Không tìm thấy phòng.");
        }
    }
    getCancellationPolicy(roomId) {
        const room = this.rooms.find(r => r.roomId === roomId);
        if (room) {
            console.log(`Chính sách hủy phòng [ID: ${roomId}]:`, room.getCancellationPolicy());
        }
        else {
            console.log("Không tìm thấy phòng.");
        }
    }
}
// Chương trình chính
class Main {
    constructor() {
        this.hotelManager = new HotelManager();
    }
    run() {
        while (true) {
            console.log(`
Menu:
1. Thêm khách hàng
2. Thêm phòng
3. Đặt phòng
4. Hủy phòng
5. Danh sách phòng còn trống
6. Danh sách các đặt phòng của khách hàng
7. Tính tổng doanh thu
8. Xem số lượng phòng theo loại
9. Áp dụng giảm giá cho phòng
10. Xem dịch vụ phòng
11. Xem chính sách hủy phòng
12. Thoát
            `);
            const choice = Number(prompt("Nhập lựa chọn của bạn: "));
            try {
                switch (choice) {
                    case 1:
                        const customerName = prompt("Nhập tên khách hàng: ");
                        const customerEmail = prompt("Nhập email khách hàng: ");
                        const customerPhone = prompt("Nhập số điện thoại khách hàng: ");
                        if (customerName && customerEmail && customerPhone) {
                            this.hotelManager.addCustomer(customerName, customerEmail, customerPhone);
                        }
                        else {
                            console.log("Lỗi: Tất cả thông tin khách hàng đều phải được cung cấp.");
                        }
                        break;
                    case 2:
                        const roomType = prompt("Nhập loại phòng (Standard/Deluxe/Suite): ");
                        const roomPriceStr = prompt("Nhập giá phòng mỗi đêm: ");
                        const roomPrice = roomPriceStr ? Number(roomPriceStr) : NaN;
                        if (roomType && !isNaN(roomPrice)) {
                            this.hotelManager.addRoom(roomType, roomPrice);
                        }
                        else {
                            console.log("Lỗi: Cần nhập loại phòng và giá hợp lệ.");
                        }
                        break;
                    case 3:
                        const customerId = Number(prompt("Nhập ID khách hàng: "));
                        const roomId = Number(prompt("Nhập ID phòng: "));
                        const nights = Number(prompt("Nhập số đêm: "));
                        this.hotelManager.bookRoom(customerId, roomId, nights);
                        break;
                    case 4:
                        const releaseRoomId = Number(prompt("Nhập ID phòng cần hủy: "));
                        this.hotelManager.releaseRoom(releaseRoomId);
                        break;
                    case 5:
                        this.hotelManager.listAvailableRooms();
                        break;
                    case 6:
                        const bookingCustomerId = Number(prompt("Nhập ID khách hàng để xem các đặt phòng: "));
                        this.hotelManager.listBookingsByCustomer(bookingCustomerId);
                        break;
                    case 7:
                        this.hotelManager.calculateTotalRevenue();
                        break;
                    case 8:
                        this.hotelManager.getRoomTypesCount();
                        break;
                    case 9:
                        const discountRoomId = Number(prompt("Nhập ID phòng để áp dụng giảm giá: "));
                        const discountRate = Number(prompt("Nhập tỷ lệ giảm giá (0-1): "));
                        this.hotelManager.applyDiscountToRoom(discountRoomId, discountRate);
                        break;
                    case 10:
                        const servicesRoomId = Number(prompt("Nhập ID phòng để xem dịch vụ: "));
                        this.hotelManager.getRoomServices(servicesRoomId);
                        break;
                    case 11:
                        const cancellationRoomId = Number(prompt("Nhập ID phòng để xem chính sách hủy: "));
                        this.hotelManager.getCancellationPolicy(cancellationRoomId);
                        break;
                    case 12:
                        console.log("Thoát chương trình...");
                        return;
                    default:
                        console.log("Lựa chọn không hợp lệ, vui lòng thử lại.");
                }
            }
            catch (error) {
                console.log(error.message);
            }
        }
    }
}
const main = new Main();
main.run();
