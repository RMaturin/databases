
INSERT INTO users (name, birthday_at) VALUES
  ('Валерий', '1990-10-04'),
  ('Игнат', '1985-05-21'),
  ('Степан', '1985-05-25');


 select 
 	day_num,
 	count(1) cnt
 from 
	 (
	 select 
		u.id ,
		u.name,
		u.birthday_at ,
		CONCAT( YEAR (CURRENT_DATE()), SUBSTRING(u.birthday_at,5)) current_birthday,
		DAYOFWEEK(CONCAT( YEAR (CURRENT_DATE()), SUBSTRING(u.birthday_at,5))) day_num,
		DAYNAME(CONCAT( YEAR (CURRENT_DATE()), SUBSTRING(u.birthday_at,5))) day_name
	from users u 
	) t
group by day_num
;