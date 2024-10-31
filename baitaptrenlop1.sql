-- create database ECommerceDB;
use ECommerceDB;

create table Products(
	ID INT PRIMARY KEY AUTO_INCREMENT,
	productName VARCHAR(100) NOT NULL,
	description TEXT,
	price DECIMAL(10, 2) NOT NULL,
	stock INT NOT NULL
);

CREATE TABLE Cart (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT,
    total INT NOT NULL,
    FOREIGN KEY (userID) REFERENCES Users(id)
);


CREATE TABLE CartItems (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    cartID INT,
    productID INT,
    quantity INT NOT NULL,
    FOREIGN KEY (cartID) REFERENCES Cart(ID),
    FOREIGN KEY (productID) REFERENCES Products(id)
);
