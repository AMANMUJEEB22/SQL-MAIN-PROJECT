CREATE DATABASE library;
USE library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);


CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES 
(1, 101, '123 Library Road, City A', '9876543210'),
(2, 102, '456 Book Lane, City B', '8765432109'),
(3, 103, '789 Knowledge St, City C', '7654321098');

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES 
(101, 'Alice Johnson', 'Manager', 75000, 1),
(102, 'Bob Smith', 'Manager', 70000, 2),
(103, 'Charlie Brown', 'Manager', 72000, 3),
(201, 'David Wilson', 'Assistant', 50000, 1),
(202, 'Eva Green', 'Librarian', 52000, 1),
(203, 'Frank Harris', 'Librarian', 48000, 2);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES 
(1001, 'The Great Gatsby', 'Fiction', 20, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
(1002, 'To Kill a Mockingbird', 'Fiction', 25, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'),
(1003, '1984', 'Dystopian', 30, 'no', 'George Orwell', 'Secker & Warburg'),
(1004, 'A Brief History of Time', 'Science', 35, 'yes', 'Stephen Hawking', 'Bantam Books'),
(1005, 'The Art of War', 'History', 18, 'yes', 'Sun Tzu', 'Shambhala');

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES 
(301, 'John Doe', '12 Main Street, City A', '2021-11-15'),
(302, 'Jane Doe', '34 Elm Street, City B', '2023-02-10'),
(303, 'Michael Scott', '56 Oak Avenue, City C', '2019-06-20'),
(304, 'Pam Beesly', '78 Pine Road, City A', '2021-05-25');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES 
(401, 301, 'The Great Gatsby', '2023-06-10', 1001),
(402, 302, '1984', '2023-06-15', 1003);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES 
(501, 301, 'The Great Gatsby', '2023-07-01', 1001),
(502, 302, '1984', '2023-07-10', 1003);

SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'yes';

SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;

SELECT Books.Book_title, Customer.Customer_name 
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;

SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;

SELECT Customer_name 
FROM Customer 
WHERE Reg_date < '2022-01-01' 
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no;

SELECT DISTINCT Customer.Customer_name 
FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE MONTH(Issue_date) = 6 AND YEAR(Issue_date) = 2023;

SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%history%';

SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no 
HAVING COUNT(*) > 5;

SELECT Employee.Emp_name, Branch.Branch_address 
FROM Branch
JOIN Employee ON Branch.Manager_Id = Employee.Emp_Id;

SELECT DISTINCT Customer.Customer_name 
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Books.Rental_Price > 25;
