select 
	ROUND( EXP (sum(LN (c.id)))) p
from catalogs c 
;