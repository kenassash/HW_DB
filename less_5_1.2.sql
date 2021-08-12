-- Задача 1_2 Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

-- комментарий в выложеннной таблице вариант уже с DATETIME, пробовала менять на VARCHAR, а потом обратно на DATETIME.
-- в решении оставила только конечный вариант. Данные в таблице остались без изменения.

use shop;
select * from users;
desc users;
alter table users modify column created_at DATETIME;
alter table users modify column updated_at DATETIME;                               
                               
                            
                                