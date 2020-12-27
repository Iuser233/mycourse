`mydb`-- 存储过程举例：【补充】
-- 按姓名查询学生选修的课程及成绩
DROP PROCEDURE IF EXISTS searchbysname;

DELIMITER $$  
CREATE PROCEDURE searchbysname
(IN xm VARCHAR(20),OUT recordcount SMALLINT)  
BEGIN  
SELECT COUNT(*) INTO recordcount 
FROM student  
WHERE sname=xm;  
IF recordcount>0 THEN
BEGIN
SELECT student.sno,sname,sc.cno,cname,grade
FROM student,sc,course
WHERE student.sno=sc.sno AND sc.cno=course.cno
      AND sname=xm;
END;
END IF;
END$$ 
DELIMITER ; 


CALL searchbysname('蓝梅',@r);
SELECT @r;





-- 存储过程举例：[例11-2】
DELIMITER $$  
CREATE  PROCEDURE  getnamebysno
(IN xh CHAR(10), OUT NAME VARCHAR(20) )  
BEGIN  
SELECT  sname INTO NAME  
FROM  student  
WHERE  sno=xh ;  
END $$ 
DELIMITER ; 


-- 调用

SET @NAME=NULL;
CALL getnamebysno('1412855223', @NAME);
SELECT @NAME;




-- 修改[例11-2】
DELIMITER $$  
CREATE  PROCEDURE  getnamebysno1
(IN xh CHAR(10) )                   -- 不一定都要输出参数
BEGIN  
SELECT  sname FROM  student  WHERE  sno=xh ;  
END $$ 
DELIMITER ; 


-- 调用
CALL getnamebysno1('1412855223');  -- 括号(  )不能省略



-- 补充：无参的存储过程
DELIMITER $$  
CREATE  PROCEDURE  student_count 
( )    -- 注意：无参的存储过程，括号(  )不能省略----------
BEGIN  
SELECT  COUNT(*) AS student_count FROM  student ;  
END $$ 
DELIMITER ; 

CALL student_count();   -- 括号(  )可以省略

CALL student_count; 


-- 函数----------------------------------

SET GLOBAL log_bin_trust_function_creators=TRUE;

SELECT CURDATE();

-- 将[例11-2】改成函数来做
DELIMITER $$  
CREATE  FUNCTION  getnamebysno2 
(xh CHAR(10))      -- 参数前不要IN，不能有out参数
RETURNS  VARCHAR(20)  
BEGIN  
RETURN(SELECT  sname FROM  student  WHERE  sno=xh );  
END $$ 
DELIMITER ; 



-- 调用
SELECT  getnamebysno2('1412855223');        -- 正确

SELECT * FROM getnamebysno2('1412855223');  -- 不能这样用

/*  如果不能创建函数，执行下面的操作之后再创建
show variables like 'log_bin_trust_function_creators';
set global log_bin_trust_function_creators=1;
*/




-- 下面的这个函数可以定义，但调用时出错
DELIMITER $$  
CREATE  FUNCTION  getnamebysno3
(xh CHAR(10))      -- 注意函数的参数不要写IN
RETURNS  VARCHAR(20)  
BEGIN  
RETURN(SELECT  sname FROM  student  WHERE  sno LIKE '14%' );  
END $$ 
DELIMITER ; 



-- 调用
SELECT  getnamebysno3('1412855223');     --  错了，而且函数执行中这个参数没有用到

-- 错误的原因：函数返回结果只能是一行一列的






-- 类似【例11-3】

-- 注意：无参的函数，括号(  )不能省略----------

DELIMITER $$  
CREATE  FUNCTION  num_of_student
( )     
RETURNS  INT
BEGIN  
RETURN(SELECT  COUNT(*) FROM  student );  
END $$ 
DELIMITER ; 


SELECT  num_of_student(  ); 



-- 补充例子：求1+2+.....+n

DELIMITER $$  
CREATE  FUNCTION  sum_of_number
(n INT )     
RETURNS  INT
BEGIN  
	DECLARE s,i INT;
	SET i=0,s=0;
	WHILE i<=n DO
		SELECT s+i INTO s;
		SET i=i+1;
	END WHILE;
	RETURN (s);  
END $$ 
DELIMITER ; 

SELECT sum_of_number(10);

SELECT sum_of_number(100);






-- 学习流程控制语句------------------------

-- IF

DELIMITER // -- 分界符
CREATE PROCEDURE test_if(IN X INT)
BEGIN
	IF X=1 THEN
		SELECT 'OK';
	ELSEIF X=0 THEN
		SELECT 'No';
		ELSE 
		SELECT 'good';
	END IF;
END //
DELIMITER ;


CALL test_if(0);


-- -------------------------

DELIMITER //
CREATE PROCEDURE test_case(IN X INT)
BEGIN
	CASE X
	WHEN 1 THEN SELECT 'OK';
	WHEN 0 THEN SELECT 'No';
	ELSE SELECT 'good';
	END CASE ;
END //
DELIMITER ;


CALL test_case(9);


DELIMITER //
CREATE PROCEDURE test_case2(IN X INT)
BEGIN
	CASE 
	WHEN X=1 THEN SELECT 'OK';
	WHEN X=0 THEN SELECT 'No';
	ELSE SELECT 'good';
	END CASE ;
END //
DELIMITER ;

CALL test_case2(1);


-- 补充举例
-- CASE用在SELECT 语句中
SELECT sno AS '学号',cno AS '课程号',
    CASE 
    WHEN grade>=90 THEN '优秀'
    WHEN grade>=80 THEN '良好'
    WHEN grade>=70 THEN '中等'
    WHEN grade>=60 THEN '及格'
    ELSE  '不及格'
    END AS '成绩等级'  -- 不要写CASE，否则会出错
FROM sc 





-- -------------------------
-- 使用REPEAT---------------------------------


DROP PROCEDURE IF EXISTS test_repeat1;
DELIMITER //
CREATE PROCEDURE test_repeat1(OUT SUM INT)
BEGIN
DECLARE i INT DEFAULT 1;
DECLARE s INT DEFAULT 0;
	REPEAT
	SET s = s+i;
	SET i = i+1;
	UNTIL i>10 -- 此处不能有分号
	END REPEAT;
SET SUM = s;
END// 
DELIMITER ;


CALL test_repeat1(@s);
SELECT @s;


-- 用户变量的使用
SET @X=1,@Y=2;
SELECT @X+@Y;


SET X=1,Y=2;  -- 出错，必须加@



-- leave终止while循环示例

DELIMITER //
CREATE PROCEDURE P1()
BEGIN
DECLARE I INT ;
SET I=0;
	N:WHILE I<10 DO 
	SET I=I+1;
	SELECT CONCAT("-->",I);
	IF I=5 THEN
	LEAVE N;
	END IF;
	END WHILE ;
END //
DELIMITER ;

CALL P1;



SHOW CREATE PROCEDURE `getnamebysno`

-- -----------------------------
-- 查看存储过程或函数的信息

SHOW PROCEDURE  STATUS  LIKE  'p';   

SHOW CREATE PROCEDURE p;  -- 查看定义
            
SHOW PROCEDURE STATUS; -- 存储过程

SHOW FUNCTION STATUS;  -- 函数




-- 补充------------------------------------------------------------

-- 多个输出参数的存储过程(此处直接举例有多个出参的存储过程的写法)
 
DELIMITER $		
CREATE PROCEDURE myp7(
  IN beautyName VARCHAR(20),OUT boyName VARCHAR(20),OUT userCP VARCHAR(20))		
BEGIN			
SELECT bo.boyName,bo.userCP INTO boyName,userCP 
FROM boys bo INNER JOIN beauty b ON bo.id=b.boyfriend_id
WHERE  b.name=beautyName;		
END $		
DELIMITER ;


-- 调用：此处存储过程的两个入参(也即出参)用@符号定义即可，也可以先定义好传入到里面
CALL myp7('小昭',@boyName,@userCP);





-- 创建带有INOUT的存储过程

-- 例:传入a,b 最终a,b翻倍，并返回
	
DELIMITER $	
CREATE PROCEDURE ccgc(INOUT a INT,INOUT b INT)
BEGIN	
SET a=a*2;
SET b=b*2;			
END $		
DELIMITER ;


-- 调用：此处需要提前定义参数值，类似于java的入参，

SET @m=10;
SET @n=30;
CALL ccgc(@m,@n);

SELECT @m,@n
 

-- ------------------------------------------------------------

-- ==============================
-- 游标应用
-- ==============================
-- 【例11-6】

-- -----------------------------------------
-- 给专业表增加一列：人数（本专业人数）

ALTER TABLE`specialty` 
ADD COLUMN member_count SMALLINT ;

SELECT 	* FROM specialty;


-- 下面用存储过程和游标，实现对每个专业，
-- 到学生表中统计中相应人数来替换member_count的值

DELIMITER $$
CREATE PROCEDURE count_member( )
BEGIN  

DECLARE c SMALLINT;   
DECLARE zid VARCHAR(4); 
DECLARE done SMALLINT DEFAULT 0;

DECLARE cur CURSOR FOR 
SELECT zno FROM specialty; -- 创建游标,准备用游标遍历专业表的每条记录

DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET done = 1;-- 出现溢出则赋值为1，作为跳出循环的判断

OPEN cur;     -- 打开游标

pos:WHILE  done = 0 DO              -- 判断是否结束循环
      FETCH cur INTO zid;  
      IF done=1 THEN  
         LEAVE pos;
      END IF; 
         SELECT COUNT(*) INTO c 
         FROM student 
         WHERE zno=zid;
         
         UPDATE specialty 
         SET member_count=c 
         WHERE zno=zid;         

      END WHILE ;
CLOSE cur;
END $$
DELIMITER;

CALL count_member;

     	
SELECT 	* FROM specialty;     	


SHOW CREATE PROCEDURE count_member;  

-- ------------------------------
SELECT @x:=1,@y:=2;
SELECT @x+@y;

