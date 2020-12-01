/*
3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label,
name). Поля from, to и label содержат английские названия городов, поле name — русское.
Выведите список рейсов flights с русскими названиями городов.
*/

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id INT,
  	city_from VARCHAR(255),
  	city_to VARCHAR(255)
);
INSERT INTO flights
	(id, city_from, city_to)
VALUES 
	(1,'moscow','omsk'), 
	(2,'novgorod','kazan'), 
	(3,'irkutsk','moscow'),
	(4,'omsk','irkutsk'),
	(5,'moscow','kazan');

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	label VARCHAR(255),
  	name VARCHAR(255)
);
INSERT INTO cities
	(label,name)
VALUES 
	('moscow','Москва'),
	('irkutsk','Иркутск'),
	('novgorod','Новгород'),
	('kazan','Казань'),
	('omsk','Омск');

select 
	f.id ,
	c_f.name as city_from ,
	c_t.name as city_to 
from flights f
	join cities c_f on (f.city_from = c_f.label) 
	join cities c_t on (f.city_to = c_t.label) 
order by 1
;



