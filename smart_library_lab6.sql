-- Smart Library | 6-zertkhanalyk zhumys
-- Run once in MySQL Workbench against the EMPTY smart_library database.
-- No DROP DATABASE statement is included.
CREATE DATABASE IF NOT EXISTS smart_library CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smart_library;

-- 1. Users
CREATE TABLE Users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  fullname VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  role VARCHAR(30) NOT NULL,
  CONSTRAINT chk_user_role CHECK (role IN ('reader', 'admin', 'librarian', 'booking_staff'))
);

-- 2. Readers
CREATE TABLE Readers (
  reader_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
  phone VARCHAR(20),
  CONSTRAINT fk_reader_user FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 3. Employees
CREATE TABLE Employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
  position VARCHAR(100) NOT NULL,
  CONSTRAINT fk_employee_user FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 4. Books
CREATE TABLE Books (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(150) NOT NULL,
  author VARCHAR(100) NOT NULL,
  genre VARCHAR(50),
  publication_year INT,
  total_copies INT NOT NULL DEFAULT 1,
  available_copies INT NOT NULL DEFAULT 1,
  hall VARCHAR(30),
  shelf VARCHAR(30),
  CONSTRAINT chk_copies CHECK (total_copies >= 0 AND available_copies >= 0 AND available_copies <= total_copies)
);

-- 5. LibraryCards
CREATE TABLE LibraryCards (
  card_id INT AUTO_INCREMENT PRIMARY KEY,
  reader_id INT NOT NULL UNIQUE,
  issue_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  CONSTRAINT chk_card_status CHECK (status IN ('active', 'blocked')),
  CONSTRAINT fk_card_reader FOREIGN KEY (reader_id) REFERENCES Readers(reader_id)
);

-- 6. Reservations
CREATE TABLE Reservations (
  reservation_id INT AUTO_INCREMENT PRIMARY KEY,
  reader_id INT NOT NULL,
  book_id INT NOT NULL,
  employee_id INT,
  reservation_date DATE NOT NULL,
  status VARCHAR(30) NOT NULL,
  CONSTRAINT chk_res_status CHECK (status IN ('pending', 'confirmed', 'ready', 'cancelled')),
  CONSTRAINT fk_res_reader FOREIGN KEY (reader_id) REFERENCES Readers(reader_id),
  CONSTRAINT fk_res_book FOREIGN KEY (book_id) REFERENCES Books(book_id),
  CONSTRAINT fk_res_employee FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- 7. Loans
CREATE TABLE Loans (
  loan_id INT AUTO_INCREMENT PRIMARY KEY,
  reader_id INT NOT NULL,
  book_id INT NOT NULL,
  loan_date DATE NOT NULL,
  due_date DATE NOT NULL,
  return_date DATE,
  status VARCHAR(30) NOT NULL,
  CONSTRAINT chk_loan_status CHECK (status IN ('borrowed', 'returned', 'overdue')),
  CONSTRAINT chk_loan_dates CHECK (due_date >= loan_date AND (return_date IS NULL OR return_date >= loan_date)),
  CONSTRAINT fk_loan_reader FOREIGN KEY (reader_id) REFERENCES Readers(reader_id),
  CONSTRAINT fk_loan_book FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- INSERT: demonstration data, all fictional
INSERT INTO Users (fullname, email, role) VALUES
('Айдана Серік', 'aidana@example.com', 'reader'),
('Нұржан Әли', 'nurzhan@example.com', 'reader'),
('Аружан Ермек', 'aruzhan@example.com', 'reader'),
('Данияр Болат', 'daniyar@example.com', 'reader'),
('Мадина Асқар', 'madina@example.com', 'reader'),
('Аида Байбосын', 'aida.admin@example.com', 'admin'),
('Іңкәр Әділхан', 'inkar.library@example.com', 'librarian'),
('Ерке Өмірзақ', 'erke.booking@example.com', 'booking_staff');

INSERT INTO Readers (user_id, phone) VALUES
(1, '+77000000001'),
(2, '+77000000002'),
(3, '+77000000003'),
(4, '+77000000004'),
(5, '+77000000005');

INSERT INTO Employees (user_id, position) VALUES
(6, 'Әкімші'),
(7, 'Кітапханашы'),
(8, 'Броньдау қызметкері');

INSERT INTO Books
(title, author, genre, publication_year, total_copies, available_copies, hall, shelf)
VALUES
('Абай жолы', 'Мұхтар Әуезов', 'Роман', 1942, 5, 4, 'A1', 'S01'),
('Менің атым Қожа', 'Бердібек Соқпақбаев', 'Повесть', 1957, 4, 4, 'A1', 'S02'),
('Көшпенділер', 'Ілияс Есенберлин', 'Тарихи роман', 1969, 6, 6, 'A2', 'S03'),
('Қан мен тер', 'Әбдіжәміл Нұрпейісов', 'Роман', 1961, 3, 3, 'A2', 'S04'),
('Қара сөздер', 'Абай Құнанбайұлы', 'Философия', 1890, 5, 4, 'A3', 'S05'),
('Python негіздері', 'Оқу ұжымы', 'IT', 2022, 8, 7, 'B1', 'S06'),
('Деректер қоры', 'Оқу ұжымы', 'IT', 2023, 7, 7, 'B1', 'S07'),
('Алгоритмдер', 'Оқу ұжымы', 'IT', 2021, 6, 5, 'B2', 'S08'),
('Жасанды интеллект', 'Оқу ұжымы', 'IT', 2024, 5, 5, 'B2', 'S09'),
('Веб бағдарламалау', 'Оқу ұжымы', 'IT', 2023, 6, 6, 'B3', 'S10');

INSERT INTO LibraryCards (reader_id, issue_date, status) VALUES
(1, '2026-09-01', 'active'),
(2, '2026-09-02', 'active'),
(3, '2026-09-03', 'active'),
(4, '2026-09-04', 'active'),
(5, '2026-09-05', 'blocked');

INSERT INTO Reservations (reader_id, book_id, employee_id, reservation_date, status) VALUES
(1, 2, 3, '2026-10-01', 'ready'),
(2, 4, 3, '2026-10-02', 'pending'),
(3, 7, 3, '2026-10-03', 'confirmed'),
(4, 9, 3, '2026-10-04', 'pending'),
(1, 10, 3, '2026-10-05', 'ready');

INSERT INTO Loans (reader_id, book_id, loan_date, due_date, return_date, status) VALUES
(1, 1, '2026-09-15', '2026-09-29', NULL, 'overdue'),
(2, 3, '2026-09-20', '2026-10-04', '2026-10-01', 'returned'),
(3, 5, '2026-10-01', '2026-10-15', NULL, 'borrowed'),
(4, 6, '2026-10-02', '2026-10-16', NULL, 'borrowed'),
(5, 8, '2026-09-10', '2026-09-24', NULL, 'overdue');

-- UPDATE example: reservation confirmation
UPDATE Reservations
SET status = 'confirmed'
WHERE reservation_id = 2;

-- UPDATE example: block overdue reader's library card
UPDATE LibraryCards
SET status = 'blocked'
WHERE reader_id = 1;

-- DELETE example: insert a disposable test reservation then delete ONLY that row
INSERT INTO Reservations (reader_id, book_id, employee_id, reservation_date, status)
VALUES (2, 10, 3, '2026-10-06', 'pending');
SET @demo_reservation_id = LAST_INSERT_ID();
DELETE FROM Reservations WHERE reservation_id = @demo_reservation_id;

-- Verify tables, updated records, totals and employee responsible for reservations
SHOW TABLES;
SELECT * FROM Reservations ORDER BY reservation_id;
SELECT * FROM LibraryCards ORDER BY card_id;
SELECT e.employee_id, u.fullname, e.position FROM Employees e JOIN Users u ON e.user_id = u.user_id;
SELECT 'Users' AS table_name, COUNT(*) AS total FROM Users
UNION ALL SELECT 'Readers', COUNT(*) FROM Readers
UNION ALL SELECT 'Employees', COUNT(*) FROM Employees
UNION ALL SELECT 'Books', COUNT(*) FROM Books
UNION ALL SELECT 'LibraryCards', COUNT(*) FROM LibraryCards
UNION ALL SELECT 'Reservations', COUNT(*) FROM Reservations
UNION ALL SELECT 'Loans', COUNT(*) FROM Loans;
