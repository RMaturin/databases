/*
Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
Числами Фибоначчи называется последовательность в которой число равно сумме двух
предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
 */


DELIMITER //

DROP FUNCTION IF EXISTS FIBONACCI//

CREATE FUNCTION FIBONACCI (IN_NUM INT)
RETURNS BIGINT DETERMINISTIC
BEGIN

DECLARE V_RES, V_LAG1, V_LAG2 BIGINT DEFAULT 0;
DECLARE i INT DEFAULT 0;

WHILE (i <= IN_NUM) DO
	IF (i<2) THEN 
		SET V_RES = i;
		SET V_LAG2 = V_LAG1;
		SET V_LAG1 = V_RES;
	ELSE
		SET V_RES = V_LAG1+V_LAG2;
		SET V_LAG2 = V_LAG1;
		SET V_LAG1 = V_RES;
	END IF;
	SET i = i + 1;
END WHILE;
	
RETURN V_RES;
	
END//

DELIMITER ;

select FIBONACCI(10);