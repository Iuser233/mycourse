-- ---------------------------------

USE `books`;

-- 【例1】在命令行界面使用mysqldump备份数据库cjgl中的表`sc`  -- 注意mysqldump.exe在bin下
mysqldump -hlocalhost -uroot -p  cjgl sc>c:\BACKUP\cjgl_sc.sql 


-- 【例2】备份数据库cjgl到C盘backup目录下。
mysqldump -hlocalhost -uroot -p  cjgl>c:\BACKUP\cjgl.Sql

-- 或 

mysqldump -hlocalhost -uroot -p  --databases cjgl>c:\BACKUP\cjgl.Sql


-- 【例3】备份所有数据库到C盘backup目录下db.Sql中。
 -- mysqldump -hlocalhost -uroot -p --all-databases>c:\BACKUP\db.Sql  
-- [注意命令行状态下，DATABASES要小写]







-- ================还原/恢复

DROP DATABASE CJGL;

-- 【例4】假设数据库cjgl遭遇损坏，试用该数据库的备份文件将其恢复。
mysqladmin -uroot -p  CREATE cjgl    -- 先创建数据库 

mysql -u root -p  cjgl<c:\BACKUP\cjgl.Sql


SELECT * FROM SC;

-- 【例5】假设数据库cjgl中表sc的表被损坏，试将备份文件c:\BACKUP\cjgl_sc.sql恢复该表。
mysql -u root -p cjgl< c:\BACKUP\cjgl_sc.sql





-- 查看 secure-file-priv 当前的值是什么
SHOW VARIABLES LIKE '%secure%'; 


# 注意先修改my.ini，修改后重启MYSQL
# 将   secure-file-priv="C:/ProgramData/MySQL/MySQL Server 8.0/Uploads"
# 修改为   secure-file-priv=




-- 【例7】备份数据库cjgl中表sc的全部数据到c盘的backup目录下一个名为backupdata_sc.txt的文件中

SELECT * FROM cjgl.sc
INTO OUTFILE 'c:/backup/backupdata_sc.txt'
FIELDS TERMINATED BY ','  
OPTIONALLY ENCLOSED BY '"'  LINES TERMINATED BY '?';


DELETE FROM cjgl.sc;


SELECT * FROM cjgl.sc;


-- 使用load data 导入数据
LOAD DATA INFILE  'c:/backup/backupdata_sc.txt'  
INTO TABLE  cjgl.sc 
FIELDS TERMINATED BY ','  
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '?'; 

SELECT * FROM sc;


-- ===============第16章 日志

-- 错误日志

-- #查看当前的错误日志配置——存储位置
SHOW VARIABLES LIKE 'log_error';


-- 二进制日志

-- 开启--------------------------

-- 通过my.ini的log-bin选项可以开启二进制日志

-- 系统变量log_bin的值为OFF表示没有开启二进制日志（binary log）。
-- ON表示开启了二进制日志（binary log）

SHOW VARIABLES LIKE 'log_bin';   -- 查看是否开启

SHOW VARIABLES LIKE 'datadir';

SHOW VARIABLES LIKE '%log_bin%';   -- 查看二进制日志的默认存放位置



-- 查看

-- 查看当前服务器所有的二进制日志文件
SHOW BINARY LOGS;

-- 还可以使用下面命令查看
SHOW MASTER LOGS;

-- 查看当前二进制日志文件状态
 SHOW MASTER STATUS;
 
 -- 查看第一个binlog文件的内容
 SHOW BINLOG EVENTS
 
USE books;
SELECT * FROM book;
INSERT INTO book(bookno,bookname) VALUES('TP8866','mysql手册');
 
 -- 查看某个特定binglog文件的内容
SHOW BINLOG EVENTS IN 'binlog.000005';
-- SHOW BINLOG EVENTS IN 'binlog.000078'
 
-- mysqlbinlog D:\mysql\mysql-5.6.17-winx64\DATA\mysql_bin_log.000001;  --命令行命令
 
 FLUSH LOGS;  /* 产生一个新的binlog日志文件 */
 
 SHOW MASTER LOGS;
 
-- SHOW BINLOG EVENTS IN 'mysql_bin_log.000002';
 
INSERT INTO book(bookno,bookname) VALUES('TP888888','JAVA程序设计'); 
-- 新操作记入新日志文件中

SELECT * FROM  book;

SHOW BINLOG EVENTS IN 'binlog.000006';
  
  
  
 
 -- 删除二进制日志
 
 SHOW MASTER LOGS;
 
-- 删除某个日志之前的所有二进制日志文件。
PURGE BINARY LOGS TO 'binlog.000006';

SHOW BINLOG EVENTS IN 'binlog.000001';

RESET MASTER ;

SHOW BINLOG EVENTS IN 'binlog.000001';




-- 慢日志
SHOW VARIABLES LIKE 'slow%'; 
 

SET GLOBAL slow_query_log=ON;  -- 若慢日志文件不存在，开启时将重建日志文件

SET GLOBAL slow_launch_time=10;

SHOW VARIABLES LIKE '%log_output%';

-- 设置日志输出为表方式：
 SET GLOBAL log_output='TABLE';


SHOW VARIABLES LIKE '%log_output%';

SELECT * FROM cjgl.student WHERE `sclass`='计算1401';

-- SET GLOBAL log_queries_not_using_indexes = ON;-- 是否打开看个人需要
SET GLOBAL log_queries_not_using_indexes = ON;    -- 将不用索引的查询记入慢日志

SELECT * FROM  mysql.slow_log;


SET GLOBAL slow_query_log=Off;  -- 先关闭慢日志表

TRUNCATE TABLE mysql.slow_log;   -- 再清空慢日志表



-- 通用日志

-- 可以查看当前的通用日志查询是否开启，如果general_log的值为ON则为开启，为OFF则为关闭（默认情况下是关闭的）。
SHOW VARIABLES LIKE '%general%';

-- 开启通用日志查询：
 SET GLOBAL general_log=ON;

-- 关闭通用日志查询： set globalgeneral_log=off;

-- 设置通用日志输出为表方式：
 SET GLOBAL log_output='TABLE';

-- 设置通用日志输出为文件方式： 
SET GLOBAL log_output='FILE';

USE CJGL;

SELECT * FROM CJGL.SC;

SELECT * FROM MYSQL.general_log;

SET GLOBAL general_log=OFF;         
 
TRUNCATE TABLE MYSQL.general_log;  -- 清空日志表






-- 清理日志：
-- 对于上述两种日志，系统默认不会清理，因此在开启了相关日志之后，需要人为清理。
 
-- 输出目标为表的时候
-- 无法直接删除，如果直接删除的话，会出现“ERROR 1556 (HY000): You can’t use locks with log tables.”的错误提示
-- 以general log为例，需要先关闭general_log，然后重命名general_log这个表，
-- 再对重命名之后的表执行删除，最后在重命名回来，最后开启general_log（如果有必要的话）

--  当输出目标为文件的时候，直接使用命令删除即可