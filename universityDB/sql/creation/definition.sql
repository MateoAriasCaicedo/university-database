DROP DATABASE IF EXISTS universityDB;
CREATE DATABASE universityDB;
USE universityDB;

-- Tables:
CREATE TABLE Student
(
    ID         INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name  VARCHAR(255),
    birth_date DATE
);

CREATE TABLE Student_Email
(
    student_ID INT,
    email      VARCHAR(255) NOT NULL,
    PRIMARY KEY (student_ID, email)
);

CREATE TABLE Student_Phone_Number
(
    student_ID   INT,
    phone_number CHAR(10) NOT NULL,
    PRIMARY KEY (student_ID, phone_number)
);

CREATE TABLE Student_Address
(
    ID          INT,
    student_ID  INT,
    description VARCHAR(255) NOT NULL,
    zip_code    VARCHAR(10),
    city        VARCHAR(255) NOT NULL,
    country     VARCHAR(255) NOT NULL,
    locality    VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID, student_ID)
);

CREATE TABLE Student_Emergency_Contact
(
    student_ID   INT,
    first_name   VARCHAR(255) NOT NULL,
    last_name    VARCHAR(255) NOT NULL,
    email        VARCHAR(255) NOT NULL,
    phone_number CHAR(10)     NOT NULL,
    PRIMARY KEY (student_ID, first_name, last_name)
);

CREATE TABLE Career
(
    ID            INT PRIMARY KEY,
    name          VARCHAR(255) NOT NULL UNIQUE,
    semesters     INT          NOT NULL,
    cost          DOUBLE       NOT NULL,
    total_credits INT          NOT NULL
);

CREATE TABLE Course
(
    ID                INT PRIMARY KEY,
    department_ID     INT,
    name              VARCHAR(255) NOT NULL UNIQUE,
    credits           INT          NOT NULL,
    approbation_grade INT          NOT NULL,
    format            VARCHAR(50)
);

CREATE TABLE Career_Course
(
    course_ID INT,
    career_ID INT,
    PRIMARY KEY (course_ID, career_ID)
);

CREATE TABLE Career_Inscription
(
    career_ID        INT,
    student_ID       INT,
    inscription_date DATE,
    PRIMARY KEY (career_ID, student_ID)
);

CREATE TABLE Department
(
    ID            INT PRIMARY KEY,
    name          VARCHAR(255) NOT NULL,
    creation_date DATE
);

CREATE TABLE Teacher
(
    ID         INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name  VARCHAR(255),
    birth_date DATE,
    wage       DOUBLE       NOT NULL
);

CREATE TABLE Teacher_Email
(
    teacher_ID INT,
    email      VARCHAR(255) NOT NULL,
    PRIMARY KEY (teacher_ID, email)
);

CREATE TABLE Teacher_Phone_Number
(
    teacher_ID   INT,
    phone_number CHAR(10) NOT NULL,
    PRIMARY KEY (teacher_ID, phone_number)
);

CREATE TABLE Teacher_Department
(
    teacher_ID    INT,
    department_ID INT,
    PRIMARY KEY (teacher_ID, department_ID)
);

CREATE TABLE Course_Season
(
    course_season_ID INT PRIMARY KEY,
    course_ID        INT NOT NULL,
    year             INT NOT NULL,
    semester         INT NOT NULL,
    CONSTRAINT unique_course_season UNIQUE (course_ID, year, semester)
);

CREATE TABLE Student_Course_Season
(
    student_ID       INT,
    course_season_ID INT,
    final_grade      FLOAT,
    PRIMARY KEY (student_ID, course_season_ID)
);

CREATE TABLE Teacher_Course_Season
(
    teacher_ID       INT,
    course_season_ID INT,
    PRIMARY KEY (teacher_ID, course_season_ID)
);

-- Relationships:
ALTER TABLE Student_Email
    ADD FOREIGN KEY (student_ID) REFERENCES Student (ID);

ALTER TABLE Student_Phone_Number
    ADD FOREIGN KEY (student_ID) REFERENCES Student (ID);

ALTER TABLE Student_Address
    ADD FOREIGN KEY (student_ID) REFERENCES Student (ID);

ALTER TABLE Student_Emergency_Contact
    ADD FOREIGN KEY (student_ID) REFERENCES Student (ID);

ALTER TABLE Career_Course
    ADD FOREIGN KEY (career_ID) REFERENCES Career (ID);

ALTER TABLE Career_Course
    ADD FOREIGN KEY (course_ID) REFERENCES Course (ID);

ALTER TABLE Career_Inscription
    ADD FOREIGN KEY (student_ID) REFERENCES Student (ID);

ALTER TABLE Career_Inscription
    ADD FOREIGN KEY (career_ID) REFERENCES Career (ID);

ALTER TABLE Course
    ADD FOREIGN KEY (department_ID) REFERENCES Department (ID);

ALTER TABLE Teacher_Email
    ADD FOREIGN KEY (teacher_ID) REFERENCES Teacher (ID);

ALTER TABLE Teacher_Phone_Number
    ADD FOREIGN KEY (teacher_ID) REFERENCES Teacher (ID);

ALTER TABLE Teacher_Department
    ADD FOREIGN KEY (teacher_ID) REFERENCES Teacher (ID);

ALTER TABLE Teacher_Department
    ADD FOREIGN KEY (department_ID) REFERENCES Department (ID);

ALTER TABLE Course_Season
    ADD FOREIGN KEY (course_ID) REFERENCES Course (ID);

ALTER TABLE Student_Course_Season
    ADD FOREIGN KEY (student_ID) REFERENCES Student (ID);

ALTER TABLE Student_Course_Season
    ADD FOREIGN KEY (course_season_ID) REFERENCES Course_Season (course_season_ID);

ALTER TABLE Teacher_Course_Season
    ADD FOREIGN KEY (teacher_ID) REFERENCES Teacher (ID);

ALTER TABLE Teacher_Course_Season
    ADD FOREIGN KEY (course_season_ID) REFERENCES Course_Season (course_season_ID);
