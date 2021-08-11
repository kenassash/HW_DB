#3. ���������� ����� ���������� ������, ������� �������� 10 ����� ������� �������������.

SELECT 
	first_name, 
	last_name,
	(SELECT birthday FROM profiles WHERE user_id = u.id) AS age,
	(SELECT COUNT(*) FROM likes WHERE target_id = u.id) AS likes
FROM 
	users u
ORDER BY
	age DESC
LIMIT 10;