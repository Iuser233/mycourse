SELECT VERSION();

SHOW VARIABLES LIKE 'character_set_database';

SHOW VARIABLES LIKE 'character_set_database';

CREATE DATABASE IF NOT EXIT books
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_0900_as_cs;



CREATE DATABASE IF NOT EXISTS books 
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_0900_as_cs;

SHOW DATABASES;
CREATE DATABASE books;
DROP TABLE books;
SHOW ENGINES;
USE books;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE books;
SET FOREIGN_KEY_CHECKS = 1;


DROP DATABASE books;
CREATE DATABASE books;

CREATE TABLE	books(
bno  VARCHAR(20) NOT NULL COMMENT'书号',
bname VARCHAR(10) NOT NULL COMMENT '书名',
writter VARCHAR(8) COMMENT'作者',
phouse VARCHAR(4) NOT NULL COMMENT'出版社',
pyear YEAR  NOT NULL COMMENT'出版年',
unitprice DECIMAL(8,2) ,
state CHAR(2) NOT NULL DEFAULT'未借'  COMMENT'状态',

 PRIMARY KEY (bno)
)ENGINE	= INNODB;

CREATE TABLE reader(
lcnumber  VARCHAR(7) NOT NULL COMMENT'借书证号',
category VARCHAR(2) NOT NULL COMMENT '类别',
bbooks VARCHAR(10) COMMENT'已借书籍',
maxbooks VARCHAR(4) NOT NULL COMMENT'最多借书数',
rname  VARCHAR (4) NOT NULL COMMENT'姓名',
college VARCHAR(4) NOT NULL   COMMENT'学院',
 PRIMARY KEY (lcnumber)
)ENGINE	= INNODB;

CREATE TABLE borrow (
lcnumber VARCHAR(7) NOT NULL ,
bno VARCHAR(7) NOT NULL,
bdata DATE ,
rdata DATE ,
PRIMARY KEY(bno),
FOREIGN KEY (bno) REFERENCES books(bno),
FOREIGN KEY (lcnumber) REFERENCES reader(lcnumber)
)

INSERT INTO books VALUES('TP273-1','大数据时代','刘鹏','清华大学','2017','40.5','未借');
INSERT INTO books VALUES('TP273-3' , '云计算' ,' ','电子工业','2018','39','借出');


INSERT INTO reader VALUES('0041001','学生','0','4','李笑笑','计算机');
INSERT INTO reader VALUES('1110','教师','1','10','王思海','计算机');
INSERT INTO reader VALUES('0071015','学生','0','4','杜拉拉','经济管理');

INSERT INTO borrow VALUES('1110','tp273-3','2018-5-6','2018-10-6');

SELECT * FROM books;
SELECT * FROM borrow;
SELECT * FROM reader;

UPDATE reader
SET rname ='王大海'
WHERE lcnumber ='1110';

DELETE FROM reader
WHERE lcnumber='0071015';

DELETE FROM reader
WHERE lcnumber='1101';


SELECT*FROM reader;


USE schoolInfo;
CREATE TABLE  teacherInfo (
id INT  NOT NULL  UNIQUE  PRIMARY KEY AUTO_INCREMENT,  
NAME VARCHAR(20) ,
Sex CHAR(1) ,
Birthday DATE,
Address VARCHAR(50)
);

ALTER TABLE teacherInfo MODIFY NAME VARCHAR(30) NOT NULL;

ALTER TABLE  teacherInfo MODIFY birthday DATETIME AFTER NAME;

ALTER TABLE teacherInfo CHANGE id t_id INT(10) NOT NULL; 

ALTER TABLE teacherInfo DROP address;

ALTER TABLE  teacherInfo  ADD wages FLOAT;

ALTER TABLE teacherInfo RENAME teacherInfo_Info;

ALTER TABLE  teacherInfo_info ENGINE=MYISAM;

DESCRIBE teacherInfo_info;

DROP TABLE teacherInfo_info;




