--Task 3: Event Management System (PostgreSQL)

--1. Database Creation

--Events,Attendees,Registrations creation

CREATE TABLE Events (
    Event_id INT PRIMARY KEY,
    Event_name VARCHAR(100),
    Event_date DATE,
    Event_location VARCHAR(100),
    Event_description TEXT
);

CREATE TABLE Attendees (
    Attendee_id INT PRIMARY KEY,
    Attendee_name VARCHAR(100),
    Attendee_phone VARCHAR(15),
    Attendee_email VARCHAR(100),
    Attendee_city VARCHAR(50)
);

CREATE TABLE Registrations (
    Registration_id INT PRIMARY KEY,
    Event_id INT,
    Attendee_id INT,
    Registration_date DATE,
    Amount DECIMAL(10,2),
    FOREIGN KEY (Event_id) REFERENCES Events(Event_id),
    FOREIGN KEY (Attendee_id) REFERENCES Attendees(Attendee_id)
);

--2. Data Creation

--2. Sample data inserting

--Insert data into Events table
INSERT INTO Events (Event_id, Event_name, Event_date, Event_location, Event_description)
VALUES
(1, 'Justice League Summit', '2024-10-01', 'Hall of Justice', 'Annual meeting of the Justice League members.'),
(2, 'Wayne Enterprises Gala', '2024-11-10', 'Gotham City', 'Charity event hosted by Wayne Enterprises.'),
(3, 'Metropolis Science Fair', '2024-12-05', 'Metropolis Convention Center', 'Exhibition of the latest in scientific advancements.');

-- Insert data into Attendees table
INSERT INTO Attendees (Attendee_id, Attendee_name, Attendee_phone, Attendee_email, Attendee_city)
VALUES
(1, 'Bruce Wayne', '123-456-7890', 'bruce.wayne@waynecorp.com', 'Gotham'),
(2, 'Clark Kent', '987-654-3210', 'clark.kent@dailyplanet.com', 'Metropolis'),
(3, 'Diana Prince', '555-666-7777', 'diana.prince@themiscira.com', 'Themyscira'),
(4, 'Barry Allen', '333-444-5555', 'barry.allen@ccpd.com', 'Central City'),
(5, 'Arthur Curry', '222-333-4444', 'arthur.curry@atlantis.com', 'Atlantis');

-- Insert data into Registrations table
INSERT INTO Registrations (Registration_id, Event_id, Attendee_id, Registration_date, Amount)
VALUES
(1, 1, 1, '2024-09-15', 100.00),
(2, 1, 2, '2024-09-16', 120.00),
(3, 2, 3, '2024-10-01', 150.00),
(4, 3, 4, '2024-11-20', 200.00),
(5, 3, 5, '2024-11-25', 250.00);

--3. Manage event details

--a. Insert a new event
INSERT INTO Events (Event_id, Event_name, Event_date, Event_location, Event_description)
VALUES (4, 'Star City Charity Run', '2024-10-20', 'Star City', 'Annual marathon to raise funds for charity.');

-- b. Update an event's location
UPDATE Events
SET Event_location = 'Gotham City Plaza'
WHERE Event_id = 2;

-- c. Delete an event
DELETE FROM Events
WHERE Event_id = 4;

--4. Manage track Attendees and handle events 

-- a. Manage attendees
INSERT INTO Attendees (Attendee_id, Attendee_name, Attendee_phone, Attendee_email, Attendee_city)
VALUES (6, 'Kara Danvers', '444-333-2222', 'kara.danvers@deo.com', 'National City');

-- b. registering attendees 

INSERT INTO Registrations (Registration_id, Event_id, Attendee_id, Registration_date, Amount)
VALUES (6, 2, 6, '2024-08-27', 150.00);

--5. retreive event information,generate attendee lists, calculate event attendance statistics

--event information
SELECT * FROM Events;

-- specific event information
SELECT * FROM Events
WHERE Event_id = ?

--attendees information
SELECT * FROM Attendees;

--specific event attendees information

SELECT A.Attendee_name, A.Attendee_email, A.Attendee_phone
FROM Attendees A
JOIN Registrations R ON A.Attendee_id = R.Attendee_id
WHERE R.Event_id = ?;

--Overall event attendance statistics 

SELECT 
    E.Event_name,
    COUNT(R.Registration_id) AS Total_Attendees,
    SUM(R.Amount) AS Total_Amount,
    AVG(R.Amount) AS Average_Amount,
    MIN(R.Amount) AS Minimum_Amount,
    MAX(R.Amount) AS Maximum_Amount
FROM Events E
LEFT JOIN Registrations R ON E.Event_id = R.Event_id
GROUP BY E.Event_id, E.Event_name;







