CREATE DATABASE IF NOT EXISTS `springboot_db`;

USE `springboot_db`;

-- test 테이블 --
CREATE TABLE IF NOT EXISTS test (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(50) NOT NULL
);
SELECT * FROM test;

-- student 테이블 --
CREATE TABLE student (
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

SELECT * FROM student;

-- book 테이블 --

CREATE TABLE book (
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    writer VARCHAR(50) NOT NULL,
    tltle VARCHAR(100) NOT NULL,
    content VARCHAR(500) NOT NULL,
    category VARCHAR(255) NOT NULL,
    CONSTRAINT chk_category CHECK (category IN ('NOVEL', 'ESSAY', 'POEM', 'MAGAZINE'))
);

SELECT * FROM book;

-- post(게시물) 테이블 --
CREATE TABLE IF NOT EXISTS posts (
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content VARCHAR(255) NOT NULL,
    author VARCHAR(255) not null
);

-- comment(댓글) 테이블 --
CREATE TABLE IF NOT EXISTS comment (
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    post_id BIGINT,
    content VARCHAR(255) NOT NULL,
    commenter VARCHAR(255) NOT NULL,
    FOREIGN KEY (post_id) REFERENCES post(id) ON DELETE CASCADE
);

SELECT * FROM post;
SELECT * FROM comment;