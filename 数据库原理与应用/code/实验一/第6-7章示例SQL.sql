SHOW VARIABLES LIKE '%datadir%'

SHOW VARIABLES LIKE '%basedir%'

-----------------------------------
 
SHOW TABLE STATUS FROM `mysql`;

SHOW TABLE STATUS FROM `information_schema`;

SHOW TABLE STATUS FROM `performance_schema`;

SHOW TABLE STATUS FROM `sys`;

-----------------------------------
CREATE DATABASE mytest;

SHOW VARIABLES LIKE 'performance_schema';


SHOW CHARACTER SET;

SHOW COLLATION;

SHOW VARIABLES LIKE 'character_set_database';
-- 查询当前数据库的字符集

SHOW VARIABLES LIKE 'collation_database';
-- 查询当前数据库的排序规则

-- -----------------------------------
-- -----------------------------------
-- 实际应用时，表名、列名都不要用汉字
-- 要注意恰当的数据库名、表名、列名
-- -----------------------------------



-- 创建示例数据库——cjgl
CREATE DATABASE IF NOT EXISTS cjgl 
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_0900_as_cs;

-- 修改示例数据库——cjgl
ALTER DATABASE cjgl 
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_0900_as_cs;   -- 这种编码区分大小写
/*  ai_ci, i是指insensitive,不敏感
ai是指accent insensitive,重读不敏感
ci是指case insensitive. 也就是说默认的字符集校验不区分大小写，
如果区分重音、大小写，可以使用utf8mb4_0900_as_cs
*/


-- 删除示例数据库——cjgl
DROP DATABASE cjgl; 

SHOW CREATE DATABASE cjgl; 


-- ----------------------------------

USE cjgl;  -- 切换当前数据库

-- 创建表


-- -------------------------------------
-- Table structure for specialty  专业表
-- -------------------------------------
CREATE TABLE specialty (
  zno VARCHAR(4) NOT NULL COMMENT'专业号',
  zname VARCHAR(20) COMMENT'专业名',
  PRIMARY KEY (zno)
) ENGINE=INNODB  COMMENT='专业表';

DROP TABLE specialty;

CREATE TABLE specialty (
  zno VARCHAR(4) NOT NULL,
  zname VARCHAR(20),
  PRIMARY KEY (zno)
) ENGINE=INNODB ;

DROP TABLE specialty;

CREATE TABLE specialty (
  zno VARCHAR(4)  PRIMARY KEY,
  zname VARCHAR(20) 
);



-- --------------------------------------
-- Table structure for student  学生表
-- --------------------------------------

CREATE TABLE student (
  sno VARCHAR(10)  NOT NULL COMMENT '学号',
  sname VARCHAR(20)  NOT NULL COMMENT '姓名',
  ssex CHAR(1)  NOT NULL DEFAULT'男' COMMENT '性别',
  sbirth DATE COMMENT '出生日期',
  zno VARCHAR(4)   COMMENT'专业号',
  sclass VARCHAR(10)   COMMENT'班级',
  PRIMARY KEY (sno),  -- 定义主键
  KEY (zno),      -- 定义索引
  FOREIGN KEY (zno) REFERENCES specialty(zno) -- 定义外键
) ENGINE=INNODB ;


DROP TABLE  student;

-- ----------------------------
-- Table structure for course 课程表
-- ----------------------------
DROP TABLE IF EXISTS course;

CREATE TABLE course (
  cno VARCHAR(8)  NOT NULL COMMENT'课程号',
  cname VARCHAR(30) NOT NULL COMMENT'课程名',
  ccredit TINYINT COMMENT'学分',
  cdept VARCHAR(20) COMMENT'授课学院',
  PRIMARY KEY (cno)
) ENGINE=INNODB ;


-- ----------------------------
-- Table structure for sc 选课表
-- ----------------------------
DROP TABLE IF EXISTS sc;

CREATE TABLE sc (
  sno VARCHAR(10)  NOT NULL COMMENT'学号',
  cno VARCHAR(8)  NOT NULL COMMENT'课程号',
  grade TINYINT  COMMENT'成绩',
  PRIMARY KEY (sno,cno),
  FOREIGN KEY (cno) REFERENCES course(cno),
  FOREIGN KEY (sno) REFERENCES student(sno)
)  COMMENT='选修表';


-- --------------------------------------------
-- 关于自增列、整型、精确小数、浮点数

DROP DATABASE mydb;

CREATE DATABASE mydb;

USE mydb;


-- DROP TABLE t1;

-- 自增列、整型、精确小数、浮点数

CREATE TABLE t1 (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, -- 自增列
  xm VARCHAR(10),
  score INT UNSIGNED,
  PRIMARY KEY (id)
) ENGINE=INNODB;


-- 插入几行数据
INSERT INTO t1(xm,score) VALUES('wang',95);

INSERT INTO t1(xm,score) VALUES('liu',88);


SELECT * FROM t1;     

DELETE FROM t1 WHERE id=2;

INSERT INTO t1(xm,score) VALUES('gao',84);

SELECT * FROM t1;
    


-- -------------------------------------------------
-- 以下是创建4个表的创建语句和插入数据的语句

-- -------------------------------------
-- Table structure for specialty  专业表
-- -------------------------------------
DROP TABLE IF EXISTS specialty;

CREATE TABLE specialty (
  zno VARCHAR(4) NOT NULL COMMENT'专业号',
  zname VARCHAR(20) COMMENT'专业名',
  PRIMARY KEY (zno)
) ENGINE=INNODB  COMMENT='专业表';

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



-- --------------------------------------
-- Table structure for student  学生表
-- --------------------------------------
DROP TABLE IF EXISTS student;

CREATE TABLE student (
  sno VARCHAR(10)  NOT NULL COMMENT '学号',
  sname VARCHAR(20)  NOT NULL COMMENT '姓名',
  ssex CHAR(1)  NOT NULL DEFAULT'男' COMMENT '性别',
  sbirth DATE COMMENT '出生日期',
  zno VARCHAR(4)   COMMENT'专业号',
  sclass VARCHAR(10)   COMMENT'班级',
  PRIMARY KEY (sno),  -- 定义主键
  KEY (zno),      -- 定义索引
  FOREIGN KEY (zno) REFERENCES specialty(zno) -- 定义外键
) ENGINE=INNODB ;

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


-- ----------------------------
-- Table structure for course 课程表
-- ----------------------------
DROP TABLE IF EXISTS course;

CREATE TABLE course (
  cno VARCHAR(8)  NOT NULL COMMENT'课程号',
  cname VARCHAR(30) NOT NULL COMMENT'课程名',
  ccredit TINYINT COMMENT'学分',
  cdept VARCHAR(20) COMMENT'授课学院',
  PRIMARY KEY (cno)
) ENGINE=INNODB ;


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
-- Table structure for sc 选课表
-- ----------------------------
DROP TABLE IF EXISTS sc;




CREATE TABLE sc (
  sno VARCHAR(10)  NOT NULL COMMENT'学号',
  cno VARCHAR(8)  NOT NULL COMMENT'课程号',
  grade TINYINT  COMMENT'成绩',
  PRIMARY KEY (sno,cno),
  FOREIGN KEY (cno) REFERENCES course(cno),
  FOREIGN KEY (sno) REFERENCES student(sno)
)  COMMENT='选修表';

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



-- 删除表

DROP TABLE sc;

DROP TABLE course;

DROP TABLE specialty;

DROP TABLE student;




