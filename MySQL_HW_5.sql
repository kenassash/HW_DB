1)���������������� ��������� �� vk, ������� �� ������� �� �������, � ������ ����������� �� ������������������ (���� ����� ���� ����). �������� ����������, ��-�� ������� �� ���������.

�� �������. ����������� ���� ��� ���� �����-�� ������������ �� ������������������

2)�������� ����������� �������/������� ��� ����, ����� ����� ���� ������������ ����� ��� �����������, ������ � �������������.

	drop table if EXISTS photo_likes;
	create table photo_likes (
		user_id  bigint unsigned not null,
		photo_id bigint unsigned not null,
		primary key (user_id, photo_id),
		foreign key (user_id) references  users (id),
		foreign key (photo_id) references photos (id)
	);

	drop table if EXISTS post_likes;
	create table post_likes (
		user_id  bigint unsigned not null,
		post_id bigint unsigned not null,
		primary key (user_id, post_id),
		foreign key (user_id) references  users (id),
		foreign key (post_id) references posts (id)
	);

	drop table if EXISTS user_likes;
	create table user_likes (
		from_user_id  bigint unsigned not null,
		to_user_id bigint unsigned not null,
		primary key (from_user_id, to_user_id),
		foreign key (from_user_id) references users (id),
		foreign key (to_user_id) references users (id)
	);
3)��������� ������ http://filldb.info ��� ������ �� ������ �������, ������������� �������� ������ ��� ���� ������, �������� ������ ������. ��� ���� ������, ��� ��� ����� �����, ������� �� ����� 100 �����. ������� �������� �� vk � ��������� � �� �������� ������.
