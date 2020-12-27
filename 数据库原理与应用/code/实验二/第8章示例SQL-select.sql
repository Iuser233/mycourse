-- 可参考7.6运算符（教材7.4）


SELECT 3*12/4; 

SELECT CURDATE(),NOW(); 

SELECT VERSION();


-- ================================
-- ======表数据查询语句
-- ================================
USE cjgl;

DESC specialty; 

SELECT * FROM  specialty;    -- 例12

DESC student;   
             
SELECT * FROM  student;  -- 【例13】

DESC course;

SELECT * FROM  course;

DESC sc;

SELECT * FROM  sc;


--  （3）DISTINCT避免重复数据查询

 
SELECT  ssex  FROM  student;

SELECT  DISTINCT ssex  FROM  student;

SELECT  DISTINCT sclass,ssex  FROM  student;

SELECT  DISTINCT sclass,DISTINCT ssex  FROM  student;  -- 错误

-- -------------------------------------------

-- 指定列标题，第3列为表达式

SELECT sno,sname,YEAR(CURDATE()) - YEAR(sbirth) AS 'age' 
FROM student;                    -- 第3列为表达式


-- --------------------------------------
-- 3. 条件查询，使用WHERE表达条件
-- --------------------------------------

-- 使用比较运算符、逻辑运算

-- 【例19】查询成绩在70分到80分之间的学生的学号、课号、成绩。

SELECT sno,cno,grade           
FROM sc 
WHERE grade>=70 AND grade<=80;

--  WHERE grade>=70 && grade<=80;  -- 或写为


-- -------------------------------------
-- 使用 LIKE、NOT LIKE
SELECT * 
FROM  student 
WHERE sname LIKE '%梅%'   -- 用的多
ORDER BY sno ;  -- 查询结果按sno升序排列（asc）

SELECT * 
FROM  student 
WHERE sname LIKE '%梅%'   -- 用的多
ORDER BY sno DESC ;  -- 查询结果按sno降序排列

SELECT * 
FROM  student 
WHERE sname LIKE '王%';

SELECT * FROM  student 
WHERE sname  NOT LIKE '王%';   -- NOT LIKE 

SELECT * FROM  student 
WHERE sname LIKE '王_';



-- ----------------------------------------


-- 4（4）使用统计函数

-- 【例34】使用COUNT()函数统计student表的记录数。

SELECT COUNT(*) AS '记录数' 
FROM  student;

SELECT COUNT(SSEX)  
FROM  student;

SELECT COUNT(DISTINCT SSEX)  -- 统计SSEX列中非空、且不重复的值的个数
FROM  student;



SELECT COUNT(sbirth) 
FROM  student;  -- 只统计非空值的sbirth个数

SELECT  MAX(sbirth),MIN(sbirth)   
FROM  student;


-- 【例36】使用SUM()函数统计sc表中学号为1414855328的同学的总成绩

SELECT SUM(grade) FROM  sc    -- 若有空值，忽略空值
WHERE sno='1414855328';


SELECT AVG(*)         -- 错误，必须指出具体的列
FROM  sc 
WHERE sno='1414855328';  -- 出错


SELECT AVG(grade) 
FROM  sc 
WHERE sno='1414855328';  


-- --------------------------------------------------------
-- 4（1） 分组查询


-- 【例30】下面按student表的ssex字段进行分组查询。

SELECT COUNT(*) 
FROM  student 
GROUP BY ssex;


SELECT ssex,COUNT(*) 
FROM  student 
GROUP BY ssex;


-- 建议写法
SELECT ssex AS '性别',COUNT(*) AS '人数' 
FROM  student 
GROUP BY ssex;


SELECT ssex AS '性别',COUNT(*) AS '人数' 
FROM  student 
GROUP BY ssex
ORDER BY COUNT(*);   -- 分组结果再排序，注意子句顺序




-- 补充举例

SELECT sno AS '学号',COUNT(*) AS '选课门数'
FROM sc
GROUP BY sno
ORDER BY sno;


SELECT Cno AS '课程号',COUNT(*) AS '选课人数',AVG(grade) AS '课程平均成绩'
FROM sc
GROUP BY Cno
ORDER BY Cno;

-- 强调：带有GROUP BY子句的select语句中, select子句中只能出现GROUP BY所依据的列,以及聚合函数






-- -------------------------------------------------------------------------------------



-- having子句应用

 -- 【例30】按student表的ssex字段进行分组查询，然后显示记录数大于等于10的分组。
SELECT ssex AS '性别',COUNT(ssex) AS '人数'  
FROM  student 
GROUP BY ssex
HAVING COUNT(ssex) >=10;


-- 或写为：
SELECT ssex AS '性别',COUNT(*) AS '人数'   
FROM  student 
GROUP BY ssex
HAVING 人数>=7;



-- select语句使用时，要注意各子句的书写顺序与执行顺序：

SELECT ssex AS '性别',COUNT(*) AS '人数' 
FROM  student 
WHERE zno='1102'
GROUP BY ssex 
HAVING COUNT(*)>=1
ORDER BY ssex DESC;



-- ==================================
-- ==================================
-- ======表数据查询语句  （全部例子）  
-- ==================================
-- ==================================

-- 可参考7.6运算符（教材7.4）


SELECT 3*12/4; 

SELECT CURDATE(),NOW(); 

SELECT VERSION();


-- ================================
-- ======表数据查询语句    
-- ================================
USE cjgl;

DESC specialty; 

SELECT * FROM  specialty;    -- 例12

DESC student;   
             
SELECT * FROM  student;  -- 【例13】

DESC course;

SELECT * FROM  course;

DESC sc;

SELECT * FROM  sc;


-- 指定字段查询   

SELECT sno,sname FROM  student;       -- 【例14】

SELECT sno,sname,ssex FROM  student;

SELECT  sclass  FROM  student;
SELECT  ALL sclass  FROM  student;

SELECT  student.sclass  FROM  student;


--  （3）DISTINCT避免重复数据查询

SELECT  DISTINCT sclass FROM  student;    -- 【例15】
 
SELECT  ssex  FROM  student;

SELECT  DISTINCT ssex  FROM  student;

SELECT  DISTINCT sclass,ssex  FROM  student;

SELECT  DISTINCT sclass,DISTINCT ssex  FROM  student;  -- 错误

-- （4）为表和字段取别名

-- 指定列标题
SELECT sno AS '学号',grade AS '成绩' FROM sc;        -- 【例16】

SELECT sno AS '学号',cno AS '课号',grade AS '成绩' FROM sc;  


SELECT  sclass AS 班级 FROM  student;  

SELECT  sclass AS '班级' FROM  student;    -- JAVA 引用结果时用AS后的列名


-- 【例17】改了一点
SELECT sno '学号',cno '课号',
grade '成绩',grade*(1+0.1) '加10%后的成绩' FROM sc; 


SELECT sno,sname,YEAR(CURDATE()) - YEAR(sbirth) AS 'age' 
FROM student;                    -- 第3列为表达式



-- 【补充举例】指定表的别名,在该SELECT中有效   -----

SELECT s.sno,sname,YEAR(CURDATE()) - YEAR(sbirth) AS 'age' 
FROM student s;                    -- 第3列为表达式

 

-- --------------------------------------
-- 3. 条件查询，使用WHERE表达条件
-- --------------------------------------

-- 使用比较运算符、逻辑运算

SELECT * 
FROM  student  
WHERE zno='1102' AND sclass='商务1401';


SELECT COUNT(*) 
FROM  student  
WHERE zno='1102' AND sclass='商务1401';


-- 【例18】查询成绩大于90分的学生的学号、课程号以及分数

SELECT sno,cno,grade 
FROM sc 
WHERE grade>90   

SELECT * 
FROM  SC 
WHERE GRADE=100;        -- 不要和JAVA 的等于 搞混了


 -- 【例19】                   AND、OR、NOT是逻辑运算符
-- 【例19】查询成绩在70分到80分之间的学生的学号、课号、成绩。

SELECT sno,cno,grade           
FROM sc 
WHERE grade>=70 AND grade<=80;
--  WHERE grade>=70 && grade<=80;  -- 或写为


-- -----------------
-- 使用in、not in
-- -----------------
-- 【例20】查询成绩在集合(65，75，85，95)中的学生的学号、课号和成绩

SELECT * 
FROM  SC 
WHERE GRADE IN (95,75,85,95);

SELECT sno,sname 
FROM student 
WHERE sno IN ('1114070116','1411855228','1411855321');


-- 使用 BETWEEN…AND  、not BETWEEN…AND

SELECT * FROM  SC;

-- 【例21】查询成绩在70分到80分之间学生的学号、课号和成绩。包含70分和80分。

SELECT * FROM  SC 
WHERE GRADE>=70 AND GRADE<=80;

SELECT * FROM  SC 
WHERE GRADE BETWEEN 70 AND 80;

SELECT * FROM  SC 
WHERE GRADE BETWEEN 80 AND 90;   -- NOT BETWEEN




-- 带IS NULL关键字的空值查询

 -- 【例24】查询还没有分专业的学生的学号和姓名

SELECT * FROM  student 
WHERE zno IS  NULL; 

SELECT * FROM  student 
WHERE zno IS NOT NULL; 

-- 使用 LIKE、NOT LIKE

-- 【例25】下面使用LIKE关键字来匹配一个字符串‘蓝梅'
SELECT * FROM  student 
WHERE sname LIKE '蓝梅';

-- 对匹配一个完整的字符串时，使用LIKE关键字和使用“＝”的效果是一样的
SELECT * FROM  student 
WHERE sname='蓝梅';

-- 【例26】查找姓李的学生记录。
SELECT * FROM student 
WHERE sname LIKE '李%'; 

SELECT * FROM  student;

SELECT * FROM  student 
WHERE sname LIKE '王%';

SELECT * FROM  student 
WHERE sname  NOT LIKE '王%';   -- NOT LIKE 

SELECT * FROM  student 
WHERE sname LIKE '王_';

SELECT * FROM  student 
WHERE sname LIKE '%梅%';  -- 用的多

-- ----------------------------------------









-- ====================================
-- 4（2）让查询结果按序显示，使用ORDER BY关键字对记录进行排序。

-- 【例31】查询student表中所有记录，按zno字段进行排序。
SELECT * FROM  student ORDER BY zno;


SELECT * FROM  student ORDER BY ssex ;

SELECT * FROM  student ORDER BY ssex DESC;

-- 【例32】查询student表中所有记录，按zno字段的升序和sno字段的降序进行排序。
SELECT * FROM  student ORDER BY zno,sno DESC;





-- 4（4）使用统计函数

-- 【例34】使用COUNT()函数统计student表的记录数。

SELECT COUNT(*) AS '记录数' FROM  student;

SELECT COUNT(SSEX)  
FROM  student;

SELECT COUNT(DISTINCT SSEX)  -- 统计SSEX列中非空、且不重复的值的个数
FROM  student;




UPDATE student SET `sbirth`=NULL 
WHERE SNO='1418855232';

SELECT COUNT(sbirth) 
FROM  student;  -- 只统计非空值的个数

SELECT  MAX(sbirth),MIN(sbirth)   
FROM  student;


-- 【例36】使用SUM()函数统计sc表中学号为1414855328的同学的总成绩

SELECT SUM(grade) FROM  sc    -- 若有空值，忽略空值
WHERE sno='1414855328';


SELECT * 
FROM  sc 
WHERE sno='1414855328';


SELECT AVG(*)         -- 必须指出具体的列
FROM  sc 
WHERE sno='1414855328';  -- 出错


SELECT AVG(grade) 
FROM  sc 
WHERE sno='1414855328';  


-- --------------------------------------------------------
-- 4（1） 分组查询

SELECT * FROM  student;

SELECT * FROM  student ORDER BY ssex;

SELECT * FROM  student GROUP BY ssex; -- 不出错，但没有意义


-- 【例30】下面按student表的ssex字段进行分组查询。

SELECT COUNT(*) 
FROM  student 
GROUP BY ssex;



SELECT ssex,COUNT(*) 
FROM  student 
GROUP BY ssex;


-- 建议写法
SELECT ssex AS '性别',COUNT(*) AS '人数' 
FROM  student 
GROUP BY ssex;


SELECT ssex AS '性别',COUNT(*) AS '人数' 
FROM  student 
GROUP BY ssex;





-- 为什么不这样写成两句？

SELECT COUNT(*) AS '人数' 
FROM  student 
WHERE ssex='男';

-- 和

SELECT COUNT(*) AS '人数' 
FROM  student 
WHERE ssex='女';

-- 因为：当分类多了，几乎没法一一写



-- 补充举例

SELECT sno AS '学号',COUNT(*) AS '选课门数'
FROM sc
GROUP BY sno
ORDER BY sno;


SELECT Cno AS '课程号',COUNT(*) AS '选课人数',AVG(grade) AS '课程平均成绩'
FROM sc
GROUP BY Cno
ORDER BY Cno;

-- 强调：带有GROUP BY子句的select语句中, select子句中只能出现GROUP BY所依据的列,以及聚合函数






-- -------------------------------------------------------------------------------------



-- having子句应用

 -- 【例30】按student表的ssex字段进行分组查询，然后显示记录数大于等于10的分组。
SELECT ssex AS '性别',COUNT(ssex) AS '人数'  
FROM  student 
GROUP BY ssex
HAVING COUNT(ssex) >=10;



SELECT ssex AS '性别',COUNT(*) AS '人数'   
FROM  student 
GROUP BY ssex
HAVING 人数>=7;


-- 或
SELECT ssex AS '性别',COUNT(*) AS '人数' 
FROM  student 
GROUP BY ssex
HAVING COUNT(*)>=7;




SELECT ssex AS '性别',COUNT(*) AS '人数' 
FROM  student 
GROUP BY ssex
ORDER BY ssex;




-- select语句使用时，要注意各子句的书写顺序与执行顺序：

SELECT ssex AS '性别',COUNT(*) AS '人数' 
FROM  student 
WHERE zno='1407'
GROUP BY ssex
ORDER BY ssex DESC;


-- ---------------------------------
-- 4（3）limit子句
SELECT * FROM sc LIMIT 5,10;   -- 检索记录行 6-15
  
-- 为了检索从某一个偏移量到记录集的结束所有的记录行，可以指定第二个参数为 -1
SELECT * FROM sc LIMIT 95,-1;  -- 检索记录行 96-last

SELECT * FROM sc LIMIT 4,1;   -- 检索第5行记录

SELECT * FROM sc LIMIT 0,1;   -- 检索第1行记录

-- 如果只给定一个参数，它表示返回最大的记录行数目 
SELECT * FROM sc LIMIT 5; -- 检索前 5 个记录行
SELECT * FROM sc LIMIT 1; 
-- LIMIT n 等价于 LIMIT 0,n


-- -------------------------------------
-- 做点其他计算
SELECT  sno,sbirth 
FROM  student;



SELECT  sno,sbirth-CURDATE() 
FROM  student;



SELECT  sno,YEAR(sbirth)-YEAR(CURDATE()) 
FROM  student;


SELECT  sno,YEAR(CURDATE())-YEAR(sbirth) AS AGE 
FROM  student;



SELECT YEAR(CURDATE());




-- 其他注意的问题

SELECT MAX(GRADE)
FROM SC
WHERE CNO='18130320';


SELECT  SNO,MAX(GRADE) 
FROM SC
WHERE CNO='18130320'; 

 -- 显然学号不对，不能将字段名和统计函数一起使用，
 -- 除非是分组查询，且字段名是分组依据的列
 
-- 解决： 
SELECT  SNO,GRADE  
FROM SC
WHERE CNO='18130320'
ORDER BY GRADE DESC
LIMIT 1;





