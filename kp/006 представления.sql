CREATE VIEW apartments AS
select 
	a.headline,
	a.town,
	a.price,
	ch1.number_value as cnt_rooms,
	round(ch2.decimal_value,1) as area,
	ch3.number_value as floor_num,
	ch4.flag_value as balcon,
	ch5.flag_value as elevator,
	ch6.string_value as kadast_num,
	a.description
from ads a 
	left join ad_characteristics ch1 on (a.id=ch1.ad_id and ch1.charact_type_id=1)
	left join ad_characteristics ch2 on (a.id=ch2.ad_id and ch2.charact_type_id=2)
	left join ad_characteristics ch3 on (a.id=ch3.ad_id and ch3.charact_type_id=4)
	left join ad_characteristics ch4 on (a.id=ch4.ad_id and ch4.charact_type_id=3)
	left join ad_characteristics ch5 on (a.id=ch5.ad_id and ch5.charact_type_id=5)
	left join ad_characteristics ch6 on (a.id=ch6.ad_id and ch6.charact_type_id=6)
where a.category_id=11
	and a.status='published'
;

select *
from apartments
;

CREATE VIEW cars AS
select 
	a.headline,
	a.town,
	a.price,
	ch1.string_value as brand,
	ch2.string_value as model,
	ch3.string_value as VIN,
	ch4.number_value as create_year,
	round(ch5.decimal_value,1) as engine_volume,
	ch6.flag_value as abs_flg,
	a.description
from ads a 
	left join ad_characteristics ch1 on (a.id=ch1.ad_id and ch1.charact_type_id=7)
	left join ad_characteristics ch2 on (a.id=ch2.ad_id and ch2.charact_type_id=8)
	left join ad_characteristics ch3 on (a.id=ch3.ad_id and ch3.charact_type_id=9)
	left join ad_characteristics ch4 on (a.id=ch4.ad_id and ch4.charact_type_id=11)
	left join ad_characteristics ch5 on (a.id=ch5.ad_id and ch5.charact_type_id=13)
	left join ad_characteristics ch6 on (a.id=ch6.ad_id and ch6.charact_type_id=12)
where a.category_id=18
	and a.status='published'
;

select *
from cars
;
