-- ДЗ 1п.

alter table friend_requests change column status status enum('requested', 'approved', 'unfriended', 'declined') default 'requested';

alter table users change column create_at created_at datetime default now();

-- Почему не работает?
-- alter table users RENAME COLUMN create_at TO created_at;

-- ДЗ 2п.
-- Я сделал на уроке 3.
-- Скрипт fill_db приложу еще раз.

-- ДЗ 4п.
-- Примером для курсовой я выбрал сайт объявлений Avito.ru