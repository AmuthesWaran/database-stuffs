CREATE DATABASE assignment;

USE assignment;


--Create the tables for Note, Category, Reminder, User, UserNote, NoteReminder and NoteCategory.


--User table fields: user_id, user_name, user_added_date, user_password, user_mobile

CREATE TABLE user(user_id INT PRIMARY KEY AUTO_INCREMENT, user_name VARCHAR(30) NOT NULL, user_added_date DATE NOT NULL, user_password VARCHAR(20) NOT NULL, user_mobile INT(10) NOT NULL);

DESC user;

INSERT INTO user VALUES
(101, 'Ammu', '2020-12-12', 'password123', 745896321),
(102, 'Aravind', '2021-01-31', 'arav123', 745896322),
(103, 'Arul', '2021-04-30', 'arul@123', 745896323),
(104, 'Arun', '2022-03-21', 'arun123', 745896324),
(105, 'Akshay', '2021-08-15', 'aks123', 745896325);

SELECT * FROM user;


--Note table fields: note_id, note_title, note_content, note_status, note_creation_date

CREATE TABLE note(note_id INT PRIMARY KEY AUTO_INCREMENT, note_title varchar(30) NOT NULL, note_content TEXT, note_status VARCHAR(15), note_creation_date DATE NOT NULL);

DESC note;

INSERT INTO note VALUES
(201, 'Frontend Courses', 'HTML, CSS, Bootstrap, JS, ReactJS', 'Completed', '2022-08-08'),
(202, 'Backend Courses', 'Java, Spring, Springboot', 'Under Progress', '2022-08-21'),
(203, 'Assignments', 'DBMS, Java Spring', 'Pending', '2022-10-19'),
(204, 'SpringBoot Revision', 'All Spring and SpringBoot Projects', 'Pending', '2022-10-21'),
(205, 'Final Project', 'Course outcome', 'Pending', '2022-10-22');

SELECT * FROM note;


--Category table fields : category_id, category_name, category_descr, category_creation_date, category_creator

CREATE TABLE category(category_id INT PRIMARY KEY AUTO_INCREMENT, category_name VARCHAR(25), category_descr TEXT, category_creation_date DATE, category_creator VARCHAR(30) NOT NULL);
DESC category;


INSERT INTO category VALUES
(301,'study','study related item','2020-12-21','Ammu'),
(302,'movies','movie retated item','2021-02-03','Aravind'),
(303,'tv shows','TV show retated item','2021-05-05','Arul'),
(304,'Holidays','holiday retated item','2021-04-14','Arun'),
(305,'purchase','purchase retated item','2021-09-11','Akshay');

SELECT * FROM category;

--Reminder table fields : reminder_id, reminder_name, reminder_descr, reminder_type, reminder_creation_date, reminder_creator

CREATE TABLE reminder(reminder_id INT PRIMARY KEY AUTO_INCREMENT, reminder_name VARCHAR(30), reminder_descr TEXT, reminder_type VARCHAR(15), reminder_creation_date DATE, reminder_creator VARCHAR(30) NOT NULL);

desc reminder;

INSERT INTO reminder VALUES
(401,'TV show','Tv show release date','level-3','2022-01-04','Ammu'),
(402,'Movie','movie release date','level-3','2022-09-30','Aravind'),
(403,'Springboot Revision','revise all the spring boot concepts','level-1','2022-10-29','Arul'),
(404,'Backend','finish all the backend tasks','level-1','2022-11-30','Arun'),
(405,'Final project','Course final project','level-3','2022-12-23','Akshay');

SELECT * FROM reminder;

--NoteCategory table fields : notecategory_id, note_id, category_id
CREATE TABLE notecategory(notecategory_id INT PRIMARY KEY AUTO_INCREMENT, note_id INT, category_id INT, FOREIGN KEY(note_id) REFERENCES note(note_id),FOREIGN KEY(category_id) REFERENCES category(category_id));

DESC notecategory;

INSERT INTO notecategory VALUES 
(1,201,302),
(2,202,301),
(3,202,302),
(4,204,303),
(5,203,304),
(6,205,301),
(7,201,305);

SELECT * FROM notecategory;

--Notereminder table fields : notereminder_id, note_id, reminder_id
CREATE TABLE notereminder(notereminder_id INT PRIMARY KEY AUTO_INCREMENT, note_id INT, reminder_id INT, FOREIGN KEY(note_id) REFERENCES note(note_id), FOREIGN KEY(reminder_id) REFERENCES reminder(reminder_id));

desc notereminder;

INSERT INTO notereminder VALUES
(501,201,403),
(502,202,405),
(503,205,404),
(504,203,402),
(505,201,405),
(506,202,403),
(507,204,401);

SELECT * FROM notereminder;


--usernote table fields : usernote_id, user_id, note_id

CREATE TABLE usernote(usernote_id INT PRIMARY KEY AUTO_INCREMENT, note_id INT, user_id INT, FOREIGN KEY(note_id) REFERENCES note(note_id),FOREIGN KEY(user_id) REFERENCES user(user_id));

desc usernote;

INSERT INTO usernote VALUES
(601,203,102),
(602,204,103),
(603,202,101),
(604,201,105),
(605,202,104),
(606,203,105),
(607,202,104);

SELECT * FROM usernote;

SHOW TABLES;

--Fetch the row from User table based on Id and Password.
SELECT * FROM user WHERE user_id=101 AND user_password='password123';
SELECT * FROM user WHERE user_id=101 OR user_password='password123';

--Fetch all the rows from Note table based on the field note_creation_date.
SELECT * FROM note WHERE note_creation_date='2022-08-21';
SELECT * FROM note WHERE note_creation_date IN('2022-08-08','2022-10-19','2022-10-22');

--Fetch all the Categories created after the particular Date.
SELECT * FROM category WHERE category_creation_date >= '2021-05-05';


--Fetch all the Note ID from UserNote table for a given User.
SELECT note_id FROM UserNote WHERE user_id = 101;
SELECT note_id FROM UserNote WHERE user_id IN(101,102);
SELECT note_id FROM UserNote WHERE user_id=(SELECT user_id FROM user WHERE user_name='Arun');

--Write Update query to modify particular Note for the given note Id.
UPDATE note SET note_title = 'Backend Assignments' WHERE note_id=203;
UPDATE note SET note_title = 'SpringBoot and DBMS Revision' , note_status = 'Under Progress' where note_id=204;



--Fetch all the Notes from the Note table by a particular User.
SELECT * FROM note WHERE note_id IN ( SELECT note_id FROM UserNote WHERE user_id=104);
SELECT * FROM note WHERE note_id IN ( SELECT note_id FROM UserNote WHERE user_id=(select user_id from User where user_name='ammu'));


--Fetch all the Notes from the Note table for a particular Category.
SELECT * FROM Note WHERE note_id IN (SELECT note_id FROM NoteCategory WHERE category_id=301);
SELECT * FROM Note WHERE note_id IN (SELECT note_id FROM NoteCategory WHERE category_id=(SELECT category_id FROM Category WHERE category_name='holidays'));
SELECT * FROM Note WHERE note_id IN (SELECT note_id FROM NoteCategory WHERE category_id=(SELECT category_id FROM Category WHERE category_name='study'));


--Fetch all the reminder details for a given note id.
SELECT * FROM  Reminder WHERE reminder_id IN (SELECT reminder_id FROM NoteReminder WHERE note_id=201);
SELECT * FROM  Reminder WHERE reminder_id IN (SELECT reminder_id FROM NoteReminder WHERE note_id=205);


--Fetch the reminder details for a given reminder id.
SELECT * FROM Reminder WHERE reminder_id IN (404,401);


--Write a query to create a new Note from particular User (Use Note and UserNote tables - insert statement).
INSERT INTO User(`user_name`,`user_added_date`,`user_password`,`user_mobile`)  VALUES ( "nisha", "2022-10-22", "nish@123", "42561584");
INSERT INTO UserNote(note_id, user_id) VALUES (203,last_insert_id());


--Write a query to create a new Note from particular User to particular Category(Use Note and NoteCategory tables - insert statement)
INSERT INTO Note(`note_title`,`note_content`,`note_status`,`note_creation_date`)  VALUES( "GitHub Projects", "To upload all the personal project", "pending", "2022-10-14");
INSERT INTO NoteCategory(note_id, category_id) VALUES(last_insert_id(), 305);

--Write a query to set a reminder for a particular note (Use Reminder and NoteReminder tables - insert statement)
INSERT INTO Reminder (`reminder_name`,`reminder_descr`,`reminder_type`,`reminder_creation_date`,`reminder_creator`)  VALUES("cycling", "Cycling early in the morning", "level-2", "2022-07-08", "nisha");
INSERT INTO Notereminder (`note_id`,`reminder_id`) VALUES(203,last_insert_id());

--Write a query to delete particular Note added by a User(Note and UserNote tables - delete statement)
DELETE FROM UserNote WHERE user_id=105 AND note_id=203;
DELETE FROM User WHERE user_id=105;
DELETE FROM Note WHERE note_id=203;


--Write a query to delete particular Note from particular Category(Note and NoteCategory tables - delete statement)
DELETE FROM NoteCategory WHERE category_id=304 and note_id=203;
DELETE FROM NoteReminder WHERE note_id = 203;
DELETE FROM Note WHERE note_id=203;


Create a trigger to delete all matching records from UserNote, NoteReminder and NoteCategory table when :
1. A particular note is deleted from Note table (all the matching records from UserNote, NoteReminder and NoteCategory should be removed automatically)

DELIMITER //
CREATE TRIGGER del_note before delete on Note FOR EACH ROW Begin delete from UserNote where note_id=old.note_id; DELETE FROM Notereminder WHERE note_id=old.note_id; delete from NoteCategory where note_id=old.note_id; END; //
DELIMITER ;

DELETE FROM Note WHERE note_id=204;
DELETE FROM Note WHERE note_id=205;

2. A particular user is deleted from User table (all the matching notes should be removed automatically)
DELIMITER //
CREATE TRIGGER del_user before delete on User FOR EACH ROW Begin delete from UserNote where note_id=old.user_id;
delete from NoteReminder where note_id=old.user_id;  delete from Category where category_creator=old.user_id;  
delete from NoteCategory where note_id=old.user_id;  END; //
DELIMITER ;

DELETE FROM User where user_id=103;