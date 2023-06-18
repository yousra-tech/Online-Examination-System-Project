CREATE TABLE Topic (
    Top_id int Primary Key,
    Top_Name varchar(30) 
);

CREATE TABLE Course (
    Crs_ID int Primary Key,
    Crs_Name varchar(50),
    Credit_Hours int CHECK (Credit_Hours >= 1 and Credit_Hours <= 4),
    Semester varchar(20) CHECK (Semester in ('Spring', 'Fall', 'Summer')),
    Top_ID int,
    FOREIGN KEY (Top_ID) REFERENCES Topic(Top_id)
);
USE back1
Create Table Exam (
Ex_id int Primary Key,
Ex_name varchar(50),
Duration_mins int CHECK ( Duration_mins >=30 and Duration_mins <=120),
no_of_questions int CHECK (no_of_questions > 0)
);

ALTER TABLE dbo.Exam
ADD Crs_id INT
FOREIGN KEY (crs_id) REFERENCES dbo.Course(Crs_ID)

ALTER TABLE dbo.Exam
DROP CONSTRAINT CK__Exam__Duration_m__74AE54BC

CREATE Table Question (
Q_ID int Primary Key,
Q_type varchar(20) CHECK (Q_type in ('MCQ','T/F')) ,
Q_text varchar(200) Not Null,
Q_Grade int Not Null CHECK (Q_Grade = 1),
Right_Answer varchar(20) CHECK (Right_Answer in ('a','b','c','True','False')) ,
crs_id int,
Foreign Key (crs_id) REFERENCES Course(Crs_ID) 
);

ALTER TABLE dbo.Question
DROP CONSTRAINT CK__Question__Right___01142BA1
go
ALTER TABLE dbo.Question
ADD CONSTRAINT CK__Question__Right CHECK (Right_Answer IN ('a','b','c','d'))
go
ALTER TABLE dbo.Question
ALTER COLUMN Q_text VARCHAR(500)

Create Table Exam_Crs(
Ex_id int ,
crs_id int,
Foreign Key (Ex_id) REFERENCES Exam(Ex_id),
Foreign Key (crs_id) REFERENCES Course(Crs_ID), 
CONSTRAINT Ex_crs PRIMARY KEY(Ex_id, crs_id) 
);

CREATE TABLE Department
(
Dept_ID INT PRIMARY KEY,
Dept_Name VARCHAR(50) NOT NULL,
Dept_Mgr INT 
)

CREATE TABLE Instructor
(
Ins_ID INT PRIMARY KEY,
Ins_Name VARCHAR(50) NOT NULL,
Evaluation DECIMAL CHECK (Evaluation > 0 AND Evaluation < 10),
Salary SMALLMONEY CHECK (Salary >= 5000),
Phone_NUM VARCHAR(11) CHECK (Phone_NUM like '01[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
username varchar(50),
password varchar(20),
dep_id INT,
FOREIGN KEY (dep_id) REFERENCES Department(Dept_ID)
)

 ALTER TABLE Department
 ADD CONSTRAINT FK_mgr FOREIGN KEY (Dept_Mgr) REFERENCES Instructor(Ins_ID)
 ON DELETE CASCADE
 ON UPDATE CASCADE

 CREATE TABLE Student 
(st_id int PRIMARY KEY, fname varchar(20), lname varchar(20),
phone int, city varchar(50), age int CHECK (age>=18 and age<=50), 
gender varchar(1) CHECK (gender in ('F','M')), grad_date date, username varchar(50),
password varchar(20), dept_id int,
FOREIGN KEY (dept_id) REFERENCES department(dept_id)
)

ALTER TABLE dbo.Student
ALTER COLUMN phone VARCHAR(11)


ALTER TABLE dbo.Student
ADD CONSTRAINT CH_Phone CHECK (phone like '01[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')

 CREATE TABLE FullTimeJob
 (full_id int, company_name varchar(50),
  job_title varchar(30),
  salary smallmoney, hiring_date date, 
  employment_type varchar(20) CHECK(employment_type in ('Full Time','Part Time')),st_id int,
  CONSTRAINT PK_full PRIMARY KEY (full_id, st_id),
  CONSTRAINT FK_Full FOREIGN KEY (st_id) REFERENCES student(st_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE
  );


  CREATE TABLE Freelancing
 (free_id int, title varchar(50), 
 free_platform varchar(20) CHECK(free_platform in('upwork','fevver','khamsat','mostaqel','freelancer')), 
 contract_type varchar(20) CHECK (contract_type in ('Per Task','Per Hour','Per Project')),
 contract_date date, salary smallmoney, currency varchar(10), st_id int,
 CONSTRAINT PK_Free PRIMARY KEY (free_id, st_id),
 CONSTRAINT FK_Free FOREIGN KEY (st_id) REFERENCES student(st_id)
 ON DELETE CASCADE
 ON UPDATE CASCADE
 )

 CREATE TABLE Certificats 
 (cer_id int, cer_name varchar(50), descriptions varchar(100), cer_url varchar(50),
  cer_platform varchar(20), pre_request varchar(100),
  st_id INT,
  CONSTRAINT PK_Cer PRIMARY KEY (cer_id, st_id),
  CONSTRAINT fk_Cer FOREIGN KEY (st_id) REFERENCES student(st_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE
  )

ALTER TABLE dbo.Certificats
ALTER COLUMN cer_name VARCHAR(100)

ALTER TABLE dbo.Certificats
ALTER COLUMN descriptions VARCHAR(300)

ALTER TABLE dbo.Certificats
ALTER COLUMN cer_url VARCHAR(150)


ALTER TABLE dbo.Certificats
ALTER COLUMN cer_platform VARCHAR(100)

ALTER TABLE dbo.Certificats
ALTER COLUMN pre_request VARCHAR(250)


CREATE TABLE Stud_Crs(st_id int, crs_id int,
PRIMARY KEY (st_id, crs_id),
FOREIGN KEY (st_id) REFERENCES student(st_id)
ON UPDATE CASCADE
ON DELETE CASCADE,
FOREIGN KEY (crs_id) REFERENCES course(Crs_ID)
ON UPDATE CASCADE
ON DELETE CASCADE,
)

CREATE TABLE Ins_Crs
( inst_id int, crs_id int,
PRIMARY KEY (inst_id, crs_id),
FOREIGN KEY (inst_id) REFERENCES instructor(ins_id)
ON UPDATE CASCADE
ON DELETE CASCADE,
FOREIGN KEY (crs_id) REFERENCES course(Crs_ID)
ON UPDATE CASCADE
ON DELETE CASCADE,
)
USE back1
ALTER TABLE dbo.Exam_Ques_Stud
DROP CONSTRAINT CK__Exam_Ques__st_an__76969D2E

ALTER TABLE dbo.Exam_Ques_Stud
ADD CHECK (st_Answer in ('a','b','c','d'))

ALTER TABLE dbo.Exam_Ques_Stud
DROP CONSTRAINT CK__Exam_Ques__st_gr__778AC167

CREATE TABLE Exam_Ques_Stud
(st_id int, ex_id int, Q_id int, 
st_answer varchar(30) CHECK (st_Answer in ('a','b','c','True','False')), 
st_grade int CHECK (st_Grade = 1),
PRIMARY KEY (st_id, ex_id, Q_id),
FOREIGN KEY (st_id) REFERENCES student(st_id)
ON UPDATE CASCADE
ON DELETE CASCADE,
FOREIGN KEY (ex_id) REFERENCES exam(ex_id)
ON UPDATE CASCADE
ON DELETE CASCADE,
FOREIGN KEY (Q_id) REFERENCES question(Q_id)
ON UPDATE CASCADE
ON DELETE CASCADE
)