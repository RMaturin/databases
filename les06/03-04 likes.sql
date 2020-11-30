/* Структура моей таблицы лайков vk

create table like_types(
	id smallint unsigned not null auto_increment unique primary key,
	like_type_name varchar(200)
);

insert into like_types (like_type_name) values ('users');
insert into like_types (like_type_name) values ('photos');
insert into like_types (like_type_name) values ('posts');
insert into like_types (like_type_name) values ('comments');

 
 create table user_likes(
	user_id bigint unsigned not null,
	like_type_id smallint unsigned not null,
	external_id bigint unsigned not null,
	is_liked bool default 1,
	updated_at datetime default current_timestamp on update current_timestamp,
	primary key (user_id, like_type_id, external_id),
	foreign key (like_type_id) references like_types(id)
);
 
 */

-- 1) Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

select 
	count(*) cnt_likes
from user_likes ul 
	join like_types lt on (lt.id=ul.like_type_id and lt.like_type_name='users')
	join 
		(
		select 
			u.id,
			timestampdiff(year, birthday, now()) as age 
		from users u order by age, birthday desc limit 10
		) u_list on (u_list.id = ul.external_id)
where ul.is_liked = 1
;

-- Самые молодые
select 
	u.*,
	timestampdiff(year, birthday, now()) as age 
from users u order by age, birthday desc limit 10
;

-- 2) Определить кто больше поставил лайков (всего) - мужчины или женщины?

select 
	u.gender ,
	count(1) cnt_likes
from user_likes ul 
	join users u on (ul.user_id=u.id)
where ul.is_liked = 1
group by u.gender
order by cnt_likes desc limit 1;
;
;