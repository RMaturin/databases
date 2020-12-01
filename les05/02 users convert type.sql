DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05','20.10.2017 8:10','20.10.2017 8:10'),
  ('Наталья', '1984-11-12','20.10.2017 8:10','20.10.2017 8:10'),
  ('Александр', '1985-05-20','20.10.2017 8:10','20.10.2017 8:10'),
  ('Сергей', '1988-02-14','20.10.2017 8:10','20.10.2017 8:10'),
  ('Иван', '1998-01-12','20.10.2017 8:10','20.10.2017 8:10'),
  ('Мария', '1992-08-29','20.10.2017 8:10','20.10.2017 8:10');
  
select *
from users;

update users set 
	created_at=STR_TO_DATE(created_at,'%d.%m.%Y %H:%i'),
	updated_at=STR_TO_DATE(updated_at,'%d.%m.%Y %H:%i');

alter table users change column created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
alter table users change column updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

DESCRIBE users;