USE cjgl;

SELECT * FROM  specialty;

SELECT * FROM  student;

SELECT * FROM  course;

SELECT * FROM  sc;

SHOW CREATE TABLE `specialty`;

SHOW CREATE TABLE `student`;

SHOW CREATE TABLE `course`;

SHOW CREATE TABLE `sc`;

-- ================================
-- 教材第8章 1-3节语句
-- ================================
-- 注意各种类型数据的表示：语句中、图形界面中


-- -----------------------------------
-- insert 语句 插入一行或多行数据（）
-- -----------------------------------

--  执行试试
INSERT INTO student 
VALUES ('1411855426','余小梅','女','1997-06-18', '1102','商务1401');

-- 先要有这个专业：商务1102
INSERT INTO specialty VALUES ('1102','电子商务');


INSERT INTO student(sno,sname,ssex,sbirth,zno,sclass)
VALUES ('1418855234','李三','男','1996-07-08', '1102','商务1301');
-- 列名不一定按顺序写

INSERT INTO student(sno,sname) -- 其余字段要允许空值或有默认值
VALUES ('1411855228','唐晓');

SELECT * FROM  student;
-- 后输入的唐晓为什么显示在前面;
-- 记录的顺序默认按主键列升序排列[因为有聚簇索引]

-- 其余字段要允许空值
INSERT INTO student(sno,sname,ssex,sbirth)
VALUES ('1418855236','张强','男','1996-3-15');

INSERT INTO student(sno,sname,ssex,sbirth) -- 同时插入两行
VALUES ('1418855241','李凯','男','1996-5-23'),
 ('1418855242','李蒙','男','1996-7-10');

SELECT * FROM  student;


-- ------------------------------
-- update 语句；修改字段值
-- ------------------------------

UPDATE student
SET sname='李凯轩',sbirth=NULL  -- 修改为空值
WHERE sno='1418855241';         -- WHERE的作用

SELECT * FROM  student;


UPDATE student      -- 能否去掉WHERE？
SET sname='李凯轩';

-- 能否撤销修改？


UPDATE student1 
SET sage=sage+1;


-- ------------------------------
-- delete 语句
-- ------------------------------

DELETE FROM  student 
WHERE zno IS NULL AND sname='李凯轩';

DELETE FROM specialty 
WHERE zname='电子商务';
-- 注意外键约束


DELETE FROM  student 
WHERE sno='1418855242';

-- 注意sc表的外键约束

DELETE FROM  student 


-- ---------------------
-- truncate table 语句
-- ---------------------

CREATE DATABASE mydb;

USE  mydb;

CREATE TABLE t(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
NAME VARCHAR(20));

INSERT INTO t(NAME) VALUES('wang'),('liu');

SELECT * FROM t;

DELETE FROM t;

TRUNCATE TABLE t;     -- 注意表名的这种写法
 

TRUNCATE TABLE mydb.t;


-- =====================
-- 以下是创建4个表的创建语句和插入数据的语句

-- -------------------------------------
-- Table structure for specialty  专业表
-- -------------------------------------


DELETE  FROM `student`;    -- 注意两句执行的先后顺序
DELETE  FROM `specialty`; 

-- ----------------------------
-- Insert Records of specialty
-- ----------------------------
INSERT INTO specialty VALUES ('1102','电子商务');

INSERT INTO specialty VALUES ('1103','会计学');

INSERT INTO specialty VALUES ('1201','法学');

INSERT INTO specialty VALUES ('1214','信息管理与信息系统');

INSERT INTO specialty VALUES ('1407','工商管理');

INSERT INTO specialty VALUES ('1409','会计学');

INSERT INTO specialty VALUES ('1601','食品科学与工程');

INSERT INTO specialty VALUES ('1805','计算机科学与技术');

INSERT INTO specialty VALUES ('1807','信息管理与信息系统');


SELECT * FROM specialty;



-- -----------------------------------
--  Insert Records of student  学生表中的记录
-- -----------------------------------
INSERT INTO student 
VALUES('1114070116','欧阳宝贝','女','1997-01-08', '1407','工商1401');

INSERT INTO student 
VALUES('1207040137','张冰霜','女','1996-05-23', '1214','信管1201');

INSERT INTO student 
VALUES('1309070338','孙一凯','男','1993-10-11', '1102','商务1301');

INSERT INTO student 
VALUES('1411855228','唐晓','女','1997-11-05', '1102','商务1401');

INSERT INTO student
VALUES('1411855321','蓝梅','女','1997-07-02', '1102','商务1401');

INSERT INTO student
VALUES('1411855426','余小梅','女','1997-06-18', '1102','商务1401');

INSERT INTO student
VALUES('1412855223','徐美利','女','1989-09-07', '1214','信管1401');

INSERT INTO student
VALUES('1412855313','郭爽','女','1995-02-14', '1601','食品1401');

INSERT INTO student
VALUES('1414320425','曹平','女','1997-12-14', '1407','工商1401');

INSERT INTO student
VALUES('1414855302','李壮','男','1996-01-17', '1409','会计1401');

INSERT INTO student
VALUES('1414855308','马琦','男','1996-06-14', '1409','会计1401');

INSERT INTO student
VALUES('1414855328','刘梅红','女','1991-06-12', '1407','工商1401');

INSERT INTO student
VALUES('1414855406','王承','男','1996-10-06', '1409','会计1401');

INSERT INTO student
VALUES('1416855305','聂鹏飞','男','1997-08-25', '1601','食品1401');

INSERT INTO student
VALUES('1418855212','李冬旭','男','1996-06-08', '1805','计算1401');

INSERT INTO student
VALUES('1418855232','王琴雪','女','1997-07-20', '1805','计算1401');


SELECT * FROM student;


-- -------------------------------
-- Records of course 课程表中的记录
-- -------------------------------
INSERT INTO course
VALUES('11110140','管理信息系统','3','经济管理学院');

INSERT INTO course
VALUES('11110470','统计学A','3','经济管理学院');

INSERT INTO course
VALUES('11110930','电子商务','2','经济管理学院');

INSERT INTO course
VALUES('11111260','客户关系管理','2','经济管理学院');

INSERT INTO course
VALUES('11140260','网站规划与运营实训','2','信息学院');

INSERT INTO course
VALUES('18110140','C语言程序设计','3','信息学院');

INSERT INTO course
VALUES ('18111850','数据库原理','3','信息学院');

INSERT INTO course
VALUES ('18112820','网站设计与开发','2','信息学院');

INSERT INTO course
VALUES ('18130320','Internet技术及应用','2','信息学院');

INSERT INTO course
VALUES ('18132220','数据库技术及应用','2','信息学院');

INSERT INTO course
VALUES ('18132370','Java程序设计','2','信息学院');

INSERT INTO course
VALUES ('18132600','数据库原理与应用A','3','信息学院');

INSERT INTO course
VALUES ('58130060','ASP.NET程序设计','3','信息学院');

INSERT INTO course
VALUES ('58130540','计算机应用软件','3','信息学院');

SELECT * FROM course;

-- ----------------------------
-- Records of sc 选课表的数据
-- ----------------------------
INSERT INTO sc VALUES ('1414855328','58130540','85');

INSERT INTO sc VALUES ('1414855406','18110140','75');

INSERT INTO sc VALUES ('1412855223','18130320','60');

INSERT INTO sc VALUES ('1114070116','11110930','65');

INSERT INTO sc VALUES ('1414855302','11110140','90');

INSERT INTO sc VALUES ('1411855228','18132220','96');

INSERT INTO sc VALUES ('1418855232','18110140','87');

INSERT INTO sc VALUES ('1414855328','18130320','96');

INSERT INTO sc VALUES ('1414855406','11110470','86');

INSERT INTO sc VALUES ('1412855223','58130540','77');

INSERT INTO sc VALUES ('1414855406','18132220','84');

INSERT INTO sc VALUES ('1114070116','18130320','90');

INSERT INTO sc VALUES ('1411855321','11110470','69');

INSERT INTO sc VALUES ('1418855232','58130540','91');

SELECT * FROM SC