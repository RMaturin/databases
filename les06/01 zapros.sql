-- Этот кусок не работает в MySQL на ВиртМашине. Есть подозрение на различие версий.
/* (select count(*) from (select initiator_user_id from friend_requests where target_user_id = u.id and status = 'approved'
 		union
 	select target_user_id from friend_requests where initiator_user_id = u.id and status = 'approved') as fr_list) as 'friends', */

select 
	id,
	firstname,
	lastname,
	hometown,
	(select filename from photos where id = u.photo_id) as personal_photo,
	(select count(initiator_user_id) from friend_requests where target_user_id = u.id and status = 'approved')
	+
	(select count(target_user_id) from friend_requests where initiator_user_id = u.id and status = 'approved') as cnt_friends,
	(select count(1) from friend_requests where status = 'approved'
		and (target_user_id = u.id or initiator_user_id = u.id)) as cnt_friends2,
	(select count(*) from friend_requests where target_user_id = u.id and status ='requested') as cnt_followers,
	(select count(*) from photos where user_id = u.id) cnt_photos
from users as u 
-- where id = 2
;


-- Получить id друзей пользователя
select 
	case (1)
		when initiator_user_id then target_user_id
		when target_user_id then initiator_user_id
	end friends_id
from friend_requests fr
where status = 'approved'
	and (target_user_id = 1 or initiator_user_id = 1)
;