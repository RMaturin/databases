/*
Пусть имеется любая таблица с календарным полем created_at. Создайте
запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих
записей.
*/

DROP TABLE IF EXISTS date_tab;
CREATE TABLE date_tab (
  created_at DATE COMMENT 'Дата'
) COMMENT = 'Таблица с календарным полем created_at';

INSERT INTO date_tab (created_at) VALUES
  ('2018-08-01'),
  ('2018-08-04'),
  ('2018-08-16'),
  ('2018-08-17'),
  ('2019-08-01'),
  ('2019-08-04'),
  ('2019-08-04'),
  ('2019-08-16'),
  ('2019-08-17'),
  ('2020-08-17'),
  ('2019-08-17'),
  ('2018-01-01'),
  ('2018-02-01');
 
-- Должны остаться эти записи  
select dt.created_at from date_tab dt order by created_at desc limit 5;

SELECT @total := COUNT(*)-5 FROM date_tab;

PREPARE ver FROM 'delete from date_tab order by created_at limit ?';

EXECUTE ver USING @total;

select dt.created_at from date_tab dt order by created_at desc;

