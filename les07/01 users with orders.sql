/*
 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в
интернет магазине.
 */


select *
from users u 
where id in (select o.user_id from orders o )
;

select u.*
from users u 
	join
	(
	select distinct o.user_id from orders o 
	) o on (o.user_id=u.id)
;

select *
from users u 
where exists (select 1 from orders o where o.user_id=u.id)
;

