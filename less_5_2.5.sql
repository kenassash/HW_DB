-- Задача 5_1 Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.


use shop;

select * from catalogs;

select * from catalogs where id = 1 or id = 2 or id = 5 order by FIELD(id,5,1,2);