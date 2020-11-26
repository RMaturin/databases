select 
	u.*
from users u
where MONTHNAME(u.birthday_at) in ('may', 'august')
;

-- В MySQL при сровнении значения строк не учитывается регистр?

select 
'Mariya'='Mariya',
'Mariya'='mariya',
'Mariya'='MARIYA',
'Mariya'='MaRiYa';

-- Как сделать чтобы он учитывался?