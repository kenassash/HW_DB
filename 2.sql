#2. ����� ����� ��������� ������������. �� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� � ����� �������������.

-- ��������, ���������� ��� ������������ � id 100

SELECT  (SELECT	from_users_id
	FROM messages
	-- � ������� ����� ����� ������ ���������� �������, � �� ����� ���� ������������� ���� � �� ������� ������
  	WHERE to_users_id = users.id AND from_users_id IN (
  				-- ��������� ������
	  			SELECT IF(from_users_id = users.id, to_users_id, from_users_id) 
	  			FROM friend_requests 
	  			WHERE status = 1 AND (from_users_id = users.id or to_users_id = users.id))
  	GROUP BY from_users_id
  	-- �� � ��������� �� ��������, ������� ����� ���
  	ORDER BY COUNT(from_users_id) DESC LIMIT 1) AS best_friend_id
FROM users 
-- ������ �� �������������� ������������. 
WHERE id = 100;