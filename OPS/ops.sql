CREATE DATABASE online_nursery;

USE online_nursery;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    uname VARCHAR(50) NOT NULL,
    pass VARCHAR(50) NOT NULL,
    role ENUM('user', 'admin') NOT NULL
);

CREATE TABLE plants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    img_url VARCHAR(255),
    price DECIMAL(10,2)
);
