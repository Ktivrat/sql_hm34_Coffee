Create database if not exists Kofebd;
use kofebd;

-- Создание таблицы "Shifts"
CREATE TABLE IF NOT EXISTS Shifts (
    shift_id INT PRIMARY KEY,
    date DATE
);

-- Создание таблицы "Coffees"
CREATE TABLE IF NOT EXISTS Coffees (
    coffee_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2)
);

-- Создание таблицы "Baristas"
CREATE TABLE IF NOT EXISTS Baristas (
    barista_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    shift_id INT,
    FOREIGN KEY (shift_id) REFERENCES Shifts(shift_id)
);

   
-- Вставка данных в таблицу "Shifts"
INSERT IGNORE INTO Shifts (shift_id, date)
VALUES
    (1, '2022-09-10'),
    (2, '2022-09-11'),
    (3, '2022-09-12'),
    (4, '2022-09-13'),
    (5, '2022-09-14'),
    (6, '2022-09-15'),
    (7, '2022-09-16'),
    (8, '2022-09-17'),
    (9, '2022-09-18'),
    (10, '2022-09-19');

-- Вставка данных в таблицу "Coffees"
INSERT IGNORE INTO Coffees (coffee_id, name, description, price)
VALUES
    (1, 'Эспрессо', 'Крепкий и ароматный', 2.50),
    (2, 'Капучино 200 мл', 'Нежное и вкусное', 3.00),
    (3, 'Латте', 'Мягкий и горячий', 3.50),
    (4, 'Американо', 'Классический черный кофе', 2.00),
    (5, 'Мокко', 'С шоколадом и взбитыми сливками', 4.00),
    (6, 'Раф кофе', 'С сиропом и молоком', 3.75),
    (7, 'Карамельный латте', 'С карамельным сиропом', 4.00),
    (8, 'Флэт Уайт', 'Двойной эспрессо с молоком', 3.25),
    (9, 'Макиато', 'Эспрессо с каплей молока', 2.75),
    (10, 'Кофе по-венски', 'Сливки и взбитые сливки', 4.50);

-- Вставка данных в таблицу "Baristas"
INSERT IGNORE INTO Baristas (barista_id, name, shift_id)
VALUES
    (1, 'Анна', 1),
    (2, 'Иван', 2),
    (3, 'Мария', 3),
    (4, 'Алексей', 4),
    (5, 'Екатерина', 2),
    (6, 'Дмитрий', 6),
    (7, 'Ольга', 7),
    (8, 'Петр', 2),
    (9, 'Наталья', 9),
    (10, 'Сергей', 10);



-- Все продажи кофе на сменах
SELECT
    B.name AS Barista_Name,
     S.shift_id AS Shift,
    S.date AS Shift_Date,
    C.name AS Coffee_Name,
    C.price AS Coffee_Price
FROM
    Baristas AS B
INNER JOIN
    Shifts AS S ON B.shift_id = S.shift_id
INNER JOIN
    Coffees AS C ON B.barista_id = C.coffee_id;



    
-- Продаж кофе на смена с (пример 2022-09-10 - 2022-09-15)
SELECT
    B.name AS Barista_Name,
	S.shift_id AS Shift,
    S.date AS Shift_Date,
    C.name AS Coffee_Name,
    C.price AS Coffee_Price
FROM
    Baristas AS B
INNER JOIN
    Shifts AS S ON B.shift_id = S.shift_id
INNER JOIN
    Coffees AS C ON B.barista_id = C.coffee_id
WHERE
    S.date BETWEEN '2022-09-11' AND '2022-09-15';
    
    

-- Выборка барист, продавших определенный кофе на смене (пример 'Капучино 200 мл' на смене с 2022-09-11 по 2022-09-15)
SELECT
    B.name AS Barista_Name,
	S.shift_id AS Shift,
    S.date AS Shift_Date,
    C.name AS Coffee_Name,
    C.price AS Coffee_Price
FROM
    Baristas AS B
INNER JOIN
    Shifts AS S ON B.shift_id = S.shift_id
INNER JOIN
    Coffees AS C ON B.barista_id = C.coffee_id
WHERE
    C.name = 'Латте' AND S.date BETWEEN '2022-09-11' AND '2022-09-15'
    OR
    C.name = 'Капучино 200 мл' AND S.date BETWEEN '2022-09-11' AND '2022-09-15'
    -- не выведет, тк его в эти дни не продавали
    or
    C.name = 'Эспрессо' AND S.date BETWEEN '2022-09-11' AND '2022-09-15'