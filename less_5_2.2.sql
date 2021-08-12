-- Задача 2_2 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
 use shop;
 select * from users;

-- меняем год на текущий
update users set birthday_at = DATE_FORMAT(birthday_at, '%2021.%m.%d');

-- добавляем временные столбцы с днем недели
 SELECT *, DAYOFWEEK(birthday_at) as day , DAYNAME(birthday_at) as dayname FROM users ;

-- группируем
SELECT DAYNAME(birthday_at) as dayname FROM users GROUP by dayname ;

-- считаем количество повторяющихся значений

SELECT DAYNAME(birthday_at) as dayname, count(DAYNAME(birthday_at)) as summ_d FROM users GROUP by dayname ;


