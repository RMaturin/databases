/*
Пусть имеется таблица accounts содержащая три столбца id, name, password,
содержащие первичный ключ, имя пользователя и его пароль. Создайте представление
username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте
пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы
извлекать записи из представления username.
 */

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  password char(40)
) 
;

create or replace view username as
select a.id ,
a.name 
from accounts a 
;

CREATE USER user_read;
GRANT SELECT ON shop.username TO user_read;
