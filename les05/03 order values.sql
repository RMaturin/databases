DROP TABLE IF EXISTS storehouses_products;

CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES
  (1,1,0),
  (1,2,1),
  (1,3,0),
  (1,4,30),
  (1,5,0),
  (1,6,4),
  (1,7,8),
  (1,8,3);
  

 select 
	value
 from 
	 (
	 select 
		t.value,
		CASE 
			when t.value=0 then 1
			else 0
		end order_flg
	from storehouses_products t
	) t
order by order_flg,value;