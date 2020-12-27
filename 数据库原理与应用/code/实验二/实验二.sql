DROP DATABASE cjgl;
 ---``IS different form''

UPDATE student SET sbirth =NULL WHERE sno='1418855232';
SELECT*FROM student;
SELECT  MAX(sbirth),MIN(sbirth)   FROM  student;
SELECT * FROM SC WHERE GRADE BETWEEN 80 AND 89;
SELECT  sno,YEAR(CURDATE())-YEAR(sbirth)  AS  AGE  FROM  student;
SELECT ssex AS '性别',COUNT(*) AS '人数'  FROM  student GROUP BY ssex; 
 
 USE books;
SHOW CREATE TABLE book;
ALTER TABLE book ADD PRIMARY KEY(bookno)
SHOW CREATE TABLE reader;
SHOW CREATE TABLE borrow;
SELECT * FROM  book;
SELECT * FROM  reader;
SELECT * FROM  borrow;

INSERT  INTO `book` 
VALUES('ISBN-978-7-111636557','数据库系统原理及Mysql应用教程（第2版','李辉','机械工业出版社',2020,'69.0','未借','2');

 DELETE FROM book
 WHERE bookno='ISBN9787111636557';
 
 INSERT INTO `reader`
 VALUES('B19041830','学生',0,4,'陈龙','计算机','123');
 
  INSERT INTO `borrow`VALUES
  ('004001','TP987',CURDATE(),DATE_ADD(CURDATE(),INTERVAL 3 MONTH));

 SELECT * FROM  borrow;
  
  SELECT DATE_ADD(CURDATE(),INTERVAL 6 MONTH)
  
 DELETE FROM borrow WHERE readerno="004001";
 
 UPDATE book
 SET state='借出'
 WHERE  bookno='TP987';
 SELECT * FROM  book;
 
 UPDATE reader
 SET borrowed_num=1
 WHERE readerno='004001';
 SELECT * FROM  `reader`;
 
 
 SELECT*FROM borrow
 SELECT*FROM book
 SELECT*FROM borrow
 
 SELECT*
 FROM book
 ORDER BY bookstore ASC ,bookno ASC;
 
 SELECT MAX(price)FROM book;
 
 SELECT bookno,bookname,publisher 
 FROM book
 WHERE bookname LIKE '%数据%';
 
 SELECT  state,COUNT(*) FROM book
GROUP BY state ;



 
SET FOREIGN_KEY_CHECKS = 0; 
 DELETE FROM book WHERE bookno='TP30101';
 SET FOREIGN_KEY_CHECKS = 1;
 
 SELECT	*FROM book
 
 DELETE FROM borrow WHERE readerno='004001'
 
 DELETE FROM reader;
 
 
 
SET FOREIGN_KEY_CHECKS = 0; 
DROP TABLE reader;  
SET FOREIGN_KEY_CHECKS = 1;
 
 
 
 
 