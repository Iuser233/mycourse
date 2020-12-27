DROP DATABASE books;
DROP DATABASE cjgl;

4. 查询选修'C语言程序设计'课程的学生的学号、成绩。
SELECT sno,grade
FROM course,sc
WHERE cname='C语言程序设计'AND sc.cno=course.cno


5. 查询'C语言程序设计'课程的最高分。
SELECT sno,grade,MAX(grade)
FROM course,sc
WHERE cname='C语言程序设计'AND sc.cno=course.cno
--



6. 查询获得'C语言程序设计'课程的最高分是哪些同学（学号、姓名、班级）。
SELECT sc.sno AS'学号',sname AS '姓名',sc.cno AS '班级' ,MAX(grade)
FROM course,sc,student
WHERE cname='C语言程序设计'AND sc.cno=course.cno AND sc.`sno`=student.`sno`

-- 子查询

SELECT sno,sname,sclass
FROM student 
WHERE sno IN ( SELECT sno FROM sc WHERE grade 
IN(SELECT MAX(grade) FROM  sc WHERE cno 
IN(SELECT cno FROM course WHERE cname IN(
SELECT cname FROM course WHERE cname='C语言程序设计')
))
AND cno IN (SELECT cno FROM course WHERE cname='C语言程序设计'))



7.查询借出“三毛流浪记”的读者的读者编号、姓名、系别。(要求用连接查询)  
SELECT borrow.readerno ,readername,readerdept
FROM reader,book,borrow
WHERE bookname='三毛流浪记' AND book.`bookno`= borrow.`bookno` AND borrow.`readerno`=reader.`readerno`;

-- ff2
SELECT reader.readerno ,readername,readerdept
FROM reader INNER JOIN borrow ON borrow.`readerno`=reader.`readerno`
INNER JOIN book ON  bookname='三毛流浪记' AND book.`bookno`= borrow.`bookno`;

8.查询借出“三毛流浪记”的读者的读者编号、姓名、系别。(要求用子查询)
SELECT readerno ,readername,readerdept FROM reader WHERE readerno IN(
SELECT readerno FROM borrow WHERE bookno IN(SELECT bookno FROM book WHERE bookname='三毛流浪记'
))


9.查询“计算机”系的同学和老师借出了哪些书，要求查询结果中包括读者编号、姓名、书号、书名。
SELECT borrow.readerno,readername, borrow.bookno,bookname
FROM book,borrow ,reader
WHERE readerdept='计算机' AND borrow.readerno=reader.`readerno` AND borrow.`bookno`=book.`bookno`;

10.假设“王小明”毕业了，在借阅表中删去“王小明”的借阅记录。
SELECT *FROM borrow;

DELETE FROM borrow
WHERE readerno IN(
SELECT readerno
FROM reader
WHERE readername='王小明'
)

