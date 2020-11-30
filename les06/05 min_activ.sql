-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.


select 
	firstname ,
	lastname,
	(cnt_posts+cnt_photos+cnt_msg+cnt_com+cnt_fr+cnt_ul) cnt_activ
from 
	(
	select 
		u.id ,
		u.firstname ,
		u.lastname,
		ifnull(p.cnt_posts,0) as cnt_posts,
		ifnull(ph.cnt_photos,0) as cnt_photos,
		ifnull(m.cnt_msg,0) as cnt_msg,
		ifnull(c.cnt_com,0) as cnt_com,
		ifnull(fr.cnt_fr,0) as cnt_fr,
		ifnull(ul.cnt_ul,0) as cnt_ul
	from users u 
		left join 
		(select p.user_id , count(*) cnt_posts from posts p group by p.user_id) p on (u.id=p.user_id)
		left join 
		(select ph.user_id , count(*) cnt_photos from photos ph group by ph.user_id) ph on (u.id=ph.user_id)
		left join 
		(select m.from_user_id as user_id , count(*) cnt_msg from messages m group by m.from_user_id) m on (u.id=m.user_id)
		left join 
		(select c.user_id , count(*) cnt_com from comments c group by c.user_id) c on (u.id=c.user_id)
		left join 
		(select fr.initiator_user_id as user_id, count(*) cnt_fr from friend_requests fr group by fr.initiator_user_id) fr on (u.id=fr.user_id)
		left join 
		(select ul.user_id , count(*) cnt_ul from user_likes ul group by ul.user_id) ul on (u.id=ul.user_id)
	) a
where (cnt_posts+cnt_photos+cnt_msg+cnt_com+cnt_fr+cnt_ul)>0
order by cnt_activ
limit 10
;
