/*
 Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от
текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с
12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый
вечер", с 00:00 до 6:00 — "Доброй ночи".
 */


DELIMITER //

DROP FUNCTION IF EXISTS hello//

CREATE FUNCTION hello ()
RETURNS varchar(255)
BEGIN

DECLARE v_time time DEFAULT CURTIME();
	
IF     (hour(v_time) >=  0 and hour(v_time) <  6) then return 'Доброй ночи';
ELSEIF (hour(v_time) >=  6 and hour(v_time) < 12) then return 'Доброе утро';
ELSEIF (hour(v_time) >= 12 and hour(v_time) < 18) then return 'Добрый день';
ELSEIF (hour(v_time) >= 18 and hour(v_time) < 24) then return 'Добрый вечер';
END IF;
	
END//

DROP FUNCTION IF EXISTS hello_check//

CREATE FUNCTION hello_check (v_time time)
RETURNS varchar(255)
BEGIN

IF     (hour(v_time) >=  0 and hour(v_time) <  6) then return CONCAT('Сейчас ',TIME_FORMAT(v_time, '%k:%i'),' - ','Доброй ночи');
ELSEIF (hour(v_time) >=  6 and hour(v_time) < 12) then return CONCAT('Сейчас ',TIME_FORMAT(v_time, '%k:%i'),' - ','Доброе утро'); -- 'Доброе утро';
ELSEIF (hour(v_time) >= 12 and hour(v_time) < 18) then return CONCAT('Сейчас ',TIME_FORMAT(v_time, '%k:%i'),' - ','Добрый день'); -- 'Добрый день';
ELSEIF (hour(v_time) >= 18 and hour(v_time) < 24) then return CONCAT('Сейчас ',TIME_FORMAT(v_time, '%k:%i'),' - ','Добрый вечер'); -- 'Добрый вечер';
END IF;
	
END//

DELIMITER ;

select 
hello () h1,
hello_check (CURTIME()) h2,
hello_check ('04:53:00') h3,
hello_check ('08:15:00') h4,
hello_check ('12:00:00') h5,
hello_check ('18:41:37') h6
;






