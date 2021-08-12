-- Задача 1_1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

use shop;
select * from users;

-- тк таблица была с данными - замени их на null
update users set created_at = null;
update users set updated_at = null;

-- заполнила текущей датой
update users set created_at = now();
update users set updated_at = now();
select * from users;