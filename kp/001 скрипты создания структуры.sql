-- БД "Доска объявлений" для сайта с объявлениями (Avito, Юла ...)
-- В БД хранится информация об объявлениях и пользователях.
-- Продавцов можно оценивать и оставлять отзывы о них. Также на объявления продавца можно подписаться.
-- Продавцу можно задать вопросы о товаре в виде сообщения.
-- Объявления можно отправить в избранное.

drop database if exists ad_db;
create database if not exists ad_db character set = utf8mb4;
use ad_db;

-- 1) Таблица категорий объявлений
DROP TABLE IF EXISTS ad_category;
CREATE TABLE ad_category (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL COMMENT 'Название категории',
  parent_id BIGINT UNSIGNED COMMENT 'Идентификатор родительской категории',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_deleted BOOL DEFAULT 0,
  deleted_at DATETIME
) COMMENT = 'Категории объявлений';

ALTER TABLE ad_category ADD CONSTRAINT fk_parent_id
    FOREIGN KEY (parent_id) REFERENCES ad_category (id) ON UPDATE CASCADE ON DELETE CASCADE;

-- 2) Пользователи
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL COMMENT 'Имя пользователя',
  user_type ENUM ('Частное лицо', 'Компания') COMMENT 'Тип пользователя',
  phone VARCHAR(20) UNIQUE COMMENT 'Номер телефона',
  photo_filename VARCHAR(200) NULL COMMENT 'Фото пользователя',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Пользователи доски объявлений';

alter table users add index user_type_indx (user_type);

-- 3) Объявления
DROP TABLE IF EXISTS ads;
CREATE TABLE ads (
  id SERIAL PRIMARY KEY,
  headline VARCHAR(255) NOT NULL COMMENT 'Заголовок',
  category_id BIGINT UNSIGNED NOT NULL COMMENT 'Категория',
  user_id BIGINT UNSIGNED NOT NULL COMMENT 'Пользователь',
  town VARCHAR(100) COMMENT 'Город',
  price DECIMAL (11,2) COMMENT 'Цена',
  description TEXT COMMENT 'Описание',
  status ENUM ('created', 'published', 'closed', 'sold', 'deleted') DEFAULT 'created' COMMENT 'Статус объявления',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  foreign key (category_id) references ad_category (id),
  foreign key (user_id) references users (id)
) COMMENT = 'Объявления';

alter table ads add index ads_town_indx (town);
alter table ads add index ads_status_indx (status);

-- 4) Характиристики для категорий товара
DROP TABLE IF EXISTS characteristic_type;
CREATE TABLE characteristic_type (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL COMMENT 'Наименование',
  category_id BIGINT UNSIGNED NOT NULL COMMENT 'Категория',
  description TEXT COMMENT 'Описание',
  value_type ENUM ('int','decimal','string', 'date', 'flag', 'ref') COMMENT 'Тип значения',
  is_mandatory BOOL DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  foreign key (category_id) references ad_category (id)
) COMMENT = 'Характеристики для категорий товара';

-- 5) Характиристики товара
DROP TABLE IF EXISTS ad_characteristics;
CREATE TABLE ad_characteristics (
	ad_id BIGINT UNSIGNED NOT NULL COMMENT 'Объявление',
	charact_type_id BIGINT UNSIGNED NOT NULL COMMENT 'Категория',
	number_value INT,
	decimal_value DECIMAL(30,15),
	string_value TEXT,
	date_value DATETIME,
	flag_value BOOL,
	ref_value BIGINT UNSIGNED,
  	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	primary key (ad_id, charact_type_id),
  	foreign key (ad_id) references ads (id),
  	foreign key (charact_type_id) references characteristic_type (id)
) COMMENT = 'Характеристики товара';

-- 6) Фото объявлений
DROP TABLE IF EXISTS photos;
CREATE TABLE photos(
	id SERIAL PRIMARY KEY,
	ad_id BIGINT UNSIGNED NOT NULL,
	filename VARCHAR(200),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	foreign key (ad_id) references ads (id)
) COMMENT = 'Фото объявлений';

-- 7) Отзывы
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews(
	id SERIAL PRIMARY KEY,
	seller_id BIGINT UNSIGNED NOT NULL COMMENT 'Продавец',
	ad_id BIGINT UNSIGNED COMMENT 'Объявление',
	author_user_id BIGINT UNSIGNED NOT NULL COMMENT 'Автор отзыва',
	rating TINYINT(1) UNSIGNED NOT NULL COMMENT 'Оценка количество звезд (1-5)',
	comment TEXT COMMENT 'Отзыв',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	foreign key (ad_id) references ads (id),
	foreign key (seller_id) references users (id),
	foreign key (author_user_id) references users (id),
	CONSTRAINT ch_01 CHECK (seller_id <> author_user_id)
) COMMENT = 'Отзывы';

-- 8) Сообщения по объявлению
DROP TABLE IF EXISTS messages;
CREATE TABLE messages(
	id SERIAL PRIMARY KEY,
	ad_id BIGINT UNSIGNED NOT NULL COMMENT 'Объявление',
	from_user_id BIGINT UNSIGNED NOT NULL COMMENT 'Сообщение от',
	to_user_id BIGINT UNSIGNED NOT NULL COMMENT 'Сообщение кому',
	message VARCHAR(500) COMMENT 'Сообщение',
	is_read BOOL DEFAULT 0,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	foreign key (ad_id) references ads (id),
	foreign key (from_user_id) references users (id),
	foreign key (to_user_id) references users (id),
	CONSTRAINT ch_02 CHECK (from_user_id <> to_user_id)
) COMMENT = 'Сообщения по объявлению';

-- 9) Избранные объявления
DROP TABLE IF EXISTS featured_ads;
CREATE TABLE featured_ads(
	user_id BIGINT UNSIGNED NOT NULL COMMENT 'Пользователь',
	ad_id BIGINT UNSIGNED NOT NULL COMMENT 'Объявление',
	is_selected BOOL DEFAULT 1,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	primary key (user_id,ad_id),
	foreign key (ad_id) references ads (id),
	foreign key (user_id) references users (id)
) COMMENT = 'Избранные объявления';

-- 10) Подписки на пользователей
DROP TABLE IF EXISTS subscribers_list;
CREATE TABLE subscribers_list(
	signer BIGINT UNSIGNED NOT NULL COMMENT 'Подписант',
	subscriber  BIGINT UNSIGNED NOT NULL COMMENT 'Подписчик',
	is_signed BOOL DEFAULT 1,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	primary key (signer,subscriber),
	foreign key (signer) references users (id),
	foreign key (subscriber) references users (id),
	CONSTRAINT ch_03 CHECK (signer <> subscriber)
) COMMENT = 'Подписки на пользователей';

