/*
В таблице products есть два текстовых поля: name с названием товара и description с его
описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля
принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь
того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям
NULL-значение необходимо отменить операцию.
*/

select *
from products p 
;

DELIMITER //

DROP TRIGGER IF EXISTS check_ins_prod_fields//

CREATE TRIGGER check_ins_prod_fields BEFORE INSERT ON products
FOR EACH ROW 
BEGIN
IF (NEW.name is null and NEW.description is null) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Name and description is NULL. Fill one or both.';
END IF;
END//

DROP TRIGGER IF EXISTS check_upd_prod_fields//

CREATE TRIGGER check_upd_prod_fields BEFORE UPDATE ON products
FOR EACH ROW 
BEGIN
IF (NEW.name is null and NEW.description is null) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Name and description is NULL. Fill one or both.';
END IF;
END//

DELIMITER ;

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (null, null, 7890.00, 1);

UPDATE products
  SET name=NULL, 
  description=NULL
where id=2;

INSERT INTO products
  (name, description, price, catalog_id)
VALUES 
  ('Intel Core i7-7400', null, 15700.00, 1);

  
