# 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products
# в таблицу logs помещается время и дата создания записи, название таблицы,
# идентификатор первичного ключа и содержимое поля name.

drop table if exists log;
create table log
(
    date       datetime default now() not null,
    table_name char(25)               not null,
    id_table   bigint                 not null,
    name       varchar(255)           null
)
    comment 'архив' engine = ARCHIVE;

drop trigger if exists log_users_a_insert;
create trigger log_users_a_insert
    after insert
    on users
    for each row
begin
    insert into log (table_name, id_table, name)
    values ('users', NEW.id, NEW.name);
end;

drop trigger if exists log_catalogs_a_insert;
create trigger log_catalogs_a_insert
    after insert
    on catalogs
    for each row
begin
    insert into log (table_name, id_table, name)
    values ('catalogs', NEW.id, NEW.name);
end;

drop trigger if exists log_products_a_insert;
create trigger log_products_a_insert
    after insert
    on products
    for each row
begin
    insert into log (table_name, id_table, name)
    values ('products', NEW.id, NEW.name);
end;