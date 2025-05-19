create database baseball_league;

use baseball_league;

create table `teams` (
	team_id int,
    name varchar(100),
    city varchar(100),
    founded_year year
);

create table `players` (
	player_id int,
    name varchar(100),
    position enum('타자', '투수', '내야수', '외야수')
);

alter table `players` add column birth_date date;

describe teams;
describe players;

drop table if exists `players`;
drop table if exists `games`;

drop database baseball_league;