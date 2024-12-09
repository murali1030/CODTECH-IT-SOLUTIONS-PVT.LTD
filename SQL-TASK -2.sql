 
-- Table: Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(255) NOT NULL,
    Category VARCHAR(100),
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL
);

-- Table: Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address TEXT
);

-- Table: Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    OrderStatus VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Table: OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Table: Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentStatus VARCHAR(50) DEFAULT 'Completed',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 2: Example Queries

-- Add a new product
INSERT INTO Products (ProductName, Category, Price, Stock)
VALUES ('Wireless Mouse', 'Electronics', 25.99, 100);

-- Add a new customer
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main Street, Anytown');

-- Place an order
INSERT INTO Orders (CustomerID, TotalAmount)
VALUES (1, 129.97);

-- Add order details
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Subtotal)
VALUES (1, 1, 5, 129.97);

-- Process a payment
INSERT INTO Payments (OrderID, Amount, PaymentMethod)
VALUES (1, 129.97, 'Credit Card');

-- Update product stock after an order
UPDATE Products
SET Stock = Stock - 5
WHERE ProductID = 1;

-- Retrieve customer order history
SELECT o.OrderID, o.OrderDate, o.TotalAmount, od.ProductID, od.Quantity, od.Subtotal
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE o.CustomerID = 1;

-- Check payment status
SELECT p.PaymentID, p.PaymentDate, p.Amount, p.PaymentMethod, p.PaymentStatus
FROM Payments p
WHERE p.OrderID = 1;