create database if not exists example;

use example;

create table `product_info`(
	product_id int,
    product_name varchar(100),
    category char(10),
    price decimal(10, 2),
    in_stock boolean,
    realease_date date,
    color enum('red', 'green', 'blue')
);

insert into `product_info` values (
 '??? 모름', 'Galaxy Watch', 'Device', 299.99, true, '2024-06-01', 'green'
);