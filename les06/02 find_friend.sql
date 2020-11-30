/*Пусть задан некоторый пользователь.
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим
пользователем.*/


select 
	u.firstname,
	u.lastname 
from users u 
where id = 
	(
	select from_user_id from (
	select 
		m.from_user_id,
		count(*) cnt_msg
	from messages m
		join 
			(
			select 
				case (32)
					when initiator_user_id then target_user_id
					when target_user_id then initiator_user_id
				end friends_id
			from friend_requests fr
			where status = 'approved'
				and (target_user_id = 32 or initiator_user_id = 32)
			) flist on (friends_id=m.from_user_id)
	where to_user_id = 32 -- пользователь 32
	group by m.from_user_id
	order by cnt_msg desc
	limit 1) f
	)

;