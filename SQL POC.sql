create database sqlpoc;
use sqlpoc;
-- -------------------------------------------------------

create table author (
id int primary key,
name varchar(100) );

Insert into Author values(1,'Chetan Bhagat');
Insert into Author values(2,'James Bond');
Insert into Author values(3,'Arundhati Roy');
Insert into Author values(4,'Rhonda Byrne');

select *from author;
-- -------------------------------------------------------

create table post(
id int primary key,
name varchar(100),
authorid int references author(id),
createdts datetime );

Insert into post values(101,'The 3 Mistakes of My Life',1,'2008-1-1');
Insert into post values(102,'Diamonds Are Forever',2,'1971-12-14');
Insert into post values(103,'The God of Small Things',3,'1997-03-15');
Insert into post values(104,'The Secret',4,'2006-11-26');
Insert into post values(105,'From Russia with Love',2,'1963-10-10');

select *from post;
-- -------------------------------------------------------

create table comment (
id int primary key,
content varchar(1000),
postid int references post(id),
createdts datetime,
userid int references user(id) );

Insert into comment values(1001,'The story line is great and amazing',101,'2022-01-26 12:30:00',11);
Insert into comment values(1002,'It has the power to amusement like a real story',101,'2022-01-29 8:10:05',12);

Insert into comment values(1003,'The prose, writing style is something I had never seen',103,'2021-05-15 9:50:06',13);
Insert into comment values(1004,'I completely adore this book',103,'2022-01-13 4:05:55',11);

Insert into comment values(1005,'This book is a masterpiece in itself',104,'2010-02-16 10:10:00',12);
Insert into comment values(1006,'It speaks about positivity and also gives you hope and peace of mind.',104,'2016-09-28 11:26:40',14);

Insert into comment values(1007,'For me Diamonds are Forever is an adequate Bond film',102,'2018-05-13 4:05:05',11);
Insert into comment values(1008,'Diamonds Are Forever is one of the most popular Bond films of all time',102,'2018-12-03 01:00:05',12);
Insert into comment values(1009,'Great atmosphere linked with superb music from John Barry',102,'2017-05-19 9:05:35',14);
Insert into comment values(1010,'It is an enjoyable film lighthearted and fun',102,'2017-08-01 7:34:00',13);
Insert into comment values(1011,'Great movie, and as luck would have it',102,'2019-06-30 6:44:03',15);
Insert into comment values(1012,'Personally I quite enjoyed this one',102,'2019-09-09 5:39:04',16);
Insert into comment values(1013,'It is a pretty good story',102,'2020-04-23 04:30:15',17);
Insert into comment values(1014,'Good gimmicky fun as usual',102,'2020-07-20 03:00:19',18);
Insert into comment values(1015,'Diamonds are Forever is a watchable thriller',102,'2021-02-27 03:00:19',19);
Insert into comment values(1016,'If you want a good laugh watch it again!',102,'2021-05-19 02:30:19',20);
Insert into comment values(1017,'One of the Best Bond movies ever made !!',102,'2022-01-11 01:30:00',15);
Insert into comment values(1018,'All bad Bond movies are fun to watch, but this one is pushing it to its limit',102,'2021-12-21 11:00:30',11);

Insert into comment values(1019,'The book is an easy read',105,'2016-05-15 06:15:00',11);
Insert into comment values(1020,'There are better Bond novel than this one',105,'2017-03-15 07:13:05',12);
Insert into comment values(1021,'A Good Novel and kept the tempo of reading continuously',105,'2018-04-29 08:44:45',13);
Insert into comment values(1022,'A masterpiece by ian fleming',105,'2019-05-22 09:34:05',14);
Insert into comment values(1023,'You will feel like reading it again',105,'2020-06-12 10:26:19',15);
Insert into comment values(1024,'If you read this thriller and then watch movie, you will have an altogether different experience',105,'2021-07-11 11:46:55',16);
Insert into comment values(1025,'Thriller, especially crime thriller, is a genre I don’t gravitate towards a lot',105,'2022-01-07 12:02:29',17);

select *from comment;
-- -------------------------------------------------------

create table user (
id int primary key,
name varchar(100) );

insert into user values(11,'Neha');
insert into user values(12,'Pooja');
insert into user values(13,'Pawan');
insert into user values(14,'Pinky');
insert into user values(15,'Sneha');
insert into user values(16,'Ravi');
insert into user values(17,'Kavita');
insert into user values(18,'Lalita');
insert into user values(19,'Abhishek');
insert into user values(20,'Ankita');

select *from user;
-- -------------------------------------------------------

-- Query: Get list of Posts with latest 10 comments of each post authored by 'James Bond'

SELECT c.postid AS postid, p.name AS post, a.name AS author, commentid, content, rownum
FROM post p
LEFT  JOIN author a ON a.id = p.authorid
LEFT  JOIN (SELECT postid, id AS commentid, content, 
			row_number() OVER (PARTITION BY postid ORDER BY id DESC) AS rownum
			FROM comment
            ) c ON p.id=c.postid 
WHERE a.name="James Bond" AND c.rownum <= 10;

-- subquery
select postid, id as commentid, content, 
		row_number() over (partition by postid order by id desc) as rownum
	from comment;
