-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: luffy
-- ------------------------------------------------------
-- Server version	5.7.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add Bookmark',6,'add_bookmark'),(22,'Can change Bookmark',6,'change_bookmark'),(23,'Can delete Bookmark',6,'delete_bookmark'),(24,'Can view Bookmark',6,'view_bookmark'),(25,'Can add User Setting',7,'add_usersettings'),(26,'Can change User Setting',7,'change_usersettings'),(27,'Can delete User Setting',7,'delete_usersettings'),(28,'Can view User Setting',7,'view_usersettings'),(29,'Can add User Widget',8,'add_userwidget'),(30,'Can change User Widget',8,'change_userwidget'),(31,'Can delete User Widget',8,'delete_userwidget'),(32,'Can view User Widget',8,'view_userwidget'),(33,'Can add log entry',9,'add_log'),(34,'Can change log entry',9,'change_log'),(35,'Can delete log entry',9,'delete_log'),(36,'Can view log entry',9,'view_log'),(37,'Can add revision',10,'add_revision'),(38,'Can change revision',10,'change_revision'),(39,'Can delete revision',10,'delete_revision'),(40,'Can view revision',10,'view_revision'),(41,'Can add version',11,'add_version'),(42,'Can change version',11,'change_version'),(43,'Can delete version',11,'delete_version'),(44,'Can view version',11,'view_version'),(45,'Can add 轮播图',12,'add_banner'),(46,'Can change 轮播图',12,'change_banner'),(47,'Can delete 轮播图',12,'delete_banner'),(48,'Can view 轮播图',12,'view_banner'),(49,'Can add 导航',13,'add_nav'),(50,'Can change 导航',13,'change_nav'),(51,'Can delete 导航',13,'delete_nav'),(52,'Can view 导航',13,'view_nav'),(53,'Can add 用户',14,'add_user'),(54,'Can change 用户',14,'change_user'),(55,'Can delete 用户',14,'delete_user'),(56,'Can view 用户',14,'view_user'),(57,'Can add 实战课程',15,'add_course'),(58,'Can change 实战课程',15,'change_course'),(59,'Can delete 实战课程',15,'delete_course'),(60,'Can view 实战课程',15,'view_course'),(61,'Can add 课程分类',16,'add_coursecategory'),(62,'Can change 课程分类',16,'change_coursecategory'),(63,'Can delete 课程分类',16,'delete_coursecategory'),(64,'Can view 课程分类',16,'view_coursecategory'),(65,'Can add 课程章节',17,'add_coursechapter'),(66,'Can change 课程章节',17,'change_coursechapter'),(67,'Can delete 课程章节',17,'delete_coursechapter'),(68,'Can view 课程章节',17,'view_coursechapter'),(69,'Can add 讲师导师',18,'add_teacher'),(70,'Can change 讲师导师',18,'change_teacher'),(71,'Can delete 讲师导师',18,'delete_teacher'),(72,'Can view 讲师导师',18,'view_teacher'),(73,'Can add 课程课时',19,'add_courselesson'),(74,'Can change 课程课时',19,'change_courselesson'),(75,'Can delete 课程课时',19,'delete_courselesson'),(76,'Can view 课程课时',19,'view_courselesson'),(77,'Can add 课程与有效期',20,'add_courseexpire'),(78,'Can change 课程与有效期',20,'change_courseexpire'),(79,'Can delete 课程与有效期',20,'delete_courseexpire'),(80,'Can view 课程与有效期',20,'view_courseexpire'),(81,'Can add 活动记录表',21,'add_activity'),(82,'Can change 活动记录表',21,'change_activity'),(83,'Can delete 活动记录表',21,'delete_activity'),(84,'Can view 活动记录表',21,'view_activity'),(85,'Can add 课程优惠类型',22,'add_coursediscounttype'),(86,'Can change 课程优惠类型',22,'change_coursediscounttype'),(87,'Can delete 课程优惠类型',22,'delete_coursediscounttype'),(88,'Can view 课程优惠类型',22,'view_coursediscounttype'),(89,'Can add 课程优惠策略',23,'add_coursediscount'),(90,'Can change 课程优惠策略',23,'change_coursediscount'),(91,'Can delete 课程优惠策略',23,'delete_coursediscount'),(92,'Can view 课程优惠策略',23,'view_coursediscount'),(93,'Can add 课程活动价格表',24,'add_activitydiscount'),(94,'Can change 课程活动价格表',24,'change_activitydiscount'),(95,'Can delete 课程活动价格表',24,'delete_activitydiscount'),(96,'Can view 课程活动价格表',24,'view_activitydiscount'),(97,'Can add 订单记录',25,'add_order'),(98,'Can change 订单记录',25,'change_order'),(99,'Can delete 订单记录',25,'delete_order'),(100,'Can view 订单记录',25,'view_order'),(101,'Can add 订单详情',26,'add_orderdetail'),(102,'Can change 订单详情',26,'change_orderdetail'),(103,'Can delete 订单详情',26,'delete_orderdetail'),(104,'Can view 订单详情',26,'view_orderdetail'),(105,'Can add 优惠券类型',27,'add_coupon'),(106,'Can change 优惠券类型',27,'change_coupon'),(107,'Can delete 优惠券类型',27,'delete_coupon'),(108,'Can view 优惠券类型',27,'view_coupon'),(109,'Can add 用户的优惠券',28,'add_usercoupon'),(110,'Can change 用户的优惠券',28,'change_usercoupon'),(111,'Can delete 用户的优惠券',28,'delete_usercoupon'),(112,'Can view 用户的优惠券',28,'view_usercoupon'),(113,'Can add 积分',29,'add_credit'),(114,'Can change 积分',29,'change_credit'),(115,'Can delete 积分',29,'delete_credit'),(116,'Can view 积分',29,'view_credit'),(117,'Can add 用户课程购买记录',30,'add_usercourse'),(118,'Can change 用户课程购买记录',30,'change_usercourse'),(119,'Can delete 用户课程购买记录',30,'delete_usercourse'),(120,'Can view 用户课程购买记录',30,'view_usercourse');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_ly_users_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_ly_users_id` FOREIGN KEY (`user_id`) REFERENCES `ly_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(27,'coupon','coupon'),(28,'coupon','usercoupon'),(21,'courses','activity'),(24,'courses','activitydiscount'),(15,'courses','course'),(16,'courses','coursecategory'),(17,'courses','coursechapter'),(23,'courses','coursediscount'),(22,'courses','coursediscounttype'),(20,'courses','courseexpire'),(19,'courses','courselesson'),(18,'courses','teacher'),(12,'home','banner'),(13,'home','nav'),(25,'orders','order'),(26,'orders','orderdetail'),(10,'reversion','revision'),(11,'reversion','version'),(5,'sessions','session'),(29,'users','credit'),(14,'users','user'),(30,'users','usercourse'),(6,'xadmin','bookmark'),(9,'xadmin','log'),(7,'xadmin','usersettings'),(8,'xadmin','userwidget');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-10-11 18:45:41.533475'),(2,'auth','0001_initial','2020-10-11 18:45:41.572470'),(3,'users','0001_initial','2020-10-11 18:45:41.722944'),(4,'admin','0001_initial','2020-10-11 18:45:41.772454'),(5,'admin','0002_logentry_remove_auto_add','2020-10-11 18:45:41.796821'),(6,'admin','0003_logentry_add_action_flag_choices','2020-10-11 18:45:41.805678'),(7,'contenttypes','0002_remove_content_type_name','2020-10-11 18:45:41.840878'),(8,'auth','0002_alter_permission_name_max_length','2020-10-11 18:45:41.853950'),(9,'auth','0003_alter_user_email_max_length','2020-10-11 18:45:41.861298'),(10,'auth','0004_alter_user_username_opts','2020-10-11 18:45:41.867933'),(11,'auth','0005_alter_user_last_login_null','2020-10-11 18:45:41.876226'),(12,'auth','0006_require_contenttypes_0002','2020-10-11 18:45:41.878404'),(13,'auth','0007_alter_validators_add_error_messages','2020-10-11 18:45:41.885546'),(14,'auth','0008_alter_user_username_max_length','2020-10-11 18:45:41.894188'),(15,'auth','0009_alter_user_last_name_max_length','2020-10-11 18:45:41.903604'),(16,'auth','0010_alter_group_name_max_length','2020-10-11 18:45:41.914517'),(17,'auth','0011_update_proxy_permissions','2020-10-11 18:45:41.923845'),(18,'courses','0001_initial','2020-10-11 18:45:42.061264'),(19,'courses','0002_auto_20200928_0916','2020-10-11 18:45:42.120745'),(20,'courses','0003_auto_20200928_0957','2020-10-11 18:45:42.150787'),(21,'courses','0004_auto_20200928_1552','2020-10-11 18:45:42.204410'),(22,'courses','0005_auto_20200929_1454','2020-10-11 18:45:42.258818'),(23,'courses','0006_auto_20201012_0245','2020-10-11 18:45:42.265188'),(24,'home','0001_initial','2020-10-11 18:45:42.286781'),(25,'orders','0001_initial','2020-10-11 18:45:42.329353'),(26,'reversion','0001_squashed_0004_auto_20160611_1202','2020-10-11 18:45:42.429233'),(27,'sessions','0001_initial','2020-10-11 18:45:42.458721'),(28,'users','0002_user_money','2020-10-11 18:45:42.481691'),(29,'users','0003_auto_20200923_1140','2020-10-11 18:45:42.489841'),(30,'xadmin','0001_initial','2020-10-11 18:45:42.534772'),(31,'xadmin','0002_log','2020-10-11 18:45:42.579154'),(32,'xadmin','0003_auto_20160715_0100','2020-10-11 18:45:42.613211'),(33,'courses','0007_auto_20201012_0303','2020-10-11 19:03:06.177805'),(34,'coupon','0001_initial','2020-10-11 19:03:06.264078'),(35,'coupon','0002_auto_20201013_1159','2020-10-13 03:59:10.484693'),(36,'courses','0008_auto_20201013_1159','2020-10-13 03:59:10.530630'),(37,'users','0004_auto_20201013_1159','2020-10-13 03:59:10.881982'),(38,'coupon','0003_auto_20201014_1234','2020-10-14 04:34:09.271923'),(39,'courses','0009_auto_20201014_1234','2020-10-14 04:34:09.317529'),(40,'users','0005_auto_20201014_1234','2020-10-14 04:34:09.446867');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_activity`
--

DROP TABLE IF EXISTS `ly_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_activity`
--

LOCK TABLES `ly_activity` WRITE;
/*!40000 ALTER TABLE `ly_activity` DISABLE KEYS */;
INSERT INTO `ly_activity` VALUES (1,'双10大优惠',0,1,0,'2020-10-13 01:05:19.206657','2020-10-13 01:05:19.206709','2020-10-13 00:37:00.000000','2020-10-27 00:37:00.000000');
/*!40000 ALTER TABLE `ly_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_activity_discount`
--

DROP TABLE IF EXISTS `ly_activity_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_activity_discount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `discount_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_activity_discount_activity_id_163f8fed_fk_ly_activity_id` (`activity_id`),
  KEY `ly_activity_discount_course_id_b9bb4bf3_fk_ly_course_id` (`course_id`),
  KEY `ly_activity_discount_discount_id_c77bcf5c_fk_ly_course` (`discount_id`),
  CONSTRAINT `ly_activity_discount_activity_id_163f8fed_fk_ly_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `ly_activity` (`id`),
  CONSTRAINT `ly_activity_discount_course_id_b9bb4bf3_fk_ly_course_id` FOREIGN KEY (`course_id`) REFERENCES `ly_course` (`id`),
  CONSTRAINT `ly_activity_discount_discount_id_c77bcf5c_fk_ly_course` FOREIGN KEY (`discount_id`) REFERENCES `ly_course_discount` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_activity_discount`
--

LOCK TABLES `ly_activity_discount` WRITE;
/*!40000 ALTER TABLE `ly_activity_discount` DISABLE KEYS */;
INSERT INTO `ly_activity_discount` VALUES (1,NULL,0,1,0,'2020-10-13 01:13:52.624881','2020-10-13 01:13:52.624941',1,3,3),(2,NULL,0,1,0,'2020-10-13 01:14:45.933951','2020-10-13 01:14:45.934014',1,1,2);
/*!40000 ALTER TABLE `ly_activity_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_banner`
--

DROP TABLE IF EXISTS `ly_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `note` varchar(150) NOT NULL,
  `link` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_banner`
--

LOCK TABLES `ly_banner` WRITE;
/*!40000 ALTER TABLE `ly_banner` DISABLE KEYS */;
INSERT INTO `ly_banner` VALUES (1,'小明',1,1,0,'2020-09-11 04:13:38.708376','2020-09-11 04:13:38.708416','banner/2.jpeg','00000','http://www.baidu.com'),(2,'小黑',2,1,0,'2020-09-11 06:43:35.840872','2020-09-11 06:43:35.840913','banner/3.jpg','00000','http://www.luffycity.com');
/*!40000 ALTER TABLE `ly_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_coupon`
--

DROP TABLE IF EXISTS `ly_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `coupon_type` smallint(6) NOT NULL,
  `duration` int(11) NOT NULL,
  `condition` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `method` smallint(6) NOT NULL,
  `sale` longtext NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_coupon_course_id_91e7a35a_fk_ly_course_id` (`course_id`),
  CONSTRAINT `ly_coupon_course_id_91e7a35a_fk_ly_course_id` FOREIGN KEY (`course_id`) REFERENCES `ly_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_coupon`
--

LOCK TABLES `ly_coupon` WRITE;
/*!40000 ALTER TABLE `ly_coupon` DISABLE KEYS */;
INSERT INTO `ly_coupon` VALUES (1,'10元优惠券',0,1,0,'2020-10-11 19:11:04.254075','2020-10-13 02:26:11.017181',1,7,200,100,1,'-10',3),(2,'88折优惠券',0,1,0,'2020-10-13 00:52:38.216120','2020-10-13 08:58:31.980640',2,7,200,100,1,'*0.88',2);
/*!40000 ALTER TABLE `ly_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_course`
--

DROP TABLE IF EXISTS `ly_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `course_img` varchar(255) DEFAULT NULL,
  `course_video` varchar(255) DEFAULT NULL,
  `course_type` smallint(6) NOT NULL,
  `brief` longtext,
  `level` smallint(6) NOT NULL,
  `pub_date` date NOT NULL,
  `period` int(11) NOT NULL,
  `attachment_path` varchar(128) DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  `students` int(11) NOT NULL,
  `lessons` int(11) NOT NULL,
  `pub_lessons` int(11) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `course_category_id` int(11) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_course_course_category_id_0fae919c_fk_ly_course_category_id` (`course_category_id`),
  KEY `ly_course_teacher_id_1a7162ce_fk_ly_teacher_id` (`teacher_id`),
  CONSTRAINT `ly_course_course_category_id_0fae919c_fk_ly_course_category_id` FOREIGN KEY (`course_category_id`) REFERENCES `ly_course_category` (`id`),
  CONSTRAINT `ly_course_teacher_id_1a7162ce_fk_ly_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `ly_teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_course`
--

LOCK TABLES `ly_course` WRITE;
/*!40000 ALTER TABLE `ly_course` DISABLE KEYS */;
INSERT INTO `ly_course` VALUES (1,'7天python从入门到放弃',3,1,0,'2020-09-23 07:30:26.966935','2020-10-15 01:27:50.931641','course/2.jpeg','course_video/2.jpeg',0,'33333333333333333333333333333333',2,'2020-09-23',71,'123.jpg',0,908,10,8,1000.00,2,1),(2,'7天java从入门到放弃',3,1,0,'2020-09-23 07:30:26.966935','2020-09-23 07:31:04.440506','course/2.jpeg','course_video/2.jpeg',0,'33333333333333333333333333333333',2,'2020-09-23',71,'123.jpg',0,900,10,8,1000.00,2,1),(3,'7天前端从入门到放弃',3,1,0,'2020-09-23 07:30:26.966935','2020-09-23 07:31:04.440506','course/2.jpeg','course_video/2.jpeg',0,'33333333333333333333333333333333',2,'2020-09-23',71,'123.jpg',0,900,10,8,1000.00,2,1),(4,'7天C++从入门到放弃',3,1,0,'2020-09-23 07:30:26.966935','2020-09-23 07:31:04.440506','course/2.jpeg','course_video/2.jpeg',0,'33333333333333333333333333333333',2,'2020-09-23',71,'123.jpg',0,900,10,8,1000.00,2,1);
/*!40000 ALTER TABLE `ly_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_course_category`
--

DROP TABLE IF EXISTS `ly_course_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_course_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_course_category`
--

LOCK TABLES `ly_course_category` WRITE;
/*!40000 ALTER TABLE `ly_course_category` DISABLE KEYS */;
INSERT INTO `ly_course_category` VALUES (1,'python',1,1,0,'2019-11-11 12:00:00.000000','2020-11-11 12:00:00.000000'),(2,'python进阶',2,1,0,'2019-11-11 12:00:00.000000','2020-11-11 12:00:00.000000'),(3,'java',3,1,0,'2019-11-11 12:00:00.000000','2020-11-11 12:00:00.000000'),(4,'前端开发',4,1,0,'2019-11-11 12:00:00.000000','2020-11-11 12:00:00.000000');
/*!40000 ALTER TABLE `ly_course_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_course_chapter`
--

DROP TABLE IF EXISTS `ly_course_chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_course_chapter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `number` smallint(6) NOT NULL,
  `summary` longtext,
  `pub_date` date NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_course_chapter_course_id_e677b55c_fk_ly_course_id` (`course_id`),
  CONSTRAINT `ly_course_chapter_course_id_e677b55c_fk_ly_course_id` FOREIGN KEY (`course_id`) REFERENCES `ly_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_course_chapter`
--

LOCK TABLES `ly_course_chapter` WRITE;
/*!40000 ALTER TABLE `ly_course_chapter` DISABLE KEYS */;
INSERT INTO `ly_course_chapter` VALUES (2,'python介绍和环境安装',1,1,0,'2020-09-23 08:27:30.942383','2020-09-23 08:27:30.942420',1,'python介绍和发展历史','2020-09-23',1),(3,'python变量',1,1,0,'2020-09-23 08:27:30.942383','2020-09-23 08:27:30.942420',2,'python介绍和发展历史','2020-09-23',1),(4,'python语句',1,1,0,'2020-09-23 08:27:30.942383','2020-09-23 08:27:30.942420',3,'python介绍和发展历史','2020-09-23',1),(5,'java介绍和环境安装',1,1,0,'2020-09-23 08:27:30.942383','2020-09-23 08:27:30.942420',1,'python介绍和发展历史','2020-09-23',2),(6,'java变量',1,1,0,'2020-09-23 08:27:30.942383','2020-09-23 08:27:30.942420',2,'python介绍和发展历史','2020-09-23',2),(7,'java语句',1,1,0,'2020-09-23 08:27:30.942383','2020-09-23 08:27:30.942420',3,'python介绍和发展历史','2020-09-23',2),(8,'html',1,1,0,'2020-09-23 08:27:30.942383','2020-09-23 08:27:30.942420',1,'python介绍和发展历史','2020-09-23',3),(9,'css',1,1,0,'2020-09-23 08:27:30.942383','2020-09-23 08:27:30.942420',2,'python介绍和发展历史','2020-09-23',3),(10,'javascript',1,1,0,'2020-09-23 08:27:30.942383','2020-09-23 08:27:30.942420',3,'python介绍和发展历史','2020-09-23',3);
/*!40000 ALTER TABLE `ly_course_chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_course_discount`
--

DROP TABLE IF EXISTS `ly_course_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_course_discount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `condition` int(11) NOT NULL,
  `sale` longtext NOT NULL,
  `discount_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_course_discount_discount_type_id_b32ca11c_fk_ly_course` (`discount_type_id`),
  CONSTRAINT `ly_course_discount_discount_type_id_b32ca11c_fk_ly_course` FOREIGN KEY (`discount_type_id`) REFERENCES `ly_course_discount_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_course_discount`
--

LOCK TABLES `ly_course_discount` WRITE;
/*!40000 ALTER TABLE `ly_course_discount` DISABLE KEYS */;
INSERT INTO `ly_course_discount` VALUES (1,NULL,0,1,0,'2020-10-13 01:12:56.866885','2020-10-13 01:12:56.868397',0,'0',3),(2,NULL,0,1,0,'2020-10-13 01:13:40.017910','2020-10-13 01:14:27.263767',100,'*0.8',1),(3,NULL,0,1,0,'2020-10-13 01:13:40.163827','2020-10-13 01:13:40.164035',100,'满100-5\r\n满200-15\r\n满300-35\r\n满400-55\r\n满500-105',2);
/*!40000 ALTER TABLE `ly_course_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_course_discount_type`
--

DROP TABLE IF EXISTS `ly_course_discount_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_course_discount_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `remark` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_course_discount_type`
--

LOCK TABLES `ly_course_discount_type` WRITE;
/*!40000 ALTER TABLE `ly_course_discount_type` DISABLE KEYS */;
INSERT INTO `ly_course_discount_type` VALUES (1,'限时折扣',0,1,0,'2020-10-13 01:11:57.303982','2020-10-13 01:11:57.304044',NULL),(2,'限时满减',0,1,0,'2020-10-13 01:12:02.914018','2020-10-13 01:12:02.914079',NULL),(3,'限时免费',0,1,0,'2020-10-13 01:12:07.345178','2020-10-13 01:12:07.345237',NULL),(4,'限时减免',0,1,0,'2020-10-13 01:12:24.762541','2020-10-13 01:12:24.762797',NULL);
/*!40000 ALTER TABLE `ly_course_discount_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_course_expire`
--

DROP TABLE IF EXISTS `ly_course_expire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_course_expire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `time` int(11) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_course_expire_course_id_e843fad2_fk_ly_course_id` (`course_id`),
  CONSTRAINT `ly_course_expire_course_id_e843fad2_fk_ly_course_id` FOREIGN KEY (`course_id`) REFERENCES `ly_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_course_expire`
--

LOCK TABLES `ly_course_expire` WRITE;
/*!40000 ALTER TABLE `ly_course_expire` DISABLE KEYS */;
INSERT INTO `ly_course_expire` VALUES (1,'1个月有效',0,1,0,'2020-09-28 01:19:52.983289','2020-09-28 01:19:52.983327',30,199.00,1),(2,'2个月有效',0,1,0,'2020-09-28 01:20:48.662350','2020-09-28 01:20:48.662386',60,359.00,1),(3,'3个月有效',0,1,0,'2020-09-28 01:21:17.158665','2020-09-28 01:21:17.158701',90,399.00,1),(4,'1个月有效',0,1,0,'2020-09-28 01:19:52.983289','2020-09-28 01:19:52.983327',30,199.00,2),(5,'2个月有效',0,1,0,'2020-09-28 01:20:48.662350','2020-09-28 01:20:48.662386',60,359.00,2),(6,'3个月有效',0,1,0,'2020-09-28 01:21:17.158665','2020-09-28 01:21:17.158701',90,399.00,2),(7,'1个月有效',0,1,0,'2020-09-28 01:19:52.983289','2020-09-28 01:19:52.983327',30,199.00,3),(8,'2个月有效',0,1,0,'2020-09-28 01:20:48.662350','2020-09-28 01:20:48.662386',60,359.00,3),(9,'3个月有效',0,1,0,'2020-09-28 01:21:17.158665','2020-09-28 01:21:17.158701',90,399.00,3),(10,'1个月有效',0,1,0,'2020-09-28 01:19:52.983289','2020-09-28 01:19:52.983327',30,199.00,4),(11,'2个月有效',0,1,0,'2020-09-28 01:20:48.662350','2020-09-28 01:20:48.662386',60,359.00,4),(12,'3个月有效',0,1,0,'2020-09-28 01:21:17.158665','2020-09-28 01:21:17.158701',90,399.00,4);
/*!40000 ALTER TABLE `ly_course_expire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_course_lesson`
--

DROP TABLE IF EXISTS `ly_course_lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_course_lesson` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `lesson_type` smallint(6) NOT NULL,
  `lesson_link` varchar(255) DEFAULT NULL,
  `duration` varchar(32) DEFAULT NULL,
  `pub_date` datetime(6) NOT NULL,
  `free_trail` tinyint(1) NOT NULL,
  `recomment` tinyint(1) NOT NULL,
  `number` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_course_lesson_chapter_id_09ff8644_fk_ly_course_chapter_id` (`chapter_id`),
  KEY `ly_course_lesson_course_id_1e932817_fk_ly_course_id` (`course_id`),
  CONSTRAINT `ly_course_lesson_chapter_id_09ff8644_fk_ly_course_chapter_id` FOREIGN KEY (`chapter_id`) REFERENCES `ly_course_chapter` (`id`),
  CONSTRAINT `ly_course_lesson_course_id_1e932817_fk_ly_course_id` FOREIGN KEY (`course_id`) REFERENCES `ly_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_course_lesson`
--

LOCK TABLES `ly_course_lesson` WRITE;
/*!40000 ALTER TABLE `ly_course_lesson` DISABLE KEYS */;
INSERT INTO `ly_course_lesson` VALUES (2,'python发展历史',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 09:16:24.719487',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',1,1,1,2,1),(3,'python的解析器版本',10,1,0,'2020-09-23 08:35:23.883132','2020-09-23 09:15:47.505278',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,1,2,2,1),(4,'python的开发工具使用',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,1,3,2,1),(5,'python的环境安装',8,1,0,'2020-09-23 08:35:23.883132','2020-09-23 09:14:37.735764',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',1,1,4,2,1),(6,'python的环境配置',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,5,2,1),(7,'什么是变量',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,1,3,1),(8,'变量的声明',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,2,3,1),(9,'变量的使用',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,3,3,1),(10,'变量的ID内存地址',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,4,3,1),(11,'变量的类型',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,5,3,1),(12,'变量的类型转换',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,6,3,1),(13,'分支语句-if',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,1,3,1),(14,'分支语句-if-else',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,2,4,1),(15,'分支语句-if-elif-else',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,3,4,1),(16,'循环语句-while',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,4,4,1),(17,'循环语句-do-while',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,5,4,1),(18,'循环语句-for',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,6,4,1),(19,'中断语句-continue',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,7,4,1),(20,'中断语句-break',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,8,4,1),(21,'java发展历史',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,1,1,5,2),(22,'java的解析器版本',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,1,2,5,2),(23,'java的开发工具使用',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,3,5,2),(24,'java的环境安装',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,1,4,5,2),(25,'java的环境配置',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,5,5,2),(26,'什么是变量',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,1,6,2),(27,'变量的声明',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,1,2,6,2),(28,'变量的使用',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,3,6,2),(29,'变量的内存地址',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,4,6,2),(30,'变量的类型',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,5,6,2),(31,'变量的类型转换',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,6,6,2),(32,'分支语句-if',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,1,7,2),(33,'分支语句-if-else',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,2,7,2),(34,'分支语句-if-else if-else',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,3,7,2),(35,'循环语句-while',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,4,7,2),(36,'循环语句-do-while',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,5,7,2),(37,'循环语句-for',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,6,7,2),(38,'中断语句-continue',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,7,7,2),(39,'中断语句-break',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,8,7,2),(40,'html发展历史',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,1,1,8,3),(41,'浏览器版本',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,1,2,8,3),(42,'web前端开发工具使用',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,1,3,8,3),(43,'html网页结构',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,4,8,3),(44,'html标签语法',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,5,8,3),(45,'html常用标签',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,1,6,8,3),(46,'html列表',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,7,8,3),(47,'html表单',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,8,8,3),(48,'html表格',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,9,8,3),(49,'css基础语法',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,1,9,3),(50,'css选择符',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,2,9,3),(51,'css属性',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,3,9,3),(52,'css高级属性',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,4,9,3),(53,'css浮动',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,5,9,3),(54,'css定位',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,6,9,3),(55,'css布局',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,7,9,3),(56,'css弹性布局',0,1,0,'2020-09-23 08:35:23.883132','2020-09-23 08:35:23.883161',2,'b94978510f1b95833da7f6fa2f6dda57_b','3:00','2020-09-23 08:35:23.883191',0,0,8,9,3);
/*!40000 ALTER TABLE `ly_course_lesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_credit`
--

DROP TABLE IF EXISTS `ly_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_credit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `operation` smallint(6) NOT NULL,
  `number` int(11) NOT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_credit_user_id_41bb3032_fk_ly_users_id` (`user_id`),
  CONSTRAINT `ly_credit_user_id_41bb3032_fk_ly_users_id` FOREIGN KEY (`user_id`) REFERENCES `ly_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_credit`
--

LOCK TABLES `ly_credit` WRITE;
/*!40000 ALTER TABLE `ly_credit` DISABLE KEYS */;
INSERT INTO `ly_credit` VALUES (6,NULL,0,1,0,'2020-10-13 04:24:30.318184','2020-10-13 04:24:30.318242',2,1000,NULL,1),(7,NULL,0,1,0,'2020-10-13 04:24:58.270294','2020-10-13 04:24:58.270356',1,-300,NULL,1),(8,NULL,0,1,0,'2020-10-13 10:11:20.116573','2020-10-13 10:11:20.116608',1,-300,NULL,1),(9,NULL,0,1,0,'2020-10-14 01:00:22.471206','2020-10-14 01:00:22.471240',1,-400,NULL,1);
/*!40000 ALTER TABLE `ly_credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_nav`
--

DROP TABLE IF EXISTS `ly_nav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `link` varchar(250) NOT NULL,
  `opt` smallint(6) NOT NULL,
  `is_http` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_nav`
--

LOCK TABLES `ly_nav` WRITE;
/*!40000 ALTER TABLE `ly_nav` DISABLE KEYS */;
INSERT INTO `ly_nav` VALUES (1,'免费课',6,1,0,'2020-09-11 08:03:12.441872','2020-09-23 01:22:38.830882','/free',0,0),(2,'路飞学城',5,1,0,'2020-09-11 08:03:47.584076','2020-09-11 08:03:47.584113','http://www.luffycity.cn',0,1),(3,'实战课',4,1,0,'2020-09-11 08:03:12.441872','2020-09-23 01:20:27.630666','/course',0,0),(4,'百度',3,1,0,'2020-09-11 08:03:47.584076','2020-09-11 08:03:47.584113','http://www.baidu.com',1,1),(5,'题库',2,1,0,'2020-09-11 08:03:12.441872','2020-09-11 08:03:12.441910','/question',0,0),(6,'老男孩教育',1,1,0,'2020-09-11 08:03:47.584076','2020-09-11 08:03:47.584113','http://www.oldboyedu.com',0,1),(7,'联系我们',7,1,0,'2020-09-11 08:03:12.441872','2020-09-11 08:03:12.441910','/course',1,0),(8,'商务合作',8,1,0,'2020-09-11 08:03:47.584076','2020-09-11 08:20:14.524971','/contact',1,0);
/*!40000 ALTER TABLE `ly_nav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_order`
--

DROP TABLE IF EXISTS `ly_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `total_price` decimal(6,2) NOT NULL,
  `real_price` decimal(6,2) NOT NULL,
  `order_number` varchar(64) NOT NULL,
  `order_status` smallint(6) NOT NULL,
  `pay_type` smallint(6) NOT NULL,
  `credit` int(11) NOT NULL,
  `coupon` int(11) NOT NULL,
  `order_desc` longtext NOT NULL,
  `pay_time` datetime(6) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_order_user_id_ae588b8c_fk_ly_users_id` (`user_id`),
  CONSTRAINT `ly_order_user_id_ae588b8c_fk_ly_users_id` FOREIGN KEY (`user_id`) REFERENCES `ly_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_order`
--

LOCK TABLES `ly_order` WRITE;
/*!40000 ALTER TABLE `ly_order` DISABLE KEYS */;
INSERT INTO `ly_order` VALUES (1,'课程购买',0,1,0,'2020-10-11 18:56:43.148240','2020-10-15 03:23:53.541595',2000.00,2000.00,'20201011180643000000000192971244',2,1,0,0,'课程购买',NULL,1),(13,'课程购买',0,1,0,'2020-10-13 10:11:20.030919','2020-10-15 04:19:52.902094',718.00,571.20,'20201013101020000000000158930755',3,1,300,2,'课程购买',NULL,1),(14,'课程购买',0,1,0,'2020-10-14 01:00:22.430993','2020-10-15 04:19:52.918611',199.00,119.20,'20201014010122000000000148009274',3,1,400,0,'课程购买',NULL,1),(15,'课程购买',0,1,0,'2020-10-14 03:24:43.652284','2020-10-14 03:24:43.698180',199.00,199.00,'20201014030343000000000198267687',3,1,0,0,'课程购买',NULL,1),(16,'课程购买',0,1,0,'2020-10-14 03:25:43.114817','2020-10-15 04:19:52.922517',199.00,159.20,'20201014030343000000000110880223',3,1,0,0,'课程购买','2020-10-14 04:46:57.105945',1),(17,'课程购买',0,1,0,'2020-10-14 04:49:35.245047','2020-10-14 04:57:47.654498',199.00,159.20,'20201014040435000000000126827234',1,1,0,0,'课程购买','2020-10-14 04:57:47.653864',1),(18,'课程购买',0,1,0,'2020-10-15 01:16:08.655082','2020-10-15 01:27:50.922161',199.00,159.20,'20201015010108000000000123797831',1,1,0,0,'课程购买','2020-10-15 01:27:50.921890',1);
/*!40000 ALTER TABLE `ly_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_order_detail`
--

DROP TABLE IF EXISTS `ly_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `expire` int(11) NOT NULL,
  `expire_text` varchar(150) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `real_price` decimal(6,2) NOT NULL,
  `discount_name` varchar(120) NOT NULL,
  `course_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_order_detail_course_id_cb34575d_fk_ly_course_id` (`course_id`),
  KEY `ly_order_detail_order_id_735380ae_fk_ly_order_id` (`order_id`),
  CONSTRAINT `ly_order_detail_course_id_cb34575d_fk_ly_course_id` FOREIGN KEY (`course_id`) REFERENCES `ly_course` (`id`),
  CONSTRAINT `ly_order_detail_order_id_735380ae_fk_ly_order_id` FOREIGN KEY (`order_id`) REFERENCES `ly_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_order_detail`
--

LOCK TABLES `ly_order_detail` WRITE;
/*!40000 ALTER TABLE `ly_order_detail` DISABLE KEYS */;
INSERT INTO `ly_order_detail` VALUES (1,NULL,0,1,0,'2020-10-11 18:56:43.155726','2020-10-11 18:56:43.156255',-1,'永久有效',1000.00,1000.00,'',3,1),(23,NULL,0,1,0,'2020-10-13 10:11:20.073642','2020-10-13 10:11:20.075899',60,'2个月有效',359.00,324.00,'限时满减',3,13),(24,NULL,0,1,0,'2020-10-13 10:11:20.108393','2020-10-13 10:11:20.109265',60,'2个月有效',359.00,287.20,'限时折扣',1,13),(25,NULL,0,1,0,'2020-10-14 01:00:22.464862','2020-10-14 01:00:22.466906',30,'1个月有效',199.00,159.20,'限时折扣',1,14),(26,NULL,0,1,0,'2020-10-14 03:24:43.687273','2020-10-14 03:24:43.695334',30,'1个月有效',199.00,199.00,'',2,15),(27,NULL,0,1,0,'2020-10-14 03:25:43.144675','2020-10-14 03:25:43.147054',30,'1个月有效',199.00,159.20,'限时折扣',1,16),(28,NULL,0,1,0,'2020-10-14 04:49:35.371841','2020-10-14 04:49:35.376513',30,'1个月有效',199.00,159.20,'限时折扣',1,17),(29,NULL,0,1,0,'2020-10-15 01:16:08.700713','2020-10-15 01:16:08.711257',30,'1个月有效',199.00,159.20,'限时折扣',1,18);
/*!40000 ALTER TABLE `ly_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_teacher`
--

DROP TABLE IF EXISTS `ly_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `role` smallint(6) NOT NULL,
  `title` varchar(64) NOT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `brief` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_teacher`
--

LOCK TABLES `ly_teacher` WRITE;
/*!40000 ALTER TABLE `ly_teacher` DISABLE KEYS */;
INSERT INTO `ly_teacher` VALUES (1,'Alex',1,1,0,'2020-09-23 07:26:56.493995','2020-09-23 07:26:56.494049',0,'过期网红','金角大王','teacher/timg.png','32132132131232132132');
/*!40000 ALTER TABLE `ly_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_user_coupon`
--

DROP TABLE IF EXISTS `ly_user_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_user_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `is_use` tinyint(1) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_user_coupon_coupon_id_d4690c35_fk_ly_coupon_id` (`coupon_id`),
  KEY `ly_user_coupon_user_id_801e1fee_fk_ly_users_id` (`user_id`),
  CONSTRAINT `ly_user_coupon_coupon_id_d4690c35_fk_ly_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `ly_coupon` (`id`),
  CONSTRAINT `ly_user_coupon_user_id_801e1fee_fk_ly_users_id` FOREIGN KEY (`user_id`) REFERENCES `ly_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_user_coupon`
--

LOCK TABLES `ly_user_coupon` WRITE;
/*!40000 ALTER TABLE `ly_user_coupon` DISABLE KEYS */;
INSERT INTO `ly_user_coupon` VALUES (1,NULL,0,1,0,'2020-10-11 19:11:11.609053','2020-10-11 19:11:11.609078','2020-10-11 19:09:00.000000',0,1,1),(2,NULL,0,1,0,'2020-10-11 19:22:50.148006','2020-10-13 10:11:20.110495','2020-10-11 19:22:00.000000',1,1,1),(3,NULL,0,1,0,'2020-10-11 19:23:00.461750','2020-10-11 19:23:00.461781','2020-10-13 19:22:00.000000',0,1,1),(4,NULL,0,1,0,'2020-10-13 00:52:57.868227','2020-10-13 00:52:57.868286','2020-10-13 00:37:00.000000',0,2,1);
/*!40000 ALTER TABLE `ly_user_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_user_course`
--

DROP TABLE IF EXISTS `ly_user_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_user_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `last_time` datetime(6) NOT NULL,
  `has_time` datetime(6) NOT NULL,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_user_course_course_id_8643fef5_fk_ly_course_id` (`course_id`),
  KEY `ly_user_course_user_id_94018e47_fk_ly_users_id` (`user_id`),
  CONSTRAINT `ly_user_course_course_id_8643fef5_fk_ly_course_id` FOREIGN KEY (`course_id`) REFERENCES `ly_course` (`id`),
  CONSTRAINT `ly_user_course_user_id_94018e47_fk_ly_users_id` FOREIGN KEY (`user_id`) REFERENCES `ly_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_user_course`
--

LOCK TABLES `ly_user_course` WRITE;
/*!40000 ALTER TABLE `ly_user_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `ly_user_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_users`
--

DROP TABLE IF EXISTS `ly_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updateed_time` datetime(6) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `mobile` varchar(20) NOT NULL,
  `birthday` datetime(6) DEFAULT NULL,
  `money` decimal(10,2) NOT NULL,
  `credit` int(11),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_users`
--

LOCK TABLES `ly_users` WRITE;
/*!40000 ALTER TABLE `ly_users` DISABLE KEYS */;
INSERT INTO `ly_users` VALUES (1,'pbkdf2_sha256$150000$KIk8YeiLY7T5$ZQskfZUNtUVWdmmFn72Bupsxb2llY/hEKUoLVzHxQCU=','2020-10-11 18:55:00.000000',1,'root','','','',1,1,'2020-10-11 18:46:00.000000','小飞机',0,1,0,'2020-10-11 18:46:13.312795','2020-10-14 01:00:22.469430','','13928835901',NULL,0.00,0);
/*!40000 ALTER TABLE `ly_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_users_groups`
--

DROP TABLE IF EXISTS `ly_users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_users_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ly_users_groups_user_id_group_id_e3b73a35_uniq` (`user_id`,`group_id`),
  KEY `ly_users_groups_group_id_7505a66d_fk_auth_group_id` (`group_id`),
  CONSTRAINT `ly_users_groups_group_id_7505a66d_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `ly_users_groups_user_id_b293b4e8_fk_ly_users_id` FOREIGN KEY (`user_id`) REFERENCES `ly_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_users_groups`
--

LOCK TABLES `ly_users_groups` WRITE;
/*!40000 ALTER TABLE `ly_users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `ly_users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ly_users_user_permissions`
--

DROP TABLE IF EXISTS `ly_users_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ly_users_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ly_users_user_permissions_user_id_permission_id_5b1027ec_uniq` (`user_id`,`permission_id`),
  KEY `ly_users_user_permis_permission_id_14148e4f_fk_auth_perm` (`permission_id`),
  CONSTRAINT `ly_users_user_permis_permission_id_14148e4f_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `ly_users_user_permissions_user_id_047a052d_fk_ly_users_id` FOREIGN KEY (`user_id`) REFERENCES `ly_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ly_users_user_permissions`
--

LOCK TABLES `ly_users_user_permissions` WRITE;
/*!40000 ALTER TABLE `ly_users_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `ly_users_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reversion_revision`
--

DROP TABLE IF EXISTS `reversion_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reversion_revision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime(6) NOT NULL,
  `comment` longtext NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reversion_revision_user_id_17095f45_fk_ly_users_id` (`user_id`),
  KEY `reversion_revision_date_created_96f7c20c` (`date_created`),
  CONSTRAINT `reversion_revision_user_id_17095f45_fk_ly_users_id` FOREIGN KEY (`user_id`) REFERENCES `ly_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reversion_revision`
--

LOCK TABLES `reversion_revision` WRITE;
/*!40000 ALTER TABLE `reversion_revision` DISABLE KEYS */;
/*!40000 ALTER TABLE `reversion_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reversion_version`
--

DROP TABLE IF EXISTS `reversion_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reversion_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` varchar(191) NOT NULL,
  `format` varchar(255) NOT NULL,
  `serialized_data` longtext NOT NULL,
  `object_repr` longtext NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `revision_id` int(11) NOT NULL,
  `db` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reversion_version_db_content_type_id_objec_b2c54f65_uniq` (`db`,`content_type_id`,`object_id`,`revision_id`),
  KEY `reversion_version_content_type_id_7d0ff25c_fk_django_co` (`content_type_id`),
  KEY `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` (`revision_id`),
  CONSTRAINT `reversion_version_content_type_id_7d0ff25c_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `reversion_revision` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reversion_version`
--

LOCK TABLES `reversion_version` WRITE;
/*!40000 ALTER TABLE `reversion_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `reversion_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_bookmark`
--

DROP TABLE IF EXISTS `xadmin_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `url_name` varchar(64) NOT NULL,
  `query` varchar(1000) NOT NULL,
  `is_share` tinyint(1) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_bookmark_content_type_id_60941679_fk_django_co` (`content_type_id`),
  KEY `xadmin_bookmark_user_id_42d307fc_fk_ly_users_id` (`user_id`),
  CONSTRAINT `xadmin_bookmark_content_type_id_60941679_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_bookmark_user_id_42d307fc_fk_ly_users_id` FOREIGN KEY (`user_id`) REFERENCES `ly_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_bookmark`
--

LOCK TABLES `xadmin_bookmark` WRITE;
/*!40000 ALTER TABLE `xadmin_bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_log`
--

DROP TABLE IF EXISTS `xadmin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `ip_addr` char(39) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` varchar(32) NOT NULL,
  `message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` (`content_type_id`),
  KEY `xadmin_log_user_id_bb16a176_fk_ly_users_id` (`user_id`),
  CONSTRAINT `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_log_user_id_bb16a176_fk_ly_users_id` FOREIGN KEY (`user_id`) REFERENCES `ly_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_log`
--

LOCK TABLES `xadmin_log` WRITE;
/*!40000 ALTER TABLE `xadmin_log` DISABLE KEYS */;
INSERT INTO `xadmin_log` VALUES (1,'2020-10-11 19:11:04.260626','127.0.0.1','1','10元优惠券[满50元可以使用]','create','已添加。',27,1),(2,'2020-10-11 19:11:11.609934','127.0.0.1','1','优惠券:10元优惠券,用户:root','create','已添加。',28,1),(3,'2020-10-11 19:22:50.155429','127.0.0.1','2','优惠券:10元优惠券,用户:root','create','已添加。',28,1),(4,'2020-10-11 19:23:00.462983','127.0.0.1','3','优惠券:10元优惠券,用户:root','create','已添加。',28,1),(5,'2020-10-13 00:52:38.230576','127.0.0.1','2','88折优惠券[购买课程<7天前端从入门到放弃>可以使用]','create','已添加。',27,1),(6,'2020-10-13 00:52:57.869501','127.0.0.1','4','优惠券:88折优惠券,用户:root','create','已添加。',28,1),(7,'2020-10-13 01:05:19.216736','127.0.0.1','1','双10大优惠','create','已添加。',21,1),(8,'2020-10-13 01:11:57.305973','127.0.0.1','1','限时折扣','create','已添加。',22,1),(9,'2020-10-13 01:12:02.925347','127.0.0.1','2','限时满减','create','已添加。',22,1),(10,'2020-10-13 01:12:07.347565','127.0.0.1','3','限时免费','create','已添加。',22,1),(11,'2020-10-13 01:12:24.774546','127.0.0.1','4','限时减免','create','已添加。',22,1),(12,'2020-10-13 01:12:56.871932','127.0.0.1','1','价格优惠:限时免费,优惠条件:0,优惠值:0','create','已添加。',23,1),(13,'2020-10-13 01:13:40.020202','127.0.0.1','2','价格优惠:限时满减,优惠条件:100,优惠值:满100-5\r\n满200-15\r\n满300-35\r\n满400-55\r\n满500-105','create','已添加。',23,1),(14,'2020-10-13 01:13:40.168005','127.0.0.1','3','价格优惠:限时满减,优惠条件:100,优惠值:满100-5\r\n满200-15\r\n满300-35\r\n满400-55\r\n满500-105','create','已添加。',23,1),(15,'2020-10-13 01:13:52.629787','127.0.0.1','1','活动:双10大优惠-课程:7天前端从入门到放弃-优惠值:满100-5\r\n满200-15\r\n满300-35\r\n满400-55\r\n满500-105','create','已添加。',24,1),(16,'2020-10-13 01:14:27.269693','127.0.0.1','2','价格优惠:限时折扣,优惠条件:100,优惠值:*0.8','change','修改 discount_type 和 sale',23,1),(17,'2020-10-13 01:14:45.946955','127.0.0.1','2','活动:双10大优惠-课程:7天python从入门到放弃-优惠值:*0.8','create','已添加。',24,1),(18,'2020-10-13 02:26:11.032154','127.0.0.1','1','10元优惠券[满200元可以使用]','change','修改 condition',27,1),(19,'2020-10-13 04:06:52.276872','127.0.0.1','2','[系统赠送]None获得10积分','create','已添加。',29,1),(20,'2020-10-13 04:07:35.971160','127.0.0.1','1','root','change','修改 last_login，name 和 mobile',14,1),(21,'2020-10-13 04:07:50.291622','127.0.0.1','2','[系统赠送]小飞机获得1000积分','change','修改 number',29,1),(22,'2020-10-13 04:23:05.485743','127.0.0.1',NULL,'','delete','批量删除 3 个 积分',NULL,1),(23,'2020-10-13 04:24:14.137279','127.0.0.1',NULL,'','delete','批量删除 1 个 积分',NULL,1),(24,'2020-10-13 08:58:31.988399','127.0.0.1','2','88折优惠券[购买课程<7天java从入门到放弃>可以使用]','change','修改 course',27,1);
/*!40000 ALTER TABLE `xadmin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_usersettings`
--

DROP TABLE IF EXISTS `xadmin_usersettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_usersettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(256) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_usersettings_user_id_edeabe4a_fk_ly_users_id` (`user_id`),
  CONSTRAINT `xadmin_usersettings_user_id_edeabe4a_fk_ly_users_id` FOREIGN KEY (`user_id`) REFERENCES `ly_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_usersettings`
--

LOCK TABLES `xadmin_usersettings` WRITE;
/*!40000 ALTER TABLE `xadmin_usersettings` DISABLE KEYS */;
INSERT INTO `xadmin_usersettings` VALUES (1,'dashboard:home:pos','',1),(2,'courses_activitydiscount_editform_portal',',,',1);
/*!40000 ALTER TABLE `xadmin_usersettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_userwidget`
--

DROP TABLE IF EXISTS `xadmin_userwidget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_userwidget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` varchar(256) NOT NULL,
  `widget_type` varchar(50) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_userwidget_user_id_c159233a_fk_ly_users_id` (`user_id`),
  CONSTRAINT `xadmin_userwidget_user_id_c159233a_fk_ly_users_id` FOREIGN KEY (`user_id`) REFERENCES `ly_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_userwidget`
--

LOCK TABLES `xadmin_userwidget` WRITE;
/*!40000 ALTER TABLE `xadmin_userwidget` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_userwidget` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-20 14:58:30
