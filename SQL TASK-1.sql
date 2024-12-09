-- Creating a database for Library Management System
CREATE DATABASE LibraryManagement;
USE LibraryManagement;

-- Table for Books
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Genre VARCHAR(100),
    PublishedYear INT,
    Quantity INT NOT NULL
);

-- Table for Members
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15),
    MembershipDate DATE NOT NULL
);

-- Table for Transactions
CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Inserting data into Books table
INSERT INTO Books (Title, Author, Genre, PublishedYear, Quantity) 
VALUES 
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 5),
('1984', 'George Orwell', 'Dystopian', 1949, 10),
('Moby Dick', 'Herman Melville', 'Adventure', 1851, 3);

-- Inserting data into Members table
INSERT INTO Members (Name, Email, PhoneNumber, MembershipDate) 
VALUES 
('Alice Smith', 'alice@example.com', '1234567890', '2023-01-15'),
('Bob Johnson', 'bob@example.com', '9876543210', '2023-02-20');

-- Inserting data into Transactions table
INSERT INTO Transactions (BookID, MemberID, BorrowDate, ReturnDate) 
VALUES 
(1, 1, '2023-03-01', NULL),
(2, 2, '2023-03-05', '2023-03-15');

-- Query to retrieve all books
SELECT * FROM Books;

-- Query to update book quantity
UPDATE Books 
SET Quantity = Quantity - 1 
WHERE BookID = 1;

-- Query to delete a member
DELETE FROM Members 
WHERE MemberID = 2;

-- Query to retrieve all transactions
SELECT 
    Transactions.TransactionID, 
    Books.Title AS BookTitle, 
    Members.Name AS MemberName, 
    Transactions.BorrowDate, 
    Transactions.ReturnDate
FROM Transactions
JOIN Books ON Transactions.BookID = Books.BookID
JOIN Members ON Transactions.MemberID = Members.MemberID;
