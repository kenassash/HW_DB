-- Задание 2_3. Подсчитайте произведение чисел в столбце таблицы

use shop;
select * from users;

select exp(sum(ln (id))) as rez from users u ;