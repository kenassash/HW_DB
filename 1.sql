#1. Проанализировать запросы, которые выполнялись на занятии, определить возможные 
#корректировки и/или улучшения (JOIN пока не применять).


-- Архив с правильной сортировкой новостей по месяца
SELECT COUNT(id) AS news, 
  -- вывести ссылку новости
  filename,
  MONTHNAME(created_at) AS month,
   -- добавить колонку по годам
  YEAR(created_at) AS year_num,
  MONTH(created_at) AS month_num
    FROM media
    -- добавить группировку по годам
    GROUP BY year_num, month_num, MONTH
    -- добавить сортировку по годам
    ORDER BY year_num DESC, month_num DESC;