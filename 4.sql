#4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
	COUNT(*) AS likes,
	(
	SELECT
		CASE (gender) WHEN 'm' THEN 'male'
		WHEN 'f' THEN 'female' END AS gender
	FROM
		profiles
	WHERE
		user_id = l.user_id) AS gender
FROM
	likes l
GROUP BY
	gender
ORDER BY
	likes DESC;