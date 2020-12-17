/*
Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
catalogs и products в таблицу logs помещается время и дата создания записи, название
таблицы, идентификатор первичного ключа и содержимое поля name.
 */

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  insert_dtime DATETIME DEFAULT CURRENT_TIMESTAMP,
  table_name VARCHAR(255),
  pk_id BIGINT,
  name VARCHAR(255)
) ENGINE=Archive
;

DELIMITER //

DROP TRIGGER IF EXISTS log_products//

CREATE TRIGGER log_products AFTER INSERT ON products
FOR EACH ROW 
BEGIN
insert INTO logs (table_name, pk_id, name) VALUES  ('products', new.id, new.name );
END//

DROP TRIGGER IF EXISTS log_users//

CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW 
BEGIN
insert INTO logs (table_name, pk_id, name) VALUES  ('users', new.id, new.name );
END//

DROP TRIGGER IF EXISTS log_catalogs//

CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN
insert INTO logs (table_name, pk_id, name) VALUES  ('catalogs', new.id, new.name );
END//

DELIMITER ;


INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
 
INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
 
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

select *
from logs
;