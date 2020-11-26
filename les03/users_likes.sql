-- drop database if exists snet0611;
-- create database if not exists snet0611 character set = utf8mb4;
-- use snet0611;

drop table if exists like_types;
create table like_types(
	id smallint unsigned not null auto_increment unique primary key,
	like_type_name varchar(200)
	-- is_deleted bool,
	-- deleted_at datetime
);

insert into like_types (like_type_name) values ('users');
insert into like_types (like_type_name) values ('photos');
insert into like_types (like_type_name) values ('posts');
insert into like_types (like_type_name) values ('comments');
commit;

drop table if exists user_likes;
create table user_likes(
	user_id bigint unsigned not null,
	like_type_id smallint unsigned not null,
	external_id bigint unsigned not null,
	is_liked bool default 1,
	updated_at datetime default current_timestamp on update current_timestamp,
	primary key (user_id, like_type_id, external_id),
	foreign key (like_type_id) references like_types(id)
);

alter table user_likes add index (like_type_id,external_id);