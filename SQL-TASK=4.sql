CREATE DATABASE StudentRecords;
USE StudentRecords;
CREATE TABLE StudentRecords (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    DateOfBirth DATE,
    Email VARCHAR(100)
);


 CREATE TABLE Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100),
    Instructor VARCHAR(100)
);


CREATE TABLE Enrollments (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
 
 
 -- Insert Data into Students Table:
INSERT INTO Students (FirstName, LastName, DateOfBirth, Email)
VALUES
('John', 'Doe', '1998-02-15', 'john.doe@example.com'),
('Jane', 'Smith', '2000-06-25', 'jane.smith@example.com');

INSERT INTO Courses (CourseName, Instructor)
VALUES
('Database Systems', 'Dr. Brown'),
('Software Engineering', 'Dr. Green');

INSERT INTO Enrollments (StudentID, CourseID, Grade)
VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'A');




-- Get all student names along with the courses they are enrolled in:
sql
SELECT s.FirstName, s.LastName, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;
 
 -- Get all students' grades for each course:
 SELECT s.FirstName, s.LastName, c.CourseName, e.Grade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

-- Get the list of students with their average grade (assuming grades are letter grades and you want to map them to points for averaging):
-- Define grade points
-- A = 4, B = 3, C = 2, D = 1, F = 0
SELECT s.FirstName, s.LastName, 
    AVG(CASE e.Grade 
        WHEN 'A' THEN 4
        WHEN 'B' THEN 3
        WHEN 'C' THEN 2
        WHEN 'D' THEN 1
        ELSE 0 END) AS AverageGrade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID;
















