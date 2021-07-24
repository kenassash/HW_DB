1)Проанализировать структуру БД vk, которую мы создали на занятии, и внести предложения по усовершенствованию (если такие идеи есть). Напишите пожалуйста, всё-ли понятно по структуре.

Всё понятно. Затрудняюсь пока что дать какие-то рекомендации по усовершенствованию

2)Добавить необходимую таблицу/таблицы для того, чтобы можно было использовать лайки для медиафайлов, постов и пользователей.

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
3)Используя сервис http://filldb.info или другой по вашему желанию, сгенерировать тестовые данные для всех таблиц, учитывая логику связей. Для всех таблиц, где это имеет смысл, создать не менее 100 строк. Создать локально БД vk и загрузить в неё тестовые данные.

https://github.com/kenassash/HW_DB/blob/HW_DB_3/fulldb24-07-2021%2013-35.sql
