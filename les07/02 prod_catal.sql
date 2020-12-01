/*
2. Выведите список товаров products и разделов catalogs, который соответствует товару.
*/

select 
	p.name as product_name,
	c.name as catalog_name
from products p 
	join catalogs c on (p.catalog_id=c.id)
;