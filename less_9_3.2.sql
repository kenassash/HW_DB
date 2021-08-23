/*
В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие
обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя
триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям
NULL-значение необходимо отменить операцию.
*/

DROP TRIGGER IF EXISTS check_insert_name_description_values;

DELIMITER //

CREATE TRIGGER check_insert_name_description_values BEFORE INSERT ON products
    FOR EACH ROW
BEGIN
    IF NEW.name IS NULL AND NEW.description IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled!';
    END IF;
END//

DELIMITER ;

INSERT INTO products (name, description, price)
VALUES ('Voodoo 3DFX', 'Видеокарта', 1000000.00); /* SUCCESS */

INSERT INTO products (name, price)
VALUES ('Voodoo 3DFX', 1000000.00); /* SUCCESS */

INSERT INTO products (description, price)
VALUES ('Видеокарта', 1000000.00); /* SUCCESS */

INSERT INTO products (price)
VALUES (1000000.00); /* INSERT canceled! */




DROP TRIGGER IF EXISTS check_update_name_description_values;

DELIMITER //

CREATE TRIGGER check_update_name_description_values BEFORE UPDATE ON products
    FOR EACH ROW
BEGIN
    IF (NEW.name IS NULL AND NEW.description IS NULL)
        OR (OLD.name IS NULL AND NEW.description IS NULL)
        OR (OLD.description IS NULL AND NEW.name IS NULL)
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled!';
    END IF;
END//

DELIMITER ;

UPDATE products
    SET name = 'Voodoo', description = 'Видеоадаптер'
    WHERE id = 18; /* SUCCESS */

UPDATE products
    SET name = NULL, description = 'Видеоадаптер'
    WHERE id = 18; /* SUCCESS */

UPDATE products
    SET name = NULL, description = NULL
    WHERE id = 18; /* UPDATE canceled! */

UPDATE products
    SET description = NULL
    WHERE id = 18; /* UPDATE canceled! */

UPDATE products
    SET name = 'Voodoo'
    WHERE id = 18; /* SUCCESS */

UPDATE products
    SET description = NULL
    WHERE id = 18; /* SUCCESS */

UPDATE products
    SET name = NULL
    WHERE id = 18; /* UPDATE canceled! */