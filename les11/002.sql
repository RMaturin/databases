use sample;

INSERT INTO users (user_name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29'),
  ('Степан', '1989-05-29'),
  ('Илья', '1968-03-10'),
  ('Глеб', '1976-10-11'),
  ('Дарья', '1990-04-01')
  ;

use shop;

truncate table shop.users;

insert shop.users (name, birthday_at)
select u1.user_name ,
	   u1.birthday_at 
from sample.users u1,
	sample.users u2,
	sample.users u3,
	sample.users u4,
	sample.users u5,
	sample.users u6
;

select count(1)
from users
;

