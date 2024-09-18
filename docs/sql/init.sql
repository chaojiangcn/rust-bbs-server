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
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `parent_comment_id` int DEFAULT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`),
  KEY `parent_comment_id` (`parent_comment_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `ums_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_ibfk_3` FOREIGN KEY (`parent_comment_id`) REFERENCES `comment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (3,15,14,NULL,'评论','2024-09-11 11:41:39',0),(4,15,14,NULL,'123','2024-09-11 11:41:54',0),(5,15,14,NULL,'西方人就是会给别国上眼药水忽悠套路，也是也太高看大国的地位了，其实是美国人西方人不再拱火递刀子武装乌克兰进行杀人放火损耗俄罗斯，和平的曙光马上来到实现','2024-09-13 03:56:37',0),(6,15,14,5,'回复内容','2024-09-13 04:32:39',0),(7,15,14,NULL,'留下的你的评论','2024-09-14 02:33:59',0),(8,15,14,NULL,'留下来吧','2024-09-14 02:44:18',0),(9,15,14,NULL,'111','2024-09-14 02:45:59',0),(10,15,14,NULL,'huilaiba ','2024-09-14 02:48:02',0),(11,15,14,NULL,'你好','2024-09-14 03:25:12',0),(12,15,16,NULL,'瓦斯 这也太好看了吧','2024-09-17 09:33:04',0),(13,15,16,NULL,'知道饿了','2024-09-17 09:33:24',0);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite` (
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `favorited_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`post_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `ums_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favorite_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow`
--

DROP TABLE IF EXISTS `follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow` (
  `follower_id` int NOT NULL COMMENT '关注者的用户ID',
  `following_id` int NOT NULL COMMENT '被关注者的用户ID',
  `followed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`follower_id`,`following_id`),
  KEY `follow_ibfk_2` (`following_id`),
  CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `ums_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `follow_ibfk_2` FOREIGN KEY (`following_id`) REFERENCES `ums_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like`
--

DROP TABLE IF EXISTS `like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `like` (
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `liked_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`post_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `like_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `ums_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `like_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like`
--

LOCK TABLES `like` WRITE;
/*!40000 ALTER TABLE `like` DISABLE KEYS */;
INSERT INTO `like` VALUES (15,14,'2024-09-11 10:01:26');
/*!40000 ALTER TABLE `like` ENABLE KEYS */;
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
  `cover` varchar(200) DEFAULT NULL,
  `is_deleted` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (13,'人们在面对自己无法处理的困境时，往往会有一种侥幸心理。','[{\"id\":\"39a52ef5-7030-4d10-b8d3-ee96af3de43a\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"人们在面对自己无法处理的困境时，往往会有一种侥幸心理。\",\"styles\":{\"bold\":true}}],\"children\":[]},{\"id\":\"91021279-f5cc-4c74-80a5-386fb7b1a160\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"21 世纪的人们经历了两次经济周期，每一次都在当时没有做好的准备的人们心里留下了痛苦的阴影。\",\"styles\":{}}],\"children\":[]},{\"id\":\"8ef95a05-fbcf-4591-accc-0a3b155e9ed0\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"李强是出生在中国西北地区一个普通工薪阶层家庭的本科毕业生，08 年刚本科毕业的他选择了大家都以为是万金油的证券金融行业。\",\"styles\":{}}],\"children\":[]},{\"id\":\"68e57a8a-edc1-4c8b-ab5e-24561c7d2a77\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[],\"children\":[]}]',15,'2024-08-28 23:49:55',NULL,NULL,NULL,NULL,0,0,0,0,'',0),(14,'为什么唯物主义在全世界竞争不过宗教?','[{\"id\":\"f6e56f6b-21d0-4a46-ba24-47eba9d8403a\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"作者：李宵萌\\n链接：\",\"styles\":{}},{\"type\":\"link\",\"href\":\"https://www.zhihu.com/question/656923270/answer/3532954395￼来源：知乎￼著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。￼￼\",\"content\":[{\"type\":\"text\",\"text\":\"https://www.zhihu.com/question/656923270/answer/3532954395\\n来源：知乎\\n著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。\\n\\n\",\"styles\":{}}]}],\"children\":[]},{\"id\":\"2ceaea6d-1a94-4eb1-85c7-0e180fa0a963\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"我自己在印尼工作过五年，这是世界上最大的穆斯林国家，九成信逊尼派，其余也有基督教的印度教的。\",\"styles\":{}}],\"children\":[]},{\"id\":\"416807c1-fe89-4f9f-b688-525c38bed116\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"如果一个印尼人从小到大，耳濡目染就是信教的氛围，这个人想不信也难啊。\",\"styles\":{}}],\"children\":[]},{\"id\":\"b0d86b7e-c89c-49f5-af26-0523a4b52aee\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"我现在还记得，注册手机卡的时候，里面就让我选宗教信仰，佛教 印度教 犹太教 伊斯兰教，基督教，很多种可以选呢。\",\"styles\":{}}],\"children\":[]},{\"id\":\"e8b7895b-c229-4ead-a5fd-1f368cffc5fc\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"一开始吧，我们和印尼同事也不敢聊这方面话题，比较敏感嘛。\",\"styles\":{}}],\"children\":[]},{\"id\":\"05188d38-0327-4808-a88f-65a6410d1407\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"后来时间长了，熟悉了，印尼同事就有人想让我们皈依，说你们也是很好的人啊。\",\"styles\":{}}],\"children\":[]},{\"id\":\"9b34c0e3-189c-41a7-8ca4-13c6a033fb9c\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"还说，我们原来以为无信者，都是那种不懂善有善报恶有恶报的不择手段的人呢。\",\"styles\":{}}],\"children\":[]},{\"id\":\"5b201993-63e2-4cc9-b4ce-90eaecbd4fe7\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"哦，原来神职人员是这么宣传的啊。\",\"styles\":{}}],\"children\":[]},{\"id\":\"ed1d5e8f-f76f-43fc-811f-2ef6b83bbe6e\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"然后我就跟印尼同事说了，南美洲，信仰天主教的人很多，但是犯罪率其实也不算低，印度那么多人信教，也是犯罪率不算低啊。\",\"styles\":{}}],\"children\":[]},{\"id\":\"dcb65f2f-ac93-4814-8ad7-06964cd32f67\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"至于穆斯林，各个国家也不一样。\",\"styles\":{}}],\"children\":[]},{\"id\":\"adc0da07-b7e0-4014-a605-e1b5abf04974\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"我这个印尼同事倒是也服气，他受过高等教育，还是明白这些的。\",\"styles\":{}}],\"children\":[]},{\"id\":\"8f9d9e0b-9eab-4845-9f17-a74622d1fa66\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"最后他劝我皈依，谈了几个实际好处。\",\"styles\":{}}],\"children\":[]},{\"id\":\"3e77416f-ecaf-4540-a3c7-4e45a7fc6acc\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"第一个就是 每天五次礼拜，这个也是一种放松的方式，不至于一直干活儿，这是义务，也是权力。\",\"styles\":{}}],\"children\":[]},{\"id\":\"0533a4e3-956f-4bb3-81b0-74109bcad6d2\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"第二个就是 斋月，让富人也体会一把忍饥挨饿的滋味，有助于忆苦思甜\",\"styles\":{}}],\"children\":[]},{\"id\":\"9af1037f-3a9d-4942-bf33-941bd86d4c0a\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"第三个就是 朝圣，出国旅游增长见识，想的话还可以多去，这个旗号绝对管用\",\"styles\":{}}],\"children\":[]},{\"id\":\"dca97898-65f7-43fe-9a0b-2d84d4540e4d\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"第四个就是 \",\"styles\":{}},{\"type\":\"link\",\"href\":\"https://zhida.zhihu.com/search?q=%E4%B8%BB%E9%BA%BB&zhida_source=entity&is_preview=1\",\"content\":[{\"type\":\"text\",\"text\":\"主麻\",\"styles\":{}}]},{\"type\":\"text\",\"text\":\"，凝聚社区，集体活动，减少孤独感\",\"styles\":{}}],\"children\":[]},{\"id\":\"c81948b6-4caa-4bfd-a3b6-428f5b2f9f60\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"至于什么一夫多妻，他自己并不觉得那是什么好处，老婆多了其实很烦的。\",\"styles\":{}}],\"children\":[]},{\"id\":\"45d402c3-70f0-4c46-a60d-a013c1467e5c\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"就是我个人而言，我感觉到，当代印尼人信教是因为这个举国的氛围。\",\"styles\":{}}],\"children\":[]},{\"id\":\"3a331a00-205e-4c6a-878b-c4fc3b775bd2\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"至于我国呢，现在基督教人数上升，一般来说就是因为教会有福利，这些福利不限于 饮食，教育，婚姻介绍，医疗，集体活动。\",\"styles\":{}}],\"children\":[]},{\"id\":\"fb9b94e6-0494-4b19-b310-30eec01360cd\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"教会啊，还是很有钱的，有很多富豪愿意捐钱，这个组织有益于稳定底层，在美国，这就是稳定票仓，当初波兰的剧变，也和天主教会有关，这玩意有政治影响力的，值得有钱人投资。\",\"styles\":{}}],\"children\":[]},{\"id\":\"357674cc-d9a0-4336-998e-d21bd379ee0a\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"投资之后，教会就组织各式活动，增加自己的组织动员能力，这就是一个循环。\",\"styles\":{}}],\"children\":[]},{\"id\":\"d75cd5b1-9edb-4c40-a234-3dd2e9cd8318\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[],\"children\":[]}]',15,'2024-09-08 12:24:09',NULL,NULL,NULL,NULL,0,0,0,0,'',0),(15,'试试图片展示','[{\"id\":\"beaa8ec1-f72b-4822-a0ad-7519f1b36476\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"试试图片展示\",\"styles\":{}}],\"children\":[]},{\"id\":\"11a4704d-35a9-4344-b0a0-5682892d086a\",\"type\":\"image\",\"props\":{\"backgroundColor\":\"default\",\"textAlignment\":\"left\",\"name\":\"u=90059985,610883449&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1424\",\"url\":\"https://img2.baidu.com/it/u=90059985,610883449&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1424\",\"caption\":\"\",\"showPreview\":true,\"previewWidth\":512},\"children\":[]},{\"id\":\"eaabaa1d-738c-48a2-a858-5531c4738eb2\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[],\"children\":[]}]',15,'2024-09-17 17:17:01',NULL,NULL,NULL,NULL,0,0,0,0,'',0),(16,'自定义封面图','[{\"id\":\"c1927079-7683-42a0-b6fd-c078a448dfd2\",\"type\":\"heading\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\",\"level\":1},\"content\":[{\"type\":\"text\",\"text\":\"自定义封面图\",\"styles\":{}}],\"children\":[]},{\"id\":\"d349ce46-d3bd-4ca2-965e-6441640566a7\",\"type\":\"image\",\"props\":{\"backgroundColor\":\"default\",\"textAlignment\":\"left\",\"name\":\"005wNqg5ly3ht1p7vaf07j30om17rn33.jpg\",\"url\":\"https://wx2.sinaimg.cn/mw690/005wNqg5ly3ht1p7vaf07j30om17rn33.jpg\",\"caption\":\"\",\"showPreview\":true,\"previewWidth\":512},\"children\":[]},{\"id\":\"d66c47ef-b77c-417b-9abc-2cdc960652d2\",\"type\":\"paragraph\",\"props\":{\"textColor\":\"default\",\"backgroundColor\":\"default\",\"textAlignment\":\"left\"},\"content\":[],\"children\":[]}]',15,'2024-09-17 17:31:28',NULL,NULL,NULL,NULL,0,0,0,0,'https://wx2.sinaimg.cn/mw690/005wNqg5ly3ht1p7vaf07j30om17rn33.jpg',0);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_tag`
--

DROP TABLE IF EXISTS `post_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_tag` (
  `post_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`post_id`,`tag_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `post_tag_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE,
  CONSTRAINT `post_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_tag`
--

LOCK TABLES `post_tag` WRITE;
/*!40000 ALTER TABLE `post_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
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
  `id` int NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums_user`
--

LOCK TABLES `ums_user` WRITE;
/*!40000 ALTER TABLE `ums_user` DISABLE KEYS */;
INSERT INTO `ums_user` VALUES (6,NULL,'12345@aidd.com',0,'rust90126',NULL,'',NULL,NULL,'$2b$12$c7Ly6NIqJkMVMPXPDfdKse6IIDBCfhePtUJSK4qDZTFUJ4soE4kkO',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-13 15:25:46','2024-06-13 07:25:45'),(8,NULL,'123@aidd.com',0,'rust9577',NULL,'',NULL,NULL,'$2b$12$2rKlVTrlPZeJx/SQlgmoauEDSWj5th6xWpdK3CrS5YMcK76pns96K',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-15 16:26:13','2024-06-15 08:26:13'),(9,NULL,'1234@aidd.com',0,'rust120103',NULL,'',NULL,NULL,'$2b$12$Wdor17wRpcTfuFGbHhOHB.SEgW9KSAPMTHJHvJHOnkUFITFNAdIA6',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-15 16:26:34','2024-06-15 08:26:34'),(10,NULL,'1111aidd.com',0,'rust3384',NULL,'',NULL,NULL,'$2b$12$TEjhmlEZHCGlVuB4K.X9sePEHSckey5pbA5unTAuZGW2VxILeoCWi',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-15 16:27:00','2024-06-15 08:26:59'),(11,NULL,'1111@aidd.com',0,'rust10735',NULL,'',NULL,NULL,'$2b$12$IR/PJ6alHaxdyem2SLJ40ObO9Pp2ZBWG5lVf10V7DbKp9m3yJFm6C',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-15 16:48:56','2024-06-15 08:48:55'),(12,NULL,'2222@aidd.com',0,'rust87103',NULL,'',NULL,NULL,'$2b$12$tnq0/WSLLLuyJlPMjSNoBuXzRp1wkxHbpa7ykRqNGyfccxdQHkTza',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-15 17:14:03','2024-06-15 09:14:02'),(15,NULL,'chaojiang@aidd.com',0,'rust8081','https://gd-hbimg.huaban.com/12ba0917d49ae79ee6fbbfd09ee0b14b2b31306a22630-ekzIH7_fw658','',NULL,NULL,'$2b$12$er3bfm3ZDptBDoTefcBnVOKun.FVQIvDdT24O9RZle3wu7xVyZukq',NULL,NULL,0,1,0,0,0,0,NULL,'2024-06-17 16:06:37','2024-06-17 08:06:51');
/*!40000 ALTER TABLE `ums_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_actions`
--

DROP TABLE IF EXISTS `user_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_actions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `action_id` int NOT NULL,
  `action_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `details` text,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `action_id` (`action_id`),
  CONSTRAINT `user_actions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `ums_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_actions_ibfk_2` FOREIGN KEY (`action_id`) REFERENCES `actions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_actions`
--

LOCK TABLES `user_actions` WRITE;
/*!40000 ALTER TABLE `user_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_actions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-18 11:43:29
