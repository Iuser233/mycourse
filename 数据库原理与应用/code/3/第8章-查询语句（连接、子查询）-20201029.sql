
-- ================================
-- ======表数据查询语句
-- ================================

SELECT * FROM  specialty;    -- 例12

SELECT * FROM  student;

SELECT * FROM  course;

SELECT * FROM  sc;


-- ==============================================
-- 连接查询
-- ==============================================

-- 【例44】对选修表和课程表做等值连接
-- 公共字段相等

SELECT *
FROM SC INNER JOIN course
ON SC.cno=course.cno

-- 或
SELECT SC.*,COURSE.*           -- 仅作为例子，在连接查询中一般不用*或表名.*
FROM SC INNER JOIN course      -- 一般要明确给出列名或表名.列名
ON SC.cno=course.cno

-- 或写为
SELECT *
FROM SC,course    
WHERE SC.cno=course.cno    -- 不能用ON


-- 缺点，有重复列




-- 自己去掉重复列(在SELECT 子句中写出想要的列)

-- =======================================
SELECT Sno,SC.Cno,cname,grade,ccredit   -- 注意重复列前加 表名.
FROM SC INNER JOIN course
ON SC.cno=course.cno
-- =======================================




-- 用自然连接去掉重复列
-- 【例45】
SELECT *
FROM SC NATURAL JOIN course     -- 不是各个系统都有自然连接的，建议使用上面的形式
LIMIT 0,4;

-- 或
SELECT Sno,SC.Cno,cname,grade,ccredit -- SC.Cno 
FROM SC NATURAL JOIN course           -- 自然连接时，重复列名前不必加表名.
-- =======================================

SELECT Sno,Cno,cname,grade,ccredit   -- 出错，引起歧义（所以要注意重复列前加 表名.）
FROM SC INNER JOIN course
ON SC.cno=course.cno

-- =======================================
-- --------------------------------
-- 【补充】   三个表连接                

SELECT student.Sno,sname,SC.Cno,cname,grade       -- 注意表名.列名
FROM SC INNER JOIN course ON SC.cno=course.cno
INNER JOIN student ON SC.sno=student.sno;

-- 或写为：
SELECT student.Sno,sname,SC.Cno,cname,grade
FROM SC,course,student  
WHERE SC.cno=course.cno AND SC.sno=student.sno;

-- 或写为：
SELECT s.Sno,sname,SC.Cno,cname,grade
FROM SC ,course  c,student s          -- 表的别名
WHERE SC.cno=c.cno AND SC.sno=s.sno;

-- =======================================
-- =======================================
-- =======================================
-- 除了连接条件，能加查询条件吗？可以！
-- 查询选修“数据库”课程的学生学号、姓名选修课号及成绩
SELECT s.Sno,sname,SC.Cno,cname,grade
FROM SC ,course  c,student s          -- 表的别名
WHERE SC.cno=c.cno AND SC.sno=s.sno
      AND cname LIKE '%数据库%';
      
--  查询选修“数据库”课程的学生人数及平均成绩
SELECT sname,COUNT(*)AS '学生人数',AVG(grade)AS AVG_grade
FROM SC,course,student          
WHERE SC.cno=course.cno AND SC.sno=student.sno
      AND cname LIKE '%数据库%' 
GROUP BY sname;    

SELECT student.Sno,sname,COUNT(*)AS '学生人数',AVG(grade)AS AVG_grade
FROM SC,course,student         
WHERE SC.cno=course.cno AND SC.sno=student.sno
      AND cname LIKE '%数据库%' 
GROUP BY sname,sno;     -- 按两列值分组


-- 请思考，select语句执行时，先执行where子句还是先做连接？
 
-- =========================================================
-- =========================================================

-- -------------------------
-- 外链接
-- -------------------------

-- 把上面的内连接再执行一遍
SELECT Sno,SC.cno,cname,grade,ccredit   
FROM SC INNER JOIN course
ON SC.cno=course.cno

SELECT DISTINCT CNO 
FROM SC;


SELECT DISTINCT CNO 
FROM COURSE;

-- 说明COURSE中有7行数据没连接成功





-- 外链接


-- 左外链接

 -- 例47 
SELECT COURSE.Cno,cname,SC.Sno,SC.Cno
FROM course LEFT OUTER JOIN SC
ON SC.cno=course.cno;   -- 14+7行


 -- 例48
SELECT COURSE.Cno,cname,SC.Sno,SC.Cno
FROM course RIGHT OUTER JOIN SC
ON SC.cno=course.cno;   -- 14行   -- 思考为什么只有14行



-- 把【例48】这个语句改一下  左右表对换一下

SELECT course.Cno,cname,ccredit,SC.Cno,Sno,grade
FROM SC RIGHT OUTER JOIN course
ON SC.cno=course.cno;   -- 14+7行   


-- 这样的结果有用吗？

-- =======================================
-- =======================================
-- =======================================
-- 统计各课程的选课人数

SELECT course.Cno '课程号',COUNT(sno) AS '选课人数'
FROM  sc RIGHT OUTER JOIN course
ON SC.cno=course.cno
GROUP BY course.Cno;


-- 选出来选课人数为0的

SELECT course.Cno '课程号',COUNT(sno) AS '选课人数'
FROM  sc RIGHT OUTER JOIN course
ON SC.cno=course.cno
GROUP BY course.Cno
HAVING 选课人数=0;
-- =======================================
-- =======================================

SELECT Sno,SC.Cno,grade,cname,ccredit
FROM SC LEFT OUTER JOIN course               -- 换成左外连接
ON SC.cno=course.cno


SELECT Sno,SC.Cno,COUNT(sno) AS '选修人数'    -- 换成左外连接
FROM SC LEFT OUTER JOIN course
ON SC.cno=course.cno
GROUP BY SC.Cno;    -- SC.Cno比course.Cno的课程数少

-- =======================================
-- =======================================
-- =======================================
-- 补充 交叉连接，也就是笛卡尔积
SELECT Sno,SC.Cno,grade,course.Cno,cname
FROM SC CROSS JOIN course;   -- 14*14行   

SELECT 14*14;

-- 补充 试试STRAIGHT_JOIN
SELECT student.`sno`,sc.`sno`
FROM student STRAIGHT_JOIN sc      -- 缺省条件，相当于cross join
ON student.`sno`=sc.`sno`          -- 不缺省条件，相当于inner join
-- =======================================
-- =======================================






-- ==============================================
-- 子查询
-- ==============================================

-- 【例49】下面查询没选修过课程的学生的学号、姓名、专业等信息

SELECT sno,sname FROM student      -- 带IN的子查询
WHERE sno NOT IN (SELECT DISTINCT sno FROM sc);
-- 查询嵌套


-- 【例50】下面查询选修过课程的学生的学号、姓名、专业等信息。
SELECT sno,sname FROM student      
WHERE sno IN (SELECT DISTINCT(sno) FROM sc);







-- 补充些其他例子：

SELECT * FROM course;

SELECT CNO
FROM course
WHERE CNAME='C语言程序设计'


SELECT SNO
FROM SC
WHERE CNO IN 
	(SELECT CNO
	FROM course
	WHERE CNAME='C语言程序设计');



SELECT SNAME
FROM STUDENT 
WHERE SNO IN
	(SELECT SNO
	FROM SC
	WHERE CNO IN 
		(SELECT CNO
		FROM course
		WHERE CNAME='C语言程序设计'));
		
-- =======================================
-- =======================================
-- =======================================
		
-- 也可以用连接查询表示	


SELECT sc.Sno,SC.Cno,cname,grade,ccredit
FROM SC INNER JOIN course ON SC.cno=course.cno
INNER JOIN student ON sc.sno=student.sno 
WHERE CNAME='C语言程序设计';


-- 比较这两种写法的优劣

-- =======================================
-- =======================================
-- =======================================


-- 用=号的子查询，注意什么时候可以用=

SELECT sno,grade 
FROM  sc 
WHERE Cno='18132220'; 


SELECT MAX(grade) 
FROM  sc 
WHERE Cno='18132220'; 

 

SELECT SNO
FROM SC 
WHERE GRADE=(SELECT MAX(grade) 
	     FROM  sc 
	     WHERE Cno='18132220')
      AND Cno='18132220';     


-- ----------------------------------


-- 带ANY（或SOME）的子查询

-- 【例53】查询其他班级比计算1401班级
-- 某一个同学年龄小的学生的姓名和年龄。

SELECT sname,sno,sbirth,
YEAR(CURDATE())-YEAR(sbirth) AS 'age',sclass
FROM student 
WHERE sbirth > ANY     -- [可换为SOME]
	(SELECT sbirth
	FROM student
	WHERE sclass='计算1401')
	AND sclass<>'计算1401';   -- 注意这个条件的作用


-- 下面的写法会出错,略

SELECT sname,sno,
     YEAR(CURDATE())-YEAR(sbirth) AS 'age'
FROM student 
	WHERE age < ANY                          -- 因为直接用列标题age，所以出错
	(SELECT YEAR(CURDATE())-YEAR(sbirth)
	FROM student
	WHERE sclass='计算1401');


-- 可改写为：

SELECT sname,sno,sbirth,
       YEAR(CURDATE())-YEAR(sbirth) AS 'age'
FROM student 
WHERE sbirth > 
	(SELECT MIN(sbirth)
	FROM student
	WHERE sclass='计算1401')
	AND sclass<>'计算1401';



-- 【例54】查询其他班级比计算1401班级所有同学年龄都大的
-- 学生的姓名和年龄。
SELECT sname,sno,sbirth,
    YEAR(CURDATE())-YEAR(sbirth) AS 'age'
FROM student 
WHERE sbirth < ALL
	(SELECT sbirth
	FROM student
	WHERE sclass='计算1401')
	AND sclass<>'计算1401';



-- 可改写为：

SELECT sname,sno,sbirth,
    YEAR(CURDATE())-YEAR(sbirth) AS 'age'
FROM student 
WHERE sbirth <              -- 默认是ALL
	(SELECT MIN(sbirth)
	FROM student
	WHERE sclass='计算1401')
	AND sclass<>'计算1401';



-- 按书上的写

SELECT CURDATE();

SELECT NOW();

SELECT TO_DAYS(NOW());   
 -- TO_DAYS返回一个天数! 从年份0开始的天数 


SELECT FROM_DAYS(TO_DAYS(NOW()));   
-- FROM_DAYS(N) 根据给出的天数 N，返回一个 DATE 值：


SELECT SNO,FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(Sbirth)) AS age 
FROM student;


SELECT DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(Sbirth)),'%Y') +0 AS 'age' 
FROM student;




-- ==============================================
--  （2）带EXISTS关键字的子查询
-- 【例】如果存在“计算机科学与技术”这个专业，就查询这个专业所有的学生信息。

SELECT * FROM specialty
WHERE  zname='计算机科学与技术';

SELECT *
FROM student
WHERE zno = '1805';


SELECT *
FROM student
WHERE EXISTS(SELECT * FROM specialty
             WHERE  zname='计算机科学与技术');



SELECT *
FROM student
WHERE  zno = '1805' 
      AND EXISTS(SELECT * FROM specialty
         WHERE  zname='计算机科学与技术');
             
             
 -- 或写为            
             
SELECT *
FROM student
WHERE  EXISTS
        (SELECT * FROM specialty 
         WHERE  zname='计算机科学与技术'
         AND zno=student.zno);     -- student.zno在子查询中被引用
         
         
         
         
 -- ==================================        
 --   将子查询用于其他DML语句      
 -- ==================================   
 
 -- insert  对每一个班级，统计学生人数，并把结果存入指定表。

 
 -- 第一步：建一个表
  CREATE  TABLE  membbercount_of_class 
          (Sclass  VARCHAR(10),    /* 班级*/
           membbercount TINYINT); /*学生人数*/
           
           

 -- 插入数据
 INSERT INTO membbercount_of_class
 (
 SELECT sclass,COUNT(*)
 FROM student
 GROUP BY sclass
 ORDER BY sclass);
 
 SELECT * FROM membbercount_of_class;
 
 
 -- update
 
 -- [例]  将电子商务课程的成绩置零。
        UPDATE SC
        SET  Grade=0
        WHERE   (SELECT cname         -- 相关子查询   
                 FROM  course
                 WHERE cno = sc.Cno) ='电子商务'
 ;             
                 
  --   或：                 
        UPDATE SC
        SET  Grade=0
        WHERE  cno IN 
                (SELECT cno
                 FROM  course
                 WHERE cname = '电子商务');   -- 这个好理解
                 
                 
  SELECT  * FROM  sc;   
  
  
  
-- --------------------------------------- 
-- delete
 
 -- [例] 将电子商务课程的所有学生的成绩信息删除。
                
        DELETE FROM SC
        WHERE  cno IN 
                (SELECT cno
                 FROM  course
                 WHERE cname = '电子商务');
                 
                 

-- =======================================
-- =======================================
-- =======================================

-- ==============
-- union的应用

SELECT * FROM sc WHERE cno='58130540' 
UNION 
SELECT * FROM sc WHERE cno='18130320' 

SELECT sno FROM sc WHERE cno='58130540'    -- 合并了重复行
UNION 
SELECT sno FROM sc WHERE cno='18130320' 


-- 假设当前数据库是CJGL，请写出查询语句，
-- 查询获得课程号18130320的课程的最高分的学生的学号
SELECT student.sno,sname,cno,grade 
FROM student INNER JOIN sc ON student.sno=sc.sno
WHERE grade >= ALL (SELECT grade FROM sc WHERE CNO='18130320') 
     AND cno = '18130320';
     


SELECT SNO,SNAME
FROM STUDENT
WHERE SNO IN
  (SELECT SNO
   FROM SC
   WHERE GRADE=(SELECT MAX(grade) FROM SC WHERE CNO='18130320')
         AND CNO='18130320'
   );

-- =======================================
-- =======================================



SELECT MAX(grade) FROM sc WHERE cno = '18130320'


       
SELECT sno 
FROM sc
WHERE grade=
  (SELECT MAX(grade) FROM sc 
  WHERE cno = '18130320')
  AND cno = '18130320'


