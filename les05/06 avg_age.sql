select 
	avg(timestampdiff(year,u.birthday_at,NOW())) as avg_age
from users u 
;