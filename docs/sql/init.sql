CREATE DATABASE  IF NOT EXISTS `bbs` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bbs`;
-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (x86_64)
--
-- Host: 127.0.0.1    Database: bbs
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cms_nav`
--

DROP TABLE IF EXISTS `cms_nav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_nav` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `label` char(45) NOT NULL,
  `index` int DEFAULT '1',
  `type` int DEFAULT NULL COMMENT '导航栏类型：1-内部导航 2-站外导航',
  `url` char(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Navigation bar configuration data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_nav`
--

LOCK TABLES `cms_nav` WRITE;
/*!40000 ALTER TABLE `cms_nav` DISABLE KEYS */;
INSERT INTO `cms_nav` VALUES (1,'首页',1,1,'#'),(2,'课程',2,2,'https://www.baidu.com');
/*!40000 ALTER TABLE `cms_nav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(45) NOT NULL,
  `content` longtext,
  `author_id` int NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` varchar(45) DEFAULT NULL,
  `abstract` varchar(45) DEFAULT NULL,
  `tag_id` int DEFAULT NULL,
  `category` int DEFAULT NULL,
  `comment_num` int DEFAULT '0',
  `like_num` int DEFAULT '0',
  `read_num` int DEFAULT '0',
  `collection_num` int DEFAULT '0',
  `cover` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'小米 SU7 发布','北京小米汽车公司发他的收款汽车品牌',0,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL),(2,'刘翔冲过了终点站',NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL),(3,'孙扬面临被国际奥委会禁赛 10 年的处罚',NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL),(4,'警方通报水泥分尸案',NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL),(5,'小黄人运营是快秘书团队倾力打造的营销工具，使用 LLM 技术',NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL),(6,'徐萌萌是以为游戏兼颜值博主',NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL),(7,'营销矩阵是要怎么搭建呢，这 3 种方式帮助你快速搭建',NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_member`
--

DROP TABLE IF EXISTS `ums_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_member` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_level_id` bigint DEFAULT NULL,
  `username` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '密码',
  `nickname` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '昵称',
  `phone` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '手机号码',
  `status` int DEFAULT NULL COMMENT '帐号启用状态:0->禁用；1->启用',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  `icon` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '头像',
  `gender` int DEFAULT NULL COMMENT '性别：0->未知；1->男；2->女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `city` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '所做城市',
  `job` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '职业',
  `personalized_signature` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '个性签名',
  `source_type` int DEFAULT NULL COMMENT '用户来源',
  `integration` int DEFAULT NULL COMMENT '积分',
  `growth` int DEFAULT NULL COMMENT '成长值',
  `luckey_count` int DEFAULT NULL COMMENT '剩余抽奖次数',
  `history_integration` int DEFAULT NULL COMMENT '历史积分数量',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_username` (`username`) USING BTREE,
  UNIQUE KEY `idx_phone` (`phone`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='会员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_member`
--

LOCK TABLES `ums_member` WRITE;
/*!40000 ALTER TABLE `ums_member` DISABLE KEYS */;
INSERT INTO `ums_member` VALUES (1,4,'test','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','test','18061581849',1,'2018-08-02 10:35:44','https://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/icon/github_icon_03.png',1,'2009-06-01','上海','学生','test',NULL,3900,1000,NULL,NULL),(3,4,'windy','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','windy','18061581848',1,'2018-08-03 16:46:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,4,'zhengsan','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','zhengsan','18061581847',1,'2018-11-12 14:12:04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,4,'lisi','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','lisi','18061581841',1,'2018-11-12 14:12:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,4,'wangwu','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','wangwu','18061581842',1,'2018-11-12 14:13:09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,4,'lion','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','lion','18061581845',1,'2018-11-12 14:21:39',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,4,'shari','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','shari','18061581844',1,'2018-11-12 14:22:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,4,'aewen','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','aewen','18061581843',1,'2018-11-12 14:22:55',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,4,'guest','$2a$10$WQiD4RzEs1iJVWU.2HVu8OdSlExJHWKmwndaw3SUfMyqfKZmXe1vq',NULL,'18911111111',1,'2020-03-14 14:52:18',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,4,'member','$2a$10$Q08uzqvtPj61NnpYQZsVvOnyilJ3AU4VdngAcJFGvPhEeqhhC.hhS','member','18961511111',1,'2023-05-11 15:22:38','https://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/icon/github_icon_02.png',1,'2009-06-01','上海','学生','member',NULL,5000,1000,NULL,NULL);
/*!40000 ALTER TABLE `ums_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums_user`
--

DROP TABLE IF EXISTS `ums_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ums_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `nickname` varchar(16) DEFAULT NULL,
  `avatar` text,
  `gender` varchar(16) DEFAULT '',
  `birthday` datetime(3) DEFAULT NULL,
  `background_image` text,
  `password` varchar(512) DEFAULT NULL,
  `home_page` varchar(1024) DEFAULT NULL,
  `description` text,
  `score` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '1' COMMENT '0-lock user, 1-normal user,',
  `topic_count` int NOT NULL DEFAULT '0',
  `comment_count` int NOT NULL DEFAULT '0',
  `follow_count` int NOT NULL DEFAULT '0',
  `fans_count` int NOT NULL DEFAULT '0',
  `roles` text,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_user_score` (`score`),
  KEY `idx_user_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_user`
--

LOCK TABLES `ums_user` WRITE;
/*!40000 ALTER TABLE `ums_user` DISABLE KEYS */;
INSERT INTO `ums_user` VALUES (6,NULL,'12345@aidd.com',0,'rust90126',NULL,'',NULL,NULL,'$2b$12$c7Ly6NIqJkMVMPXPDfdKse6IIDBCfhePtUJSK4qDZTFUJ4soE4kkO',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-13 15:25:46','2024-06-13 07:25:45'),(8,NULL,'123@aidd.com',0,'rust9577',NULL,'',NULL,NULL,'$2b$12$2rKlVTrlPZeJx/SQlgmoauEDSWj5th6xWpdK3CrS5YMcK76pns96K',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-15 16:26:13','2024-06-15 08:26:13'),(9,NULL,'1234@aidd.com',0,'rust120103',NULL,'',NULL,NULL,'$2b$12$Wdor17wRpcTfuFGbHhOHB.SEgW9KSAPMTHJHvJHOnkUFITFNAdIA6',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-15 16:26:34','2024-06-15 08:26:34'),(10,NULL,'1111aidd.com',0,'rust3384',NULL,'',NULL,NULL,'$2b$12$TEjhmlEZHCGlVuB4K.X9sePEHSckey5pbA5unTAuZGW2VxILeoCWi',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-15 16:27:00','2024-06-15 08:26:59'),(11,NULL,'1111@aidd.com',0,'rust10735',NULL,'',NULL,NULL,'$2b$12$IR/PJ6alHaxdyem2SLJ40ObO9Pp2ZBWG5lVf10V7DbKp9m3yJFm6C',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-15 16:48:56','2024-06-15 08:48:55'),(12,NULL,'2222@aidd.com',0,'rust87103',NULL,'',NULL,NULL,'$2b$12$tnq0/WSLLLuyJlPMjSNoBuXzRp1wkxHbpa7ykRqNGyfccxdQHkTza',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-15 17:14:03','2024-06-15 09:14:02'),(15,NULL,'chaojiang@aidd.com',0,'rust8081',NULL,'',NULL,NULL,'$2b$12$er3bfm3ZDptBDoTefcBnVOKun.FVQIvDdT24O9RZle3wu7xVyZukq',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-17 16:06:37','2024-06-17 08:06:51');
/*!40000 ALTER TABLE `ums_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-25 18:22:57
