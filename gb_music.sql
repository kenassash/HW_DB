-- Задание 1. Составить общее текстовое описание БД и решаемых ею задач;
-- Описание:
-- Мной была разработана база данных для хранения музыки. 
-- В этой БД пользователь может зарегистрироваться, создать свой профиль, слушать музыку, ставить ей лайки.
-- Пользователь так же может создавать плейлисты, слушать музыку определенных исполнителей, жанров и так далее.
-- Так же можно делать подброки для пользователей. Оценивать их вкусы.

-- Задание 2. Создание таблиц (минимум 10)
-- Задание 3. Скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);
use gb_music;

-- информация о зарегистрированном пользователе
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
	id SERIAL PRIMARY KEY, 
    email VARCHAR(120) UNIQUE,
    phone BIGINT, 
    INDEX users_phone_idx(phone),
	INDEX users_email_idx(email)
);

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id BIGINT UNSIGNED NOT NULL,
    gender CHAR(1),
    birthday DATE,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100),
    firstname VARCHAR(50),
    lastname VARCHAR(50),
	INDEX users_firstname_lastname_idx(firstname, lastname),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS `artists`;
CREATE TABLE `artists` (
	id SERIAL PRIMARY KEY,
	artist_name VARCHAR(50),
	info VARCHAR(255),
    INDEX artist_name_idx(artist_name)
);

DROP TABLE IF EXISTS `genres`;
CREATE TABLE `genres` (
	id SERIAL PRIMARY KEY,
	genre VARCHAR(50),
    INDEX genre_namex(genre)
);

DROP TABLE IF EXISTS `albums`;
CREATE TABLE `albums` (
	id SERIAL PRIMARY KEY,
    album_name VARCHAR(125),
    date_created date,
    album_description VARCHAR(255),
    genre_id BIGINT UNSIGNED NOT NULL,
    INDEX album_namex(album_name),
    INDEX genre_idx(genre_id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

DROP TABLE IF EXISTS `tracks`;
CREATE TABLE `tracks` (
	id SERIAL PRIMARY KEY,
    media_data BLOB NOT NULL,
    track_name VARCHAR(125),
    track_number int,
    album_id BIGINT UNSIGNED NOT NULL,
    INDEX track_idx(track_name),
    INDEX track_album_idx(album_id),
    FOREIGN KEY (album_id) REFERENCES albums(id)
);



DROP TABLE IF EXISTS `track_authors`;
CREATE TABLE `track_authors` (
    artist_id BIGINT UNSIGNED NOT NULL,
	track_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (artist_id, track_id),
    FOREIGN KEY (artist_id) REFERENCES artists(id),
    FOREIGN KEY (track_id) REFERENCES tracks(id)
);




DROP TABLE IF EXISTS `playlists`;
CREATE TABLE `playlists` (
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    playlist_name VARCHAR(255),
    INDEX playlist_namex(playlist_name),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS `playlist_tracks`;
CREATE TABLE `playlist_tracks` (
    playlist_id BIGINT UNSIGNED NOT NULL,
    track_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (playlist_id, track_id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(id),
    FOREIGN KEY (track_id) REFERENCES tracks(id)
);

DROP TABLE IF EXISTS `tracks_likes`;
CREATE TABLE `tracks_likes` (
	user_id BIGINT UNSIGNED NOT NULL,
	track_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, track_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (track_id) REFERENCES tracks(id)
);

DROP TABLE IF EXISTS `artists_likes`;
CREATE TABLE `artists_likes` (
	user_id BIGINT UNSIGNED NOT NULL,
	artist_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, artist_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (artist_id) REFERENCES artists(id)
);

DROP TABLE IF EXISTS `albums_likes`;
CREATE TABLE `albums_likes` (
	user_id BIGINT UNSIGNED NOT NULL,
	albums_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, albums_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (albums_id) REFERENCES albums(id)
);

-- Задание 4. Создать ERDiagram для БД; (в приложении)

-- Задание 5. Скрипты наполнения БД данными; (смотри в приложении)

-- Задание 6. Скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);
-- 			Вывожу таблицу  с названием песни, названием альбома и именем артиста
select 
	tr.track_name,
    alb.album_name,
    a.artist_name
from 
	tracks as tr
		left join albums as alb
		on tr.album_id = alb.id
        
			left join 
			track_authors as tr_a
			on tr.id = tr_a.track_id
            
				left join
                artists as a
                on tr_a.artist_id = a.id;
	

-- 		посчитать сколько раз лайкнули каждую из песен

select 
tr.track_name,
   count(tr.track_name)
from  
	tracks_likes as tr_l
		left join 
		tracks as tr
		on tr.id = tr_l.track_id
        
	group by tr.track_name
	order by tr.track_name;


--    	Вложенный запрос, который показывает какой пользователь лайкнул какой трек
 select 
 	tracks_likes.track_id,
    (select 
		users.email
    from
		users
    where 
		users.id = tracks_likes.user_id) as 'email'
from     
	tracks_likes;

    



-- Задание 7. Представления (минимум 2);

--     	Создам представление для более простого поиска названий песен, артисов и альбомов во вью, запрос будет похож на задание 6 и сортировкой по альбому

	create view track_author_album_genre
    as
    select 
	tr.track_name, tr.id as track_id,
    alb.album_name, alb.id as album_id,
    a.artist_name, a.id as artist_id,
    g.genre, g.id as genre_id
	from 
		tracks as tr
			left join albums as alb
			on tr.album_id = alb.id
			
				left join 
				track_authors as tr_a
				on tr.id = tr_a.track_id
				
					left join
					artists as a
					on tr_a.artist_id = a.id
                    
						left join
						genres as g
						on g.id = alb.genre_id
	order by alb.id
                    ;

-- 		создам представление для того чтобы было видно все лайки пользователей под песнями и понять к какому альбому и жанру они относятся

create view user_likes_tracks
as
select 
	u.id as user_id,
    p.gender, p.birthday, p.hometown,
    tr.track_name,
    a.artist_name, a.info,
    alb.album_name, alb.date_created,
    g.genre
from
 users as u
	inner join
    profiles as p
    on u.id = p.user_id
		
        left join 
        tracks_likes as tr_l
        on u.id = tr_l.user_id
        
        left join
        tracks as tr
        on tr.id = tr_l.track_id
		
			left join 
			track_authors as tr_a
			on tr_a.track_id = tr.id
			
			left join 
			artists as a
			on a.id = tr_a.artist_id
            
				left join
                albums as alb
                on tr.album_id = alb.id
                    
                    left join
                    genres as g
                    on g.id = alb.genre_id
        order by u.id;
 -- 		из последнего вью можно понять, например, какие песни больше нравятся женщинам или мужчинам, в моем случае жензины больше любят рок, чем мужчины     
	select * from user_likes_tracks;
	select count(*) from user_likes_tracks where gender = 'f' and genre='rock';
	select count(*) from user_likes_tracks where gender = 'm' and genre='rock';


-- Задание 8. Хранимые процедуры / триггеры;


-- 		проверка пользователя на наличие данных
DROP TRIGGER IF EXISTS check_user;

DELIMITER //
CREATE TRIGGER check_user BEFORE INSERT ON users
FOR EACH ROW
    BEGIN
        IF (ISNULL(gb_music.email) AND ISNULL(gb_music.phone)) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT cancelled';
        END IF;
    END//
DELIMITER ;


--  	Функция возвращает возраст заданного пользователя

DROP FUNCTION IF EXISTS AGE;
DELIMITER //
CREATE FUNCTION AGE(id BIGINT UNSIGNED)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE Y BIGINT UNSIGNED;
    SET Y = (SELECT timestampdiff(year,birthday, now()) FROM profiles WHERE user_id = id);
	RETURN Y;  
END//

SELECT AGE(5);
