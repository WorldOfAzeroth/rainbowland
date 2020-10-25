-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: auth
-- ------------------------------------------------------
/*!40000 ALTER TABLE `account` DISABLE KEYS */;

DELETE FROM `account` WHERE `username` IN('test1','test2','test3','test4','test5','test6','test7','test8','test9','test10','JORGIE','rainbowland');

INSERT INTO `account` VALUES (1,'test1','047ce22643f9b0bd6baeb18d51bf1075a4d43fc6','','','','','','','2016-01-30 21:09:43','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0),
(11,'ROOT','0F597D6EC826A438DF8A148D2DCD0267E1E3B840','','','','','','','2020-10-13 14:32:59','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0),
(12,'GMASTER','FA35B443A26AD865A50628E4410BF1503AD12BA1','','','','','','','2020-10-13 14:34:04','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0);
