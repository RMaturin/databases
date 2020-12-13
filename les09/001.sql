drop database if exists shop;
create database if not exists shop character set = utf8mb4;
use shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  user_name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (user_name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

drop database if exists sample;
create database if not exists sample character set = utf8mb4;
use sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  user_name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

/***************************************/

select *
from shop.users;

select *
from sample.users;

/*
В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте
транзакции.
*/

START TRANSACTION;

INSERT INTO sample.users (id, user_name, birthday_at, created_at, updated_at)
SELECT 
	u.id ,
	u.user_name ,
	u.birthday_at ,
	u.created_at ,
	u.updated_at 
FROM shop.users u
where u.id = 1;

delete from shop.users where id = 1;

commit;

/*****************************************/

select *
from sample.users;

select *
from shop.users;
