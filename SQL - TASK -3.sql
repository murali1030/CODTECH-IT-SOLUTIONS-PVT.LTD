--  Create the Database
CREATE DATABASE OnlineRetailStore;
USE OnlineRetailStore;
 
 CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2),
    StockQuantity INT
);
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    ShippingAddress VARCHAR(255),
    PhoneNumber VARCHAR(15)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Status VARCHAR(50),
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE,
    PaymentMethod VARCHAR(50),
    PaymentStatus VARCHAR(50),
    Amount DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


--  Insert Data into Products Table:

INSERT INTO Products (ProductName, Description, Price, StockQuantity)
VALUES
('Laptop', '15-inch laptop with Intel i7 processor', 1200.00, 50),
('Headphones', 'Noise-cancelling over-ear headphones', 150.00, 200),
('Smartphone', '5G-enabled smartphone with 128GB storage', 800.00, 100);

 -- Insert Data into Customers Table:
 INSERT INTO Customers (FirstName, LastName, Email, ShippingAddress, PhoneNumber)
VALUES
('John', 'Doe', 'john.doe@example.com', '123 Main St, City, Country', '123-456-7890'),
('Jane', 'Smith', 'jane.smith@example.com', '456 Oak Ave, City, Country', '987-654-3210');


--  Insert Data into Orders Table:
INSERT INTO Orders (CustomerID, OrderDate, Status, TotalAmount)
VALUES
(1, '2024-12-10', 'Pending', 1450.00),
(2, '2024-12-11', 'Completed', 950.00);
-- Insert Data into OrderDetails Table:
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES
(1, 1, 1, 1200.00),
(1, 2, 1, 150.00),
(2, 3, 1, 800.00);

-- Insert Data into Payments Table:

INSERT INTO Payments (OrderID, PaymentDate, PaymentMethod, PaymentStatus, Amount)
VALUES
(1, '2024-12-10', 'Credit Card', 'Pending', 1450.00),
(2, '2024-12-11', 'PayPal', 'Completed', 950.00);
--  Get all orders placed by a customer (e.g., John Doe):
SELECT o.OrderID, o.OrderDate, o.Status, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Email = 'john.doe@example.com';
-- Get all products in a specific order (e.g., OrderID 1)
SELECT p.ProductName, od.Quantity, od.Price
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE od.OrderID = 1;
-- Get the total amount spent by a customer (e.g., Jane Smith)
SELECT SUM(o.TotalAmount) AS TotalSpent
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Email = 'jane.smith@example.com';

--  Get the payment status for an order:
SELECT p.PaymentMethod, p.PaymentStatus, p.Amount
FROM Payments p
JOIN Orders o ON p.OrderID = o.OrderID
WHERE o.OrderID = 1;

-- Get all completed orders along with the products and their quantities:
SELECT o.OrderID, o.OrderDate, p.ProductName, od.Quantity, od.Price
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.Status = 'Completed';

--  Update Payment Status (e.g., mark an order as paid):
 UPDATE Payments
SET PaymentStatus = 'Completed', PaymentDate = '2024-12-10'
WHERE OrderID = 1 AND PaymentStatus = 'Pending';

-- Update Product Stock After an Order:
UPDATE Products
SET StockQuantity = StockQuantity - 1
WHERE ProductID = 1;





























