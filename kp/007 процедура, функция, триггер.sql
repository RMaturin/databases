DELIMITER //

DROP PROCEDURE IF EXISTS cnt_not_read_massages//

CREATE PROCEDURE cnt_not_read_massages (user_id BIGINT)
BEGIN
select count(1) as cnt_not_read_massages from messages where to_user_id=user_id and is_read=0;
END//


DROP FUNCTION IF EXISTS get_rating//

CREATE FUNCTION get_rating (u_id BIGINT)
RETURNS DECIMAL(3,2)
BEGIN
	
DECLARE V_RES DECIMAL(3,2) DEFAULT 0;

SET V_RES = 
	(
	select avg(rating)
	from reviews 
	where seller_id=u_id 
	group by seller_id
	);
RETURN V_RES;
	
END//

DROP TRIGGER IF EXISTS check_rating_ins//

CREATE TRIGGER check_rating_ins BEFORE INSERT ON reviews
FOR EACH ROW 
BEGIN
IF (NEW.rating < 1 or NEW.rating > 5) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The field can take values ​​from 1 to 5';
END IF;
END//

DROP TRIGGER IF EXISTS check_rating_upd//

CREATE TRIGGER check_rating_upd BEFORE UPDATE ON reviews
FOR EACH ROW 
BEGIN
IF (NEW.rating < 1 or NEW.rating > 5) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The field can take values ​​from 1 to 5';
END IF;
END//

DELIMITER ;

-- Проверяем работу

CALL cnt_not_read_massages(12);


select get_rating(9);


Select 
	u.id,
	u.name,
	u.user_type,
	IFNULL(get_rating(u.id),0) as rating
from users u
order by rating desc
;

INSERT INTO reviews (seller_id,ad_id,author_user_id,rating,comment) VALUES (1,NULL,22,10,'10 баллов');

UPDATE reviews SET rating=10, comment='10 баллов'
WHERE id=83;

UPDATE reviews SET rating=0, comment='0 баллов'
WHERE id=83;

