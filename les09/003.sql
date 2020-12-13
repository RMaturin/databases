/*
Пусть имеется таблица с календарным полем created_at. В ней размещены
разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и
2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в
соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она
отсутствует.
*/

DROP TABLE IF EXISTS date_tab;
CREATE TABLE date_tab (
  id SERIAL PRIMARY KEY,
  created_at DATE COMMENT 'Дата'
) COMMENT = 'Таблица с календарным полем created_at';

INSERT INTO date_tab (created_at) VALUES
  ('2018-08-01'),
  ('2018-08-04'),
  ('2018-08-16'),
  ('2018-08-17');
  

SET @st_date := '2018-08-01';
SET @end_date := '2018-08-31';

select 
	t.aug_date as aug_date,
	case 
		when dt.created_at is not null then 1 else 0
	end exists_in_date_tab
from 
	(
	select @st_date + interval (a.a+b.a*10) day as aug_date
	from (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as a
		cross join (select 0 as a union all select 1 union all select 2 union all select 3) as b
	) t
	left join date_tab dt on (t.aug_date=dt.created_at)
where aug_date<=@end_date
order by t.aug_date;
