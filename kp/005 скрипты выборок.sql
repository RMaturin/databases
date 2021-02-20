/*скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);*/

-- 1) Количкство опубликованных объявлений у пользователей
select 
	u.id,
	u.name,
	u.user_type,
	count(a.id) cnt
from ads a
	join users u on (a.user_id=u.id)
where a.status='published'
group by 
	u.id,
	u.name,
	u.user_type
order by cnt desc
;

-- 2) Пять пользователей с самым лучшим рейтингом и информация по ним
Select 
	u.name,
	u.user_type,
	round(avg(r.rating),2) avg_rating,
	count(r.id) cnt_reviews,
	(select count(1) from subscribers_list s where s.signer=u.id and s.is_signed=1) cnt_subscribers,
	(select count(1) from ads a where a.user_id=u.id and a.status='published') cnt_ads
from users u 
	join reviews r on (r.seller_id=u.id)
group by u.id,
	u.name,
	u.user_type
order by avg_rating DESC
limit 5
;



-- 3) Выбираем пользователей без объявлений. Определяем избранные обьявления и подбираем те объявления, которые попадают в ту же ценовую категорию, но не в избранном.

SELECT @town := 'Moscow' ;

select 
	l.id as user_id,
	l.category_id,
	min_pr,
	max_pr,
	a1.headline,
	a1.price
from ads a1
	join 
	(
	select 
		u.id,
		c.id category_id,
		min(a.price) min_pr,
		max(a.price) max_pr
	from users u
		join featured_ads f on (f.user_id=u.id and f.is_selected=1)
		join ads a on (f.ad_id=a.id and a.status='published')
		join ad_category c on (a.category_id=c.id) 
	where (select count(1) from ads a where a.user_id=u.id)=0
		and u.user_type='Частное лицо'
		and a.town=@town
	group by u.id,
		c.id
	) l on (a1.category_id=l.category_id and a1.price between min_pr and max_pr)
where a1.status='published'
	and a1.town=@town
	and not exists (select 1 from featured_ads f1 where f1.ad_id=a1.id and f1.user_id=l.id)
order by 1
;



