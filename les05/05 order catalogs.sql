select *
from catalogs c 
where id IN (5, 1, 2)
order by FIELD(id,5,1,2) 
;