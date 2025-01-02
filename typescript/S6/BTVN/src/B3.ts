// Lớp Person (Khách hàng)
class Person {
    constructor(
        public id: number,
        public name: string,
        public email: string,
        public phone: string
    ) {}

    getDetails(): string {
        return `Customer [ID: ${this.id}, Name: ${this.name}, Email: ${this.email}, Phone: ${this.phone}]`;
    }
}

// Lớp Room (Phòng - Abstract Class)
abstract class Room {
    constructor(
        public roomId: number,
        public type: string,
        public pricePerNight: number,
        public isAvailable: boolean
    ) {}

    abstract calculateCost(nights: number): number;

    bookRoom(): void {
        if (!this.isAvailable) {
            console.log("Room is already booked.");
            return;
        }
        this.isAvailable = false;
        console.log(`Room [ID: ${this.roomId}] has been booked.`);
    }

    releaseRoom(): void {
        if (this.isAvailable) {
            console.log("Room is already available.");
            return;
        }
        this.isAvailable = true;
        console.log(`Room [ID: ${this.roomId}] has been released.`);
    }
}

// Lớp StandardRoom (Phòng tiêu chuẩn)
class StandardRoom extends Room {
    constructor(roomId: number, pricePerNight: number) {
        super(roomId, 'Standard', pricePerNight, true);
    }

    calculateCost(nights: number): number {
        return this.pricePerNight * nights;
    }
}

// Lớp DeluxeRoom (Phòng cao cấp)
class DeluxeRoom extends Room {
    constructor(roomId: number, pricePerNight: number) {
        super(roomId, 'Deluxe', pricePerNight, true);
    }

    calculateCost(nights: number): number {
        return this.pricePerNight * nights * 1.1; // 10% surcharge for Deluxe
    }
}

// Lớp SuiteRoom (Phòng hạng sang)
class SuiteRoom extends Room {
    constructor(roomId: number, pricePerNight: number) {
        super(roomId, 'Suite', pricePerNight, true);
    }

    calculateCost(nights: number): number {
        return this.pricePerNight * nights * 1.2; // 20% surcharge for Suite
    }
}

// Lớp Booking (Đặt phòng)
class Booking {
    constructor(
        public bookingId: number,
        public customer: Person,
        public room: Room,
        public nights: number,
        public totalCost: number
    ) {}

    getDetails(): string {
        return `Booking [ID: ${this.bookingId}, Customer: ${this.customer.getDetails()}, Room: ${this.room.type}, Nights: ${this.nights}, Total Cost: ${this.totalCost}]`;
    }
}

// Lớp HotelManager (Quản lý khách sạn)
class HotelManager {
    customers: Person[] = [];
    rooms: Room[] = [];
    bookings: Booking[] = [];

    addRoom(type: string, pricePerNight: number): void {
        const roomId = this.rooms.length + 1;
        let room: Room;

        if (type === 'Standard') {
            room = new StandardRoom(roomId, pricePerNight);
        } else if (type === 'Deluxe') {
            room = new DeluxeRoom(roomId, pricePerNight);
        } else if (type === 'Suite') {
            room = new SuiteRoom(roomId, pricePerNight);
        } else {
            console.log("Invalid room type.");
            return;
        }

        this.rooms.push(room);
        console.log(`${type} Room [ID: ${roomId}] added.`);
    }

    addCustomer(name: string, email: string, phone: string): void {
        const id = this.customers.length + 1;
        const customer = new Person(id, name, email, phone);
        this.customers.push(customer);
        console.log(`Customer [ID: ${id}] added.`);
    }

    bookRoom(customerId: number, roomId: number, nights: number): void {
        const customer = this.customers.find(c => c.id === customerId);
        const room = this.rooms.find(r => r.roomId === roomId);

        if (!customer || !room) {
            console.log("Error: Customer or Room not found.");
            return;
        }

        if (!room.isAvailable) {
            console.log("Error: Room is not available.");
            return;
        }

        room.bookRoom();
        const totalCost = room.calculateCost(nights);
        const bookingId = this.bookings.length + 1;
        const booking = new Booking(bookingId, customer, room, nights, totalCost);
        this.bookings.push(booking);

        console.log(`Room [ID: ${roomId}] has been booked for ${customer.getDetails()}. Total cost: ${totalCost}`);
    }

    releaseRoom(roomId: number): void {
        const room = this.rooms.find(r => r.roomId === roomId);
        if (!room) {
            console.log("Error: Room not found.");
            return;
        }
        room.releaseRoom();
    }

    listAvailableRooms(): void {
        console.log("Available Rooms:");
        this.rooms.forEach(room => {
            if (room.isAvailable) {
                console.log(`Room [ID: ${room.roomId}, Type: ${room.type}, Price: ${room.pricePerNight}]`);
            }
        });
    }
}

// Chương trình chính
class Main {
    private hotelManager: HotelManager;

    constructor() {
        this.hotelManager = new HotelManager();
    }

    run(): void {
        while (true) {
            console.log(`
Menu:
1. Add Room
2. Add Customer
3. Book Room
4. Release Room
5. List Available Rooms
6. Exit
            `);

            const choice = Number(prompt("Enter your choice: "));
            try {
                switch (choice) {
                    case 1:
                        const roomType = prompt("Enter room type (Standard/Deluxe/Suite): ");
                        const roomPrice = Number(prompt("Enter room price per night: "));
                        this.hotelManager.addRoom(roomType, roomPrice);
                        break;

                    case 2:
                        const customerName = prompt("Enter customer name: ");
                        const customerEmail = prompt("Enter customer email: ");
                        const customerPhone = prompt("Enter customer phone: ");
                        this.hotelManager.addCustomer(customerName, customerEmail, customerPhone);
                        break;

                    case 3:
                        const customerId = Number(prompt("Enter customer ID: "));
                        const roomId = Number(prompt("Enter room ID: "));
                        const nights = Number(prompt("Enter number of nights: "));
                        this.hotelManager.bookRoom(customerId, roomId, nights);
                        break;

                    case 4:
                        const roomIdToRelease = Number(prompt("Enter room ID to release: "));
                        this.hotelManager.releaseRoom(roomIdToRelease);
                        break;

                    case 5:
                        this.hotelManager.listAvailableRooms();
                        break;

                    case 6:
                        console.log("Exiting...");
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
const app = new Main();
app.run();
