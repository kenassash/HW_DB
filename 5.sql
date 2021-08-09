#5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT 
	CONCAT(first_name, ' ', last_name) name,
	(SELECT country FROM profiles WHERE user_id = u.id) country,
	(SELECT city FROM profiles WHERE user_id = u.id) city,
	# расчитаем количество дней с последней активности в разрезе всех таблиц
	(SELECT IFNULL(MAX(TIMESTAMPDIFF(DAY, confirmed_at, NOW())), 0) res FROM friendship WHERE user_id = u.id OR friend_id = u.id) friend,
	(SELECT IFNULL(MAX(TIMESTAMPDIFF(DAY, created_at, NOW())), 0) res FROM likes WHERE user_id = u.id OR target_id = u.id) likes,
	(SELECT IFNULL(MAX(TIMESTAMPDIFF(DAY, updated_at, NOW())), 0) res FROM media WHERE user_id = u.id) media,
	(SELECT IFNULL(MAX(TIMESTAMPDIFF(DAY, edited_at, NOW())), 0) res FROM messages WHERE from_user_id = u.id OR to_user_id = u.id) mes,
	(SELECT IFNULL(MAX(TIMESTAMPDIFF(DAY, updated_at, NOW())), 0) res FROM posts WHERE user_id = u.id) post,
	(SELECT(friend + likes + media + mes + post)) AS passive
FROM 
	users u
ORDER BY passive DESC
LIMIT 10;