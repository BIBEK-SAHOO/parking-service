-- MySQL dump 10.13  Distrib 5.7.33, for Linux (x86_64)
--
-- Host: localhost    Database: parking_service
-- ------------------------------------------------------
-- Server version	5.7.33-0ubuntu0.18.04.1

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add parking spot',7,'add_parkingspot'),(26,'Can change parking spot',7,'change_parkingspot'),(27,'Can delete parking spot',7,'delete_parkingspot'),(28,'Can view parking spot',7,'view_parkingspot'),(29,'Can add reservation',8,'add_reservation'),(30,'Can change reservation',8,'change_reservation'),(31,'Can delete reservation',8,'delete_reservation'),(32,'Can view reservation',8,'view_reservation'),(33,'Can add SMS Verification',9,'add_smsverification'),(34,'Can change SMS Verification',9,'change_smsverification'),(35,'Can delete SMS Verification',9,'delete_smsverification'),(36,'Can view SMS Verification',9,'view_smsverification'),(37,'Can add Token',10,'add_token'),(38,'Can change Token',10,'change_token'),(39,'Can delete Token',10,'delete_token'),(40,'Can view Token',10,'view_token'),(41,'Can add token',11,'add_tokenproxy'),(42,'Can change token',11,'change_tokenproxy'),(43,'Can delete token',11,'delete_tokenproxy'),(44,'Can view token',11,'view_tokenproxy'),(45,'Can add phone',12,'add_phone'),(46,'Can change phone',12,'change_phone'),(47,'Can delete phone',12,'delete_phone'),(48,'Can view phone',12,'view_phone');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('4992cf62e559ef3a5622efd2c575d094c2b07ab2','2021-02-04 18:15:05.131881',2),('683eda920ed807ad0c7af5c7770556c0d94b19c7','2021-02-05 19:26:32.230543',3),('bcbbc79e931bccb769b07b072978a351fea81d54','2021-02-03 10:15:10.986403',1);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
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
  KEY `django_admin_log_user_id_c564eba6_fk_users_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2021-02-04 05:08:01.435128','3','Shaniwar Wada',1,'[{\"added\": {}}]',7,1),(2,'2021-02-04 05:09:03.056163','4','Kamla Nehru Hospital',1,'[{\"added\": {}}]',7,1),(3,'2021-02-04 05:10:44.045284','5','Raja Dinkar Kelkar Museum',1,'[{\"added\": {}}]',7,1),(4,'2021-02-04 05:12:19.319523','6','Pune Airport',1,'[{\"added\": {}}]',7,1),(5,'2021-02-04 05:13:17.467586','7','Kalyani Nagar',1,'[{\"added\": {}}]',7,1),(6,'2021-02-04 05:14:11.230002','8','PSK',1,'[{\"added\": {}}]',7,1),(7,'2021-02-04 05:15:32.182242','9','Wagheswar Lake',1,'[{\"added\": {}}]',7,1),(8,'2021-02-04 05:16:34.549696','10','Hinjewadi',1,'[{\"added\": {}}]',7,1),(9,'2021-02-04 18:53:25.114003','2','7978572062',3,'',12,1),(10,'2021-02-04 18:53:25.116067','1','79785',3,'',12,1),(11,'2021-02-04 19:17:42.966121','3','Shaniwar Wada',3,'',8,1),(12,'2021-02-04 19:17:42.967192','2','Shaniwar Wada',3,'',8,1),(13,'2021-02-04 19:17:43.145666','1','Shaniwar Wada',3,'',8,1),(14,'2021-02-06 07:54:27.561569','17','Kalyani Nagar',3,'',8,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(10,'authtoken','token'),(11,'authtoken','tokenproxy'),(4,'contenttypes','contenttype'),(7,'parking','parkingspot'),(8,'parking','reservation'),(9,'phone_verify','smsverification'),(5,'sessions','session'),(12,'users','phone'),(6,'users','user');
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'users','0001_initial','2021-02-03 03:04:42.883573'),(2,'contenttypes','0001_initial','2021-02-03 03:04:43.767529'),(3,'admin','0001_initial','2021-02-03 03:04:44.298062'),(4,'admin','0002_logentry_remove_auto_add','2021-02-03 03:04:46.630157'),(5,'admin','0003_logentry_add_action_flag_choices','2021-02-03 03:04:46.698043'),(6,'contenttypes','0002_remove_content_type_name','2021-02-03 03:04:48.080639'),(7,'auth','0001_initial','2021-02-03 03:04:49.652582'),(8,'auth','0002_alter_permission_name_max_length','2021-02-03 03:04:53.301708'),(9,'auth','0003_alter_user_email_max_length','2021-02-03 03:04:53.379476'),(10,'auth','0004_alter_user_username_opts','2021-02-03 03:04:53.451412'),(11,'auth','0005_alter_user_last_login_null','2021-02-03 03:04:53.521279'),(12,'auth','0006_require_contenttypes_0002','2021-02-03 03:04:53.575143'),(13,'auth','0007_alter_validators_add_error_messages','2021-02-03 03:04:53.649958'),(14,'auth','0008_alter_user_username_max_length','2021-02-03 03:04:53.720785'),(15,'auth','0009_alter_user_last_name_max_length','2021-02-03 03:04:53.791963'),(16,'auth','0010_alter_group_name_max_length','2021-02-03 03:04:53.970489'),(17,'auth','0011_update_proxy_permissions','2021-02-03 03:04:54.057801'),(18,'auth','0012_alter_user_first_name_max_length','2021-02-03 03:04:54.137907'),(19,'parking','0001_initial','2021-02-03 03:04:54.920323'),(20,'sessions','0001_initial','2021-02-03 03:04:57.429204'),(23,'authtoken','0001_initial','2021-02-03 09:52:55.552679'),(24,'authtoken','0002_auto_20160226_1747','2021-02-03 09:52:58.223898'),(25,'authtoken','0003_tokenproxy','2021-02-03 09:52:58.290994'),(26,'parking','0002_auto_20210203_1116','2021-02-03 11:16:20.130517'),(27,'users','0002_phone','2021-02-03 11:16:20.629503'),(28,'users','0003_auto_20210203_1128','2021-02-03 11:28:54.399217'),(29,'parking','0003_auto_20210204_0504','2021-02-04 05:05:25.473714'),(30,'parking','0004_auto_20210204_1601','2021-02-04 16:01:37.919249'),(31,'parking','0005_auto_20210205_1759','2021-02-05 18:00:00.797279');
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('ijrjqc5zeohmia1hmgm4cgkey8gfc8fs','.eJxVjMsOwiAQRf-FtSHDCIW6dN9vIDM8pGogKe3K-O_apAvd3nPOfQlP21r81tPi5yguQonT78YUHqnuIN6p3poMra7LzHJX5EG7nFpMz-vh_h0U6uVbJzDKZU0GnB6AXVDmPHIGykhRcWZEtJayHdEpPTBHDWhNiAGsxqDF-wPWPDeK:1l8EcY:q8pl0LYpCwq_koxB5gzcywYJlk8DG1WQPNRAAbq80BA','2021-02-20 03:50:54.888282'),('jau6v1a417np8ah1t0zr25wj1y1898n7','.eJxVjMsOwiAQRf-FtSHDCIW6dN9vIDM8pGogKe3K-O_apAvd3nPOfQlP21r81tPi5yguQonT78YUHqnuIN6p3poMra7LzHJX5EG7nFpMz-vh_h0U6uVbJzDKZU0GnB6AXVDmPHIGykhRcWZEtJayHdEpPTBHDWhNiAGsxqDF-wPWPDeK:1l7EX1:5sAdgbIX4ufxb1Nsu_LVQ01UiASdX1cc4f69HICDXek','2021-02-17 09:33:03.531054');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parking_parkingspot`
--

DROP TABLE IF EXISTS `parking_parkingspot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parking_parkingspot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parking_parkingspot_name_latitude_longitude_588a45be_uniq` (`name`,`latitude`,`longitude`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking_parkingspot`
--

LOCK TABLES `parking_parkingspot` WRITE;
/*!40000 ALTER TABLE `parking_parkingspot` DISABLE KEYS */;
INSERT INTO `parking_parkingspot` VALUES (1,'parking1',84.236298,20.470699,100),(2,'parking2',84.777069,19.30442,100),(3,'Shaniwar Wada',73.85551104804864,18.51996662547572,50),(4,'Kamla Nehru Hospital',73.8620770960461,18.52322202549133,60),(5,'Raja Dinkar Kelkar Museum',73.85426650300337,18.511258125902962,60),(6,'Pune Airport',73.90968839089297,18.58148303973742,70),(7,'Kalyani Nagar',73.90401314172944,18.54643644986023,65),(8,'PSK',73.92152533914832,18.5344451749818,55),(9,'Wagheswar Lake',73.9772500914718,18.58137116466677,80),(10,'Hinjewadi',73.7388871630372,18.591431706261744,99);
/*!40000 ALTER TABLE `parking_parkingspot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parking_reservation`
--

DROP TABLE IF EXISTS `parking_reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parking_reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_timestamp` datetime(6) NOT NULL,
  `to_timestamp` datetime(6) NOT NULL,
  `parking_spot_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `booking_status` tinyint(1) NOT NULL,
  `payment_status` varchar(250) DEFAULT NULL,
  `refund_status` varchar(250) DEFAULT NULL,
  `total_price` double NOT NULL,
  `payment_transaction_id` varchar(250) DEFAULT NULL,
  `refund_transaction_id` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parking_reservation_parking_spot_id_87cc422c_fk_parking_p` (`parking_spot_id`),
  KEY `parking_reservation_user_id_a998a6c7_fk_users_user_id` (`user_id`),
  CONSTRAINT `parking_reservation_parking_spot_id_87cc422c_fk_parking_p` FOREIGN KEY (`parking_spot_id`) REFERENCES `parking_parkingspot` (`id`),
  CONSTRAINT `parking_reservation_user_id_a998a6c7_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking_reservation`
--

LOCK TABLES `parking_reservation` WRITE;
/*!40000 ALTER TABLE `parking_reservation` DISABLE KEYS */;
INSERT INTO `parking_reservation` VALUES (4,'2021-02-06 18:30:00.000000','2021-02-06 20:15:00.000000',3,1,1,NULL,NULL,100,NULL,NULL),(5,'2021-02-06 18:30:00.000000','2021-02-06 20:15:00.000000',6,1,1,NULL,NULL,140,NULL,NULL),(6,'2021-02-07 18:30:00.000000','2021-02-07 20:15:00.000000',6,1,1,NULL,NULL,140,NULL,NULL),(7,'2021-02-08 18:30:00.000000','2021-02-09 20:15:00.000000',6,1,1,NULL,NULL,140,NULL,NULL),(8,'2021-02-08 18:30:00.000000','2021-02-10 20:15:00.000000',6,1,1,NULL,NULL,140,NULL,NULL),(9,'2021-02-11 18:30:00.000000','2021-02-12 20:15:00.000000',6,1,1,NULL,NULL,140,NULL,NULL),(10,'2021-02-11 18:30:00.000000','2021-02-12 20:15:00.000000',7,1,1,NULL,NULL,130,NULL,NULL),(11,'2021-02-13 18:30:00.000000','2021-02-14 20:15:00.000000',7,1,1,NULL,NULL,1690,NULL,NULL),(12,'2021-02-15 18:30:00.000000','2021-02-19 20:15:00.000000',7,1,1,NULL,NULL,6370,NULL,NULL),(13,'2021-02-15 18:30:00.000000','2021-02-19 20:15:00.000000',5,1,1,NULL,NULL,5880,NULL,NULL),(14,'2021-03-24 18:30:00.000000','2021-03-24 20:15:00.000000',5,1,1,NULL,NULL,120,NULL,NULL),(15,'2021-03-25 18:30:00.000000','2021-03-25 20:15:00.000000',5,1,1,NULL,NULL,120,NULL,NULL),(16,'2021-03-25 18:30:00.000000','2021-03-25 20:15:00.000000',7,1,1,NULL,NULL,130,NULL,NULL),(18,'2021-03-26 18:30:00.000000','2021-03-26 21:15:00.000000',8,1,1,'Failed',NULL,165,'MOJO1206V05N45340117',NULL);
/*!40000 ALTER TABLE `parking_reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_phone`
--

DROP TABLE IF EXISTS `users_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_phone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Mobile` bigint(20) NOT NULL,
  `isVerified` tinyint(1) NOT NULL,
  `counter` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_phone`
--

LOCK TABLES `users_phone` WRITE;
/*!40000 ALTER TABLE `users_phone` DISABLE KEYS */;
INSERT INTO `users_phone` VALUES (5,7978572062,1,4),(7,9439066624,1,2);
/*!40000 ALTER TABLE `users_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user`
--

DROP TABLE IF EXISTS `users_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_login` datetime(6) DEFAULT NULL,
  `first_name` varchar(250) DEFAULT NULL,
  `last_name` varchar(250) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `phone` varchar(30) NOT NULL,
  `password` varchar(1024) DEFAULT NULL,
  `creation_time` datetime(6) NOT NULL,
  `last_modification_time` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user`
--

LOCK TABLES `users_user` WRITE;
/*!40000 ALTER TABLE `users_user` DISABLE KEYS */;
INSERT INTO `users_user` VALUES (1,'2021-02-06 03:50:54.697649',NULL,NULL,NULL,'8280032900','pbkdf2_sha256$216000$qiz0RQK5W4zR$PxBG8ySZrQRj5TqwQRUhQZ9hooZI6tDdNYmdoHJjMQo=','2021-02-03 09:32:04.705407','2021-02-03 09:32:04.705436',1,1,1),(2,'2021-02-06 03:50:19.964218','test23',NULL,NULL,'9439066624','pbkdf2_sha256$216000$Owv7JRzqxZEP$EvLjKbSt1H//WnvnEzDXCkerP3zbehxU8+o8j35l4nU=','2021-02-04 18:13:00.227821','2021-02-05 19:43:00.813684',1,0,0),(3,'2021-02-05 19:27:02.613862',NULL,NULL,NULL,'7978572062','pbkdf2_sha256$216000$QVCOdAXjKYSo$xZhGTu5ZljE2csLn7Ex42TtXRAz9MeUdymssgTOWww4=','2021-02-04 18:54:49.036484','2021-02-04 18:54:49.153537',1,0,0);
/*!40000 ALTER TABLE `users_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-06 13:25:39
