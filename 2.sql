#2. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

-- Допустим, интересует нас пользователь с id 100

SELECT  (SELECT	from_users_id
	FROM messages
	-- В рассчёт будем брать только количество ответов, а то может быть потенциальный друг и не отвечал совсем
  	WHERE to_users_id = users.id AND from_users_id IN (
  				-- вычисляем друзей
	  			SELECT IF(from_users_id = users.id, to_users_id, from_users_id) 
	  			FROM friend_requests 
	  			WHERE status = 1 AND (from_users_id = users.id or to_users_id = users.id))
  	GROUP BY from_users_id
  	-- ну и сортируем по убыванию, забирая самый топ
  	ORDER BY COUNT(from_users_id) DESC LIMIT 1) AS best_friend_id
FROM users 
-- фильтр по запрашиваемому пользователю. 
WHERE id = 100;