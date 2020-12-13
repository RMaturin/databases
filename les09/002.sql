/*
Создайте представление, которое выводит название name товарной позиции из таблицы
products и соответствующее название каталога name из таблицы catalogs. 
 */
create or replace view products_vw as
select 
p.name as product_name,
c.name as catalog_name
from products p 
	join catalogs c on (p.catalog_id=c.id)
;

select *
from products_vw
;
