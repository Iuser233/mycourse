/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 8.0.11 : Database - cjgl
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`cjgl` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs */;

USE `cjgl`;

/*Table structure for table `course` */

DROP TABLE IF EXISTS `course`;

CREATE TABLE `course` (
  `cno` varchar(8) COLLATE utf8mb4_0900_as_cs NOT NULL COMMENT '课程号',
  `cname` varchar(30) COLLATE utf8mb4_0900_as_cs NOT NULL COMMENT '课程名',
  `ccredit` tinyint(3) unsigned DEFAULT NULL COMMENT '学分',
  `cdept` varchar(20) COLLATE utf8mb4_0900_as_cs DEFAULT NULL COMMENT '授课学院',
  PRIMARY KEY (`cno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_as_cs;

/*Data for the table `course` */

insert  into `course`(`cno`,`cname`,`ccredit`,`cdept`) values ('11110140','管理信息系统',3,'经济管理学院'),('11110470','统计学A',3,'经济管理学院'),('11110930','电子商务',2,'经济管理学院'),('11111260','客户关系管理',2,'经济管理学院'),('11140260','网站规划与运营实训',2,'信息学院'),('18110140','C语言程序设计',3,'信息学院'),('18111850','数据库原理',3,'信息学院'),('18112820','网站设计与开发',2,'信息学院'),('18130320','Internet技术及应用',2,'信息学院'),('18132220','数据库技术及应用',2,'信息学院'),('18132370','Java程序设计',2,'信息学院'),('18132600','数据库原理与应用A',3,'信息学院'),('58130060','ASP.NET程序设计',3,'信息学院'),('58130540','计算机应用软件',3,'信息学院');

/*Table structure for table `sc` */

DROP TABLE IF EXISTS `sc`;

CREATE TABLE `sc` (
  `sno` varchar(10) COLLATE utf8mb4_0900_as_cs NOT NULL COMMENT '学号',
  `cno` varchar(8) COLLATE utf8mb4_0900_as_cs NOT NULL COMMENT '课程号',
  `grade` tinyint(3) unsigned DEFAULT NULL COMMENT '成绩',
  PRIMARY KEY (`sno`,`cno`),
  KEY `cno` (`cno`),
  CONSTRAINT `sc_ibfk_1` FOREIGN KEY (`cno`) REFERENCES `course` (`cno`),
  CONSTRAINT `sc_ibfk_2` FOREIGN KEY (`sno`) REFERENCES `student` (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_as_cs COMMENT='选修表';

/*Data for the table `sc` */

insert  into `sc`(`sno`,`cno`,`grade`) values ('1114070116','11110930',65),('1114070116','18130320',90),('1411855228','18132220',96),('1411855321','11110470',69),('1412855223','18130320',60),('1412855223','58130540',77),('1414855302','11110140',90),('1414855328','18130320',96),('1414855328','58130540',85),('1414855406','11110470',86),('1414855406','18110140',75),('1414855406','18132220',84),('1418855232','18110140',87),('1418855232','58130540',91);

/*Table structure for table `specialty` */

DROP TABLE IF EXISTS `specialty`;

CREATE TABLE `specialty` (
  `zno` varchar(4) COLLATE utf8mb4_0900_as_cs NOT NULL COMMENT '专业号',
  `zname` varchar(20) COLLATE utf8mb4_0900_as_cs DEFAULT NULL COMMENT '专业名',
  PRIMARY KEY (`zno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_as_cs COMMENT='专业表';

/*Data for the table `specialty` */

insert  into `specialty`(`zno`,`zname`) values ('1102','电子商务'),('1103','会计学'),('1201','法学'),('1214','信息管理与信息系统'),('1407','工商管理'),('1409','会计学'),('1601','食品科学与工程'),('1805','计算机科学与技术'),('1807','信息管理与信息系统');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `sno` varchar(10) COLLATE utf8mb4_0900_as_cs NOT NULL COMMENT '学号',
  `sname` varchar(20) COLLATE utf8mb4_0900_as_cs NOT NULL COMMENT '姓名',
  `ssex` char(1) COLLATE utf8mb4_0900_as_cs NOT NULL DEFAULT '男' COMMENT '性别',
  `sbirth` date DEFAULT NULL COMMENT '出生日期',
  `zno` varchar(4) COLLATE utf8mb4_0900_as_cs DEFAULT NULL COMMENT '专业号',
  `sclass` varchar(10) COLLATE utf8mb4_0900_as_cs DEFAULT NULL COMMENT '班级',
  PRIMARY KEY (`sno`),
  KEY `zno` (`zno`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`zno`) REFERENCES `specialty` (`zno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_as_cs;

/*Data for the table `student` */

insert  into `student`(`sno`,`sname`,`ssex`,`sbirth`,`zno`,`sclass`) values ('1114070116','欧阳宝贝','女','1997-01-08','1407','工商1401'),('1207040137','张冰霜','女','1996-05-23','1214','信管1201'),('1309070338','孙一凯','男','1993-10-11','1102','商务1301'),('1411855228','唐晓','女','1997-11-05','1102','商务1401'),('1411855321','蓝梅','女','1997-07-02','1102','商务1401'),('1411855426','余小梅','女','1997-06-18','1102','商务1401'),('1412855223','徐美利','女','1989-09-07','1214','信管1401'),('1412855313','郭爽','女','1995-02-14','1601','食品1401'),('1414320425','曹平','女','1997-12-14','1407','工商1401'),('1414855302','李壮','男','1996-01-17','1409','会计1401'),('1414855308','马琦','男','1996-06-14','1409','会计1401'),('1414855328','刘梅红','女','1991-06-12','1407','工商1401'),('1414855406','王承','男','1996-10-06','1409','会计1401'),('1416855305','聂鹏飞','男','1997-08-25','1601','食品1401'),('1418855212','李冬旭','男','1996-06-08','1805','计算1401'),('1418855232','王琴雪','女','1997-07-20','1805','计算1401');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
