SHOW VARIABLES LIKE 'log_error';

SHOW VARIABLES LIKE '%log_bin%';

SHOW VARIABLES LIKE 'slow_query%'; 

SHOW TABLES FROM schoolinfo;

mysqldump -uroot -p -F schoolinfo > C:/bak_schoolinfo.sql

SHOW MASTER LOGS;
SHOW MASTER STATUS;
SHOW BINLOG EVENTS IN 'binlog.000030';

 CREATE TABLE IF NOT EXISTS schoolinfo .stuinfo (
          `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
          `name` VARCHAR(16) NOT NULL,
          `sex` ENUM('m','w') NOT NULL DEFAULT 'm',
          `age` TINYINT(3) UNSIGNED NOT NULL,
          `classid` CHAR(6) DEFAULT NULL,
          PRIMARY KEY (`id`)
         ) ENGINE=INNODB DEFAULT CHARSET=utf8;
         
         
         
         INSERT INTO schoolinfo.stuinfo(`name`,`sex`,`age`,`classid`) 
VALUES('yiyi','w',20,'cls1'),
('xiaoer','m',22,'cls3'),
('zhangsan','w',21,'cls5'),
('lisi','m',20,'cls4'),
('wangwu','w',26,'cls6');

SHOW TABLES FROM schoolinfo;


DROP DATABASE schoolinfo;

 SHOW BINLOG EVENTS IN 'binlog.000036';
 
 
FLUSH LOGS;
SHOW MASTER STATUS;

SHOW BINLOG EVENTS IN 'binlog.000039';
SHOW VARIABLES LIKE '%log_bin%';


 CREATE TABLE IF NOT EXISTS schoolinfo .stuinfo (
          `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
          `name` VARCHAR(16) NOT NULL,
          `sex` ENUM('m','w') NOT NULL DEFAULT 'm',
          `age` TINYINT(3) UNSIGNED NOT NULL,
          `classid` CHAR(6) DEFAULT NULL,
          PRIMARY KEY (`id`)
         ) ENGINE=INNODB DEFAULT CHARSET=utf8;
         
         
INSERT INTO schoolinfo.stuinfo(`name`,`sex`,`age`,`classid`) 
VALUES('yiyi','w',20,'cls1'),
('xiaoer','m',22,'cls3'),
('zhangsan','w',21,'cls5'),
('lisi','m',20,'cls4'),
('wangwu','w',26,'cls6');
         

SHOW TABLES FROM schoolinfo;
DROP DATABASE schoolinfo;
SHOW BINLOG EVENTS IN 'binlog.000039';
FLUSH LOGS;
SHOW MASTER STATUS;

SHOW BINLOG EVENTS IN 'binlog.000039';


mysqlbinlog --stop-POSITION=1147 --database=schoolinfo 'C:\ProgramData\MySQL\MySQL SERVER 8.0\DATA\binlog.000039' | mysql -uroot -p schoolinfo

mysqlbinlog  --stop - POSITION =1147 --database=schoolinfo C:\ProgramData\MySQL\MySQL SERVER 8.0\DATA \binlog.000039| mysql -uroot -p schoolinfo

`schoolinfo`\
mysqlbinlog --stop-POSITION=1147 --database=schoolinfo C:/ProgramData/MySQL/MySQL SERVER 8.0/DATA/binlog.000039 | mysql -uroot -p schoolinfo
C:\ProgramData\MySQL\MySQL SERVER 8.0\DATA

mysqlbinlog --stop-POSITION=1147 --database=schoolinfo 'C:\ProgramData\MySQL\MySQL SERVER 8.0\DATA'  | mysql -uroot -p schoolinfo

mysqlbinlog --stop-POSITION=1147 --database=schoolinfo "C:\ProgramData\MySQL\MySQL Server 8.0\Data\binlog.000039" | mysql -uroot -p schoolinfo

mysqlbinlog --stop-POSITION=1147 --database=schoolinfo "C:\ProgramData\MySQL\MySQL Server 8.0\Data\binlog.000039" | mysql -uroot -p schoolinfo

三、数据导出导入操作
1．执行如下语句，并记下查询结果：
USE cjgl;
SELECT * FROM sc;
2．写出并执行SELECT…INTO  OUTFILE来导出sc表中的记录，存储在c:\backup文件夹下sc_data.txt中，其中字段分隔用，、字符串界符用”、记录行分隔用#。
SELECT * FROM cjgl.sc
INTO OUTFILE 'c:/backup/backupdata_sc.txt'
FIELDS TERMINATED BY ','  
OPTIONALLY ENCLOSED BY '"'  LINES TERMINATED BY '#';



3．先删除sc表的全部数据，然后写出并执行load data语句向sc表导入数据。
DELETE FROM cjgl.sc;

LOAD DATA INFILE  'c:/backup/backupdata_sc.txt'  
INTO TABLE  cjgl.sc 
FIELDS TERMINATED BY ','  
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '#'; 


四、记录下列查询语句的查找行数
USE cjgl;
EXPLAIN SELECT * FROM cjgl.student WHERE sname='孙一凯';      -- rows= ____16________  
CREATE INDEX idx_sname ON cjgl.student(sname);     -- rows= ____________
EXPLAIN SELECT * FROM cjgl.student WHERE sname='孙一凯';     -- rows= __1__________
EXPLAIN SELECT * FROM cjgl.student WHERE sname='孙';     -- rows= _____1_______
EXPLAIN SELECT * FROM cjgl.student WHERE sname LIKE '%孙';     -- rows= _16___________
EXPLAIN SELECT * FROM cjgl.student WHERE sname LIKE '孙%';     -- rows= __1__________
EXPLAIN SELECT * FROM cjgl.student WHERE sname='孙一凯'OR zno='1309070338';     -- rows= _2______
EXPLAIN SELECT * FROM cjgl.student WHERE sname='孙一凯'OR ssex='男';     -- rows= ____16________
EXPLAIN SELECT sname FROM student  WHERE sno IN (SELECT sno FROM sc WHERE grade>90);   -- rows= __1，14_
EXPLAIN SELECT sname FROM student  INNER JOIN sc  USING(sno) WHERE grade>90;       -- rows= ___14，1___ 
 
五、事务应用：创建存储过程，模拟银行转账事务
1.创建以你自己姓名全拼命名的数据库，然后选用该数据库成为当前数据库
CREATE DATABASE chenlong;
2.执行下面的语句，创建account表，并添加数据
CREATE TABLE account(aID CHAR(10) PRIMARY KEY,aname CHAR(10),balance INT );
INSERT INTO account VALUES('001','张三',30000);
INSERT INTO account VALUES('002','李四',50000);
3.创建存储过程transferMoney，有三个输入参数：A_account、B_account、money，存储过程完成的功能是由A账户转给B账户money元。（要求运用事务）
DELIMITER $$  
CREATE  PROCEDURE  transferMoney
(IN A_account CHAR(10),IN B_account CHAR(10),IN money INT(10) )                   -- 不一定都要输出参数
BEGIN
START TRANSACTION;  

UPDATE account	SET balance=balance-money WHERE aID=A_account;
UPDATE account	SET balance=balance+money WHERE aID=B_account;
COMMIT;

END $$ 
DELIMITER ; 

4.调用执行存储过程transferMoney，由'002'账户转给'001'账户500元。  
CALL transferMoney('002','001',500)
实验总结：实验中遇到的主要问题及解决方法：
SELECT *FROM account;

 
 
 