
USE ars_db;

-- SELECT flight_no, source, destination, date, price FROM flight;

-- Inserting data into customers table
INSERT INTO customers (first_name, last_name, dob, nationality, phone_number, email, password, address) VALUES
('Om', 'Sai', '1992-06-15', 'Indian', '9876543210', 'omsai@gmail.com', 'om90', 'Flat 102, Shivaji Nagar, Pune'),
('Sneha', 'Jadhav', '1995-09-22', 'Indian', '9823456789', 'sneha.jadhav@yahoo.com', 'pass@456', 'Sahyadri Apartments, Andheri, Mumbai'),
('Sandeep', 'Joshi', '1988-03-10', 'Indian', '9812345678', 'sandeep.joshi@rediffmail.com', 'mypassword', 'Plot No. 12, Civil Lines, Nagpur'),
('Pooja', 'Patil', '1997-07-19', 'Indian', '9876549876', 'pooja.patil@hotmail.com', 'pooja@789', 'House No. 45, Osmanpura, Aurangabad');

-- Inserting data into Flight table
INSERT INTO Flight (flight_name, airline, source, destination, departure_time, arrival_time, seats_available, price) VALUES
('AI 101', 'Air India', 'Mumbai', 'Pune', '2025-03-10 08:00:00', '2025-03-10 09:00:00', 150, 2500.00),
('6E 302', 'IndiGo', 'Pune', 'Nagpur', '2025-03-11 10:00:00', '2025-03-11 11:30:00', 180, 3200.00),
('G8 509', 'Go First', 'Nagpur', 'Aurangabad', '2025-03-12 07:30:00', '2025-03-12 08:45:00', 120, 2800.00),
('SG 415', 'SpiceJet', 'Mumbai', 'Nagpur', '2025-03-13 18:00:00', '2025-03-13 19:45:00', 160, 4000.00);

-- Inserting data into Booking table
INSERT INTO Booking (customer_id, flight_id, seat_number, status) VALUES
(1, 1, '12A', 'Booked'),
(2, 2, '15C', 'Cancelled'),
(3, 3, '8B', 'Booked'),
(4, 4, '20D', 'Booked');

-- Inserting data into Payment table
INSERT INTO Payment (booking_id, amount, payment_method, payment_status) VALUES
(1, 2500.00, 'UPI', 'Completed'),
(2, 3200.00, 'Credit Card', 'Completed'),
(3, 2800.00, 'Debit Card', 'Pending'),
(4, 4000.00, 'Net Banking', 'Completed');

-- Inserting data into Grievance table
INSERT INTO Grievance (customer_id, booking_id, complaint, status) VALUES
(1, 1, 'Flight delayed by 2 hours.', 'Resolved'),
(2, 2, 'Seat assignment issue.', 'Pending'),
(3, 3, 'Refund not processed yet.', 'Pending');

-- Inserting data into Cancellation table
INSERT INTO Cancellation (booking_id, refund_amount, cancellation_reason) VALUES
(2, 3200.00, 'Customer changed travel plans');

-- Inserting data into Admin table
INSERT INTO Admin (name, email, password) VALUES
('Rahul Deshmukh', 'rahul.deshmukh@airmumbai.com', 'admin@123'),
('Pooja Patil', 'pooja.patil@airmumbai.com', 'secure@321');

-- Inserting data into Manager table
INSERT INTO Manager (name, email, password) VALUES
('Sandeep Joshi', 'sandeep.joshi@indigo.com', 'manager@pass'),
('Neha Kulkarni', 'neha.kulkarni@airindia.com', 'pass@manager');

-- Inserting data into Staff table
INSERT INTO Staff (name, email, password) VALUES
('Amit Pawar', 'amit.pawar@goair.com', 'staff@123'),
('Sneha Jadhav', 'sneha.jadhav@spicejet.com', 'spice@456');


