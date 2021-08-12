-- Задача 2_1 Подсчитайте средний возраст пользователей в таблице users.

use shop;
select * from users;

-- вычисляем возраст
select 
name, 
timestampdiff(year, birthday_at, now()) as age
from 
users;

-- вычисляем средний возраст
select 
floor(avg(timestampdiff(year, birthday_at, now()))) as age
from 
users;