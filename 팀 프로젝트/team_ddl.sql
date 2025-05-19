
-- 1) 데이터베이스 생성 및 선택
CREATE DATABASE IF NOT EXISTS school_management;
USE school_management;

-- 2) 학교 정보 테이블
CREATE TABLE School (
    school_id INT PRIMARY KEY,
    school_address VARCHAR(50) NOT NULL,
    school_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3) 관리자 정보 테이블
CREATE TABLE Admin (
    admin_id VARCHAR(30) PRIMARY KEY,
    school_id INT NOT NULL,
    teacher_name VARCHAR(10) NOT NULL,
    lecture_status ENUM('수업 중', '공강') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (school_id) REFERENCES School (school_id)
);

-- 4) 과목 테이블
CREATE TABLE Subject (
    subject_id VARCHAR(30) PRIMARY KEY,
    school_id INT NOT NULL,
    subject_name VARCHAR(30) NOT NULL,
    grade VARCHAR(10) NOT NULL,
    semester VARCHAR(10) NOT NULL,
    category VARCHAR(10) NOT NULL,
    max_enrollment INT DEFAULT 30,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (school_id) REFERENCES School (school_id)
);

-- 5) 학생 정보 테이블
CREATE TABLE Student (
    student_id VARCHAR(30) PRIMARY KEY,
    school_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    birth_date DATE NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    status ENUM('재학','휴학','졸업','지퇴') NOT NULL,
    student_grade INT NOT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (school_id) REFERENCES School (school_id)
);

-- 6) 학생-과목 매핑 테이블
CREATE TABLE Student_subject (
    student_id VARCHAR(30) NOT NULL,
    subject_id VARCHAR(30) NOT NULL,
    grade VARCHAR(10) NOT NULL,
    affiliation ENUM('인문계열', '자연계열') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES Student (student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject (subject_id)
);

-- 7) 관리자-과목 매핑 테이블
CREATE TABLE Admin_subject (
    admin_id VARCHAR(30) NOT NULL,
    subject_id VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (admin_id, subject_id),
    FOREIGN KEY (admin_id) REFERENCES Admin (admin_id),
    FOREIGN KEY (subject_id) REFERENCES Subject (subject_id)
);

-- 8) 로그인 시도 기록 테이블
CREATE TABLE LoginAttempt (
    attempt_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_id VARCHAR(30),
    student_id VARCHAR(30),
    success BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES Admin (admin_id),
    FOREIGN KEY (student_id) REFERENCES Student (student_id)
);

-- 9) 수강 신청 이력 테이블
CREATE TABLE Application_for_classes (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    application_date DATE NOT NULL,
    student_id VARCHAR(30) NOT NULL,
    subject_id VARCHAR(30) NOT NULL,
    status ENUM('대기', '승인', '취소') DEFAULT '대기',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Student (student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject (subject_id)
);

-- 10) 공지사항 테이블
CREATE TABLE Notice (
    notice_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    writer VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 11) 강의실 테이블
CREATE TABLE Classroom (
    classroom_id INT AUTO_INCREMENT PRIMARY KEY,
    room_name VARCHAR(30) NOT NULL,
    capacity INT DEFAULT 30,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 12) 수강 제한 테이블
CREATE TABLE CourseRestriction (
    restriction_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id VARCHAR(30) NOT NULL,
    min_grade INT NOT NULL,
    max_grade INT NOT NULL,
    is_duplicate_allowed BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (subject_id) REFERENCES Subject (subject_id)
);

-- 13) 수강 이력 테이블
CREATE TABLE CourseHistory (
    student_id VARCHAR(30) NOT NULL,
    subject_id VARCHAR(30) NOT NULL,
    semester VARCHAR(10) NOT NULL,
    year INT NOT NULL,
    teacher_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (student_id, subject_id, semester, year),
    FOREIGN KEY (student_id) REFERENCES Student (student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject (subject_id)
);

-- 14) 수강 신청 기록 테이블
CREATE TABLE CourseRegistration (
    student_id VARCHAR(30) NOT NULL,
    subject_id VARCHAR(30) NOT NULL,
    semester VARCHAR(10) NOT NULL,
    year INT NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (student_id, subject_id, semester, year),
    FOREIGN KEY (student_id) REFERENCES Student (student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject (subject_id)
);

-- 15) 시간표 테이블
CREATE TABLE Schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id VARCHAR(30) NOT NULL,
    day_of_week VARCHAR(10) NOT NULL,
    start_period INT NOT NULL,
    end_period INT NOT NULL,
    classroom VARCHAR(30) NOT NULL,
    teacher VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (subject_id) REFERENCES Subject (subject_id)
);

-- 16) 학생 회원가입 테이블
CREATE TABLE Student_Register (
    student_id VARCHAR(30) PRIMARY KEY,                       -- 학생아이디
    school_id INT NOT NULL,                                   -- 학교아이디
    name VARCHAR(50) NOT NULL,                                -- 학생이름
    phone_number VARCHAR(20) NOT NULL,                        -- 휴대폰번호
    birth_date DATE NOT NULL,                                 -- 생년월일
    password VARCHAR(100) NOT NULL,                           -- 비밀번호
    email VARCHAR(50) UNIQUE NOT NULL,                        -- 이메일
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,           -- 생성일시
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 수정일시
    FOREIGN KEY (school_id) REFERENCES School(school_id)      -- 학교 FK
);

-- 17) 정보 수정 이력 테이블
CREATE TABLE Student_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,                -- 이력아이디
    student_id VARCHAR(30) NOT NULL,                          -- 학생아이디
    change_type ENUM('등록','수정','삭제') NOT NULL,          -- 변경유형
    name VARCHAR(50),                                         -- 변경 이름
    phone_number VARCHAR(20),                                 -- 변경 번호
    birth_date DATE,                                          -- 변경 생일
    password VARCHAR(100),                                    -- 변경 비밀번호
    email VARCHAR(50),                                        -- 변경 이메일
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,           -- 변경일시
    FOREIGN KEY (student_id) REFERENCES Student_Register(student_id) -- 학생 FK
);

