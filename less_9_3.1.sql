/*
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С
6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу
"Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

DROP FUNCTION IF EXISTS hello;

DELIMITER //

CREATE FUNCTION hello (value DATETIME)
RETURNS TINYTEXT DETERMINISTIC
BEGIN
    DECLARE message TINYTEXT;
    SET message = CASE
        WHEN TIME(value) BETWEEN '06:00:00' AND '11:59:59'
            THEN 'Доброе утро!'
        WHEN TIME(value) BETWEEN '12:00:00' AND '17:59:59'
            THEN 'Добрый день!'
        WHEN TIME(value) BETWEEN '18:00:00' AND '23:59:59'
            THEN 'Добрый вечер!'
        WHEN TIME(value) BETWEEN '00:00:00' AND '05:59:59'
            THEN 'Доброй ночи!'
        ELSE 'Неверный формат даты!'
    END;
    RETURN message;
END;

DELIMITER ;

SELECT hello('1995-12-01 00:00:00'); /* Доброй ночи! */
SELECT hello('2015-03-22 23:59:59'); /* Доброй вечер! */
SELECT hello('2015-03-22 15:56:45'); /* Добрый день! */
SELECT hello(NOW());