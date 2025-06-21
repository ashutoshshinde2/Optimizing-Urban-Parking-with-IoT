
/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: SmartParkingSys
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-0+deb12u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts_customuser`
--

DROP TABLE IF EXISTS `accounts_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_customuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_customuser_email_4fd8e7ce_uniq` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_customuser`
--

LOCK TABLES `accounts_customuser` WRITE;
/*!40000 ALTER TABLE `accounts_customuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add content type',4,'add_contenttype'),
(14,'Can change content type',4,'change_contenttype'),
(15,'Can delete content type',4,'delete_contenttype'),
(16,'Can view content type',4,'view_contenttype'),
(17,'Can add session',5,'add_session'),
(18,'Can change session',5,'change_session'),
(19,'Can delete session',5,'delete_session'),
(20,'Can view session',5,'view_session'),
(21,'Can add site',6,'add_site'),
(22,'Can change site',6,'change_site'),
(23,'Can delete site',6,'delete_site'),
(24,'Can view site',6,'view_site'),
(25,'Can add user',7,'add_customuser'),
(26,'Can change user',7,'change_customuser'),
(27,'Can delete user',7,'delete_customuser'),
(28,'Can view user',7,'view_customuser'),
(29,'Can add user',8,'add_user'),
(30,'Can change user',8,'change_user'),
(31,'Can delete user',8,'delete_user'),
(32,'Can view user',8,'view_user'),
(33,'Can add users',9,'add_users'),
(34,'Can change users',9,'change_users'),
(35,'Can delete users',9,'delete_users'),
(36,'Can view users',9,'view_users');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `parking_id` int(11) NOT NULL,
  `booking_time` timestamp NOT NULL,
  `start_time` timestamp NOT NULL,
  `end_time` timestamp NOT NULL,
  `status` enum('valid','checked in','checked out','expired','invalid') NOT NULL,
  `checkin_time` timestamp NULL DEFAULT NULL,
  `checkout_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `user_id_idx` (`user_id`),
  KEY `parking_id_idx` (`parking_id`),
  CONSTRAINT `fk_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `parkings` (`parking_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1272238 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES
(100,1,1,'2025-04-07 07:17:43','2025-04-07 20:17:43','2025-04-07 22:17:43','expired','2025-04-07 20:29:32','2025-04-07 19:01:04'),
(101,1,1,'2025-04-08 07:17:43','2025-04-08 07:17:43','2025-04-08 20:09:00','expired',NULL,NULL),
(102,1,1,'2025-04-19 00:00:00','2025-04-19 10:00:00','2025-04-19 23:00:00','expired','2025-04-19 19:10:51','2025-04-19 18:59:56'),
(103,3,1,'2025-04-12 08:15:56','2025-04-12 11:16:11','2025-04-12 15:16:27','expired','2025-04-12 16:09:09','2025-04-12 16:14:50'),
(104,1,1,'2025-05-03 10:12:56','2025-05-03 10:30:00','2025-05-03 21:12:56','expired','2025-05-03 16:43:01',NULL),
(105,1,1,'2025-05-03 10:12:56','2025-05-03 10:30:00','2025-05-03 21:12:56','expired','2025-05-03 19:14:33','2025-05-03 19:05:33'),
(1272225,18,1,'2025-05-30 13:28:50','2025-05-30 18:58:00','2025-05-30 19:58:00','expired',NULL,NULL),
(1272226,18,1,'2025-05-30 13:51:29','2025-05-30 19:21:00','2025-05-30 20:21:00','expired',NULL,NULL),
(1272227,18,1,'2025-05-30 13:58:15','2025-05-30 19:21:00','2025-05-30 20:21:00','expired',NULL,NULL),
(1272228,23,1,'2025-05-30 18:38:07','2025-05-31 10:00:00','2025-05-31 11:00:00','expired',NULL,NULL),
(1272229,23,1,'2025-05-30 19:00:29','2025-05-31 06:00:00','2025-05-31 07:00:00','expired',NULL,NULL),
(1272230,23,1,'2025-05-30 19:12:59','2025-05-31 06:12:00','2025-05-31 07:12:00','checked out',NULL,NULL),
(1272231,23,1,'2025-05-30 19:13:57','2025-05-31 06:13:00','2025-05-31 07:13:00','expired',NULL,NULL),
(1272232,23,1,'2025-05-30 19:14:19','2025-05-31 06:14:00','2025-05-31 07:14:00','expired',NULL,NULL),
(1272233,24,1,'2025-05-30 19:40:00','2025-05-30 19:45:00','2025-05-30 20:45:00','expired',NULL,NULL),
(1272234,18,1,'2025-05-31 05:41:51','2025-05-31 05:41:00','2025-05-31 06:41:00','expired','2025-05-31 11:46:51',NULL),
(1272235,18,1,'2025-05-31 06:20:59','2025-05-31 06:20:00','2025-05-31 08:20:00','expired','2025-05-31 12:11:44',NULL),
(1272236,26,1,'2025-06-11 04:40:12','2025-06-11 04:39:00','2025-06-11 05:39:00','expired',NULL,NULL),
(1272237,18,1,'2025-06-21 10:03:29','2025-06-21 10:03:00','2025-06-21 11:03:00','valid',NULL,NULL);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_accounts_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES
(7,'accounts','customuser'),
(9,'accounts','users'),
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(8,'auth','user'),
(4,'contenttypes','contenttype'),
(5,'sessions','session'),
(6,'sites','site');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES
(1,'contenttypes','0001_initial','2025-04-02 11:21:16.981008'),
(2,'contenttypes','0002_remove_content_type_name','2025-04-02 11:21:18.370322'),
(3,'auth','0001_initial','2025-04-02 11:21:21.313287'),
(4,'auth','0002_alter_permission_name_max_length','2025-04-02 11:21:21.911682'),
(5,'auth','0003_alter_user_email_max_length','2025-04-02 11:21:22.142937'),
(6,'auth','0004_alter_user_username_opts','2025-04-02 11:21:22.368843'),
(7,'auth','0005_alter_user_last_login_null','2025-04-02 11:21:22.647214'),
(8,'auth','0006_require_contenttypes_0002','2025-04-02 11:21:22.869693'),
(9,'auth','0007_alter_validators_add_error_messages','2025-04-02 11:21:23.139934'),
(10,'auth','0008_alter_user_username_max_length','2025-04-02 11:21:23.387648'),
(11,'auth','0009_alter_user_last_name_max_length','2025-04-02 11:21:23.613040'),
(12,'auth','0010_alter_group_name_max_length','2025-04-02 11:21:24.130591'),
(13,'auth','0011_update_proxy_permissions','2025-04-02 11:21:25.166037'),
(14,'auth','0012_alter_user_first_name_max_length','2025-04-02 11:21:25.441987'),
(15,'accounts','0001_initial','2025-04-02 11:21:29.630797'),
(16,'accounts','0002_alter_customuser_email','2025-04-02 11:21:30.097591'),
(17,'admin','0001_initial','2025-04-02 11:21:31.555289'),
(18,'admin','0002_logentry_remove_auto_add','2025-04-02 11:21:31.788814'),
(19,'admin','0003_logentry_add_action_flag_choices','2025-04-02 11:21:32.025899'),
(20,'sessions','0001_initial','2025-04-02 11:21:32.995089'),
(21,'sites','0001_initial','2025-04-02 11:21:33.466207'),
(22,'sites','0002_alter_domain_unique','2025-04-02 11:21:33.932126'),
(23,'accounts','0003_alter_customuser_options_alter_customuser_managers_and_more','2025-04-02 12:58:32.734396'),
(24,'accounts','0004_remove_customuser_mobileno_and_more','2025-04-02 13:25:01.339431'),
(25,'accounts','0005_users_delete_customuser','2025-04-04 23:43:25.296268'),
(26,'accounts','0006_remove_users_id_users_groups_users_is_active_and_more','2025-04-05 00:17:14.173370'),
(27,'accounts','0007_delete_users','2025-04-05 00:19:33.157223');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES
('ix52dkactys2atnhfdu9tax99knrd6sh','.eJxtj8sKgzAQRX-lzFolRpSSVaE_0EX3IY1TmzYmkkehiP_eUemuy7nn3gMzQ44YpOlB1McCcFTGgoCnGjHy07CelfYjFHDP1kpH-Q8ftEUViOgcArokb96_jBtAzGC9Vsl4R91LdkilNz4MDWT6TKvhvC1jUiHJZDYpZ7wtWVfy-lq3ommIo-v_0W6nUzCaUMMqRirr0_7GsnwBKk1CaA:1uSv4T:gVnF19W-1hZj6y2998l8qV5ntaWEGDaTUKHEdpolCZQ','2025-06-22 10:03:37.671400'),
('lumm1vf0c91ch6mqkwrb3oqvzcyhrm53','.eJxtj0EKwjAQRa8is25L0lKRrAQv4MJ9iOlYo2lS0okgpXd3bHHncv77_8HMkCdM2nWg5KEAHIzzoOBhBpzqY_89KxsHKOCWvdeB8x_eWY8mMbE5JQykrzE-XehBzeCjNeRi4O45B-TSC--OB5re49dwWpcTmUSa3CqtRd2Woi0beZFStYI5hu4fbTY6JmcZ7UUlWOUjbW8sywco00Ji:1uLGkm:P_0gziIKyV4NyVEtfwfpL3T8hEaPwXj6qZCB_EnO6Z4','2025-06-01 07:35:40.683850'),
('noofu3175o8ocxktusx19m5fli46uvej','.eJxtj8sKwjAQRX9FZt2WpGLBrBQ_QfchpmMzmCYlj4KU_rupunR7z-HAXSBHDJJ6EG1XAY6KLAhQ0eTkozkN29BoP0IFj2ytdGrEIpx_wu5qyPVYqM4hoEvy7v2T3ABiAeu1SuRd8WcalSvWjIa0RZle05a5qFDGmFRIMtGn3LL2ULOu5vzGmWDHwtH1_yj_0imQLmjPGlZS1qfPG76ub79aRaQ:1uPDGx:T_wMZeH8gOp-rYyrIgpzfuUXA1mxi708ttma6beNFHc','2025-06-12 04:41:11.204419');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES
(1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parking_slots`
--

DROP TABLE IF EXISTS `parking_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `parking_slots` (
  `parking_id` int(11) NOT NULL,
  `slot_number` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `last_updated` timestamp NOT NULL,
  `booking_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`parking_id`,`slot_number`),
  KEY `booking_id_idx` (`booking_id`),
  CONSTRAINT `booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `parking_id` FOREIGN KEY (`parking_id`) REFERENCES `parkings` (`parking_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking_slots`
--

LOCK TABLES `parking_slots` WRITE;
/*!40000 ALTER TABLE `parking_slots` DISABLE KEYS */;
INSERT INTO `parking_slots` VALUES
(1,'Gate1',1,'2025-05-31 06:42:16',NULL),
(1,'SLO1',1,'2025-06-21 10:03:30',1272237),
(1,'SLO2',1,'2025-05-31 06:42:14',NULL),
(1,'SLO3',1,'2025-05-31 06:42:16',NULL);
/*!40000 ALTER TABLE `parking_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parkings`
--

DROP TABLE IF EXISTS `parkings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `parkings` (
  `parking_id` int(11) NOT NULL,
  `longitude` varchar(45) NOT NULL,
  `latitude` varchar(45) NOT NULL DEFAULT 'CURRENT_TIMESTAMP',
  `address` longtext NOT NULL,
  `timestamp` timestamp(6) NULL DEFAULT NULL,
  `ratings` varchar(45) DEFAULT NULL,
  `mobileno` varchar(45) NOT NULL,
  `total_slots` varchar(45) NOT NULL,
  `available_slots` varchar(45) NOT NULL,
  `prising_per_hour` varchar(45) NOT NULL,
  `admin_id` int(11) NOT NULL,
  PRIMARY KEY (`parking_id`),
  UNIQUE KEY `parking_id_UNIQUE` (`parking_id`),
  UNIQUE KEY `address_UNIQUE` (`address`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parkings`
--

LOCK TABLES `parkings` WRITE;
/*!40000 ALTER TABLE `parkings` DISABLE KEYS */;
INSERT INTO `parkings` VALUES
(1,'73.91675648453692','18.56168550909574','Phoenix Marketcity, 207, Nagar Rd, Clover Park, Viman Nagar, Pune, Maharashtra 411014',NULL,'4.7','7219686060','3','3','30',2),
(2,'73.98205923602778','18.573407886936565','G H RAISONI College OF ENGINEERING AND Management, Domkhel Rd, Wageshwar Nagar, Wagholi, Pune, Maharashtra 412207',NULL,'4','7219686060','3','0','30',2),
(3,'73.931274','18.519882','Seasons Mall, Magarpatta, Hadapsar, Pune, Maharashtra 411013',NULL,'4.5','7219686060','0','0','30',2),
(4,'73.8567','18.5204','Mundhwa - Kharadi Rd, Amanora Park Town, Hadapsar, Pune, Maharashtra 411028',NULL,'4.6','7219686060','0','0','30',2);
/*!40000 ALTER TABLE `parkings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_id` int(11) NOT NULL,
  `amount` varchar(45) NOT NULL,
  `payment_method` varchar(45) DEFAULT NULL,
  `status` enum('pending','completed','failed','refunded','canceled','expired') NOT NULL,
  `payment_time` timestamp NOT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `payment_id_UNIQUE` (`payment_id`),
  KEY `fk_booking_id_idx` (`booking_id`),
  CONSTRAINT `fk_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES
(1,100,'50','UPI','completed','2025-04-07 07:17:43'),
(2,101,'75','UPI','completed','2025-04-08 00:00:00'),
(3,102,'50','UPI','completed','2025-04-12 15:14:59'),
(4,103,'75','Debit Card','completed','2025-04-12 07:17:42'),
(5,104,'25','UPI','completed','2025-04-17 18:15:00'),
(6,105,'100','UPI','completed','2025-04-17 18:15:13'),
(7,1272226,'30','UPI','completed','2025-05-30 13:51:29'),
(8,1272227,'30','UPI','completed','2025-05-30 13:58:16'),
(9,1272228,'30','UPI','completed','2025-05-30 18:38:07'),
(10,1272229,'30','UPI','completed','2025-05-30 19:00:29'),
(11,1272230,'30','UPI','completed','2025-05-30 19:12:59'),
(12,1272231,'30','UPI','completed','2025-05-30 19:13:57'),
(13,1272232,'30','UPI','completed','2025-05-30 19:14:19'),
(14,1272233,'30','UPI','completed','2025-05-30 19:40:00'),
(15,1272234,'30','UPI','completed','2025-05-31 05:41:51'),
(16,1272235,'60','UPI','completed','2025-05-31 06:20:59'),
(17,1272236,'30','UPI','completed','2025-06-11 04:40:12'),
(18,1272237,'30','UPI','completed','2025-06-21 10:03:30');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile` varchar(45) DEFAULT NULL,
  `timestamp` timestamp(6) NULL DEFAULT current_timestamp(6),
  `address` longtext DEFAULT NULL,
  `mobileno` varchar(10) NOT NULL,
  `user_type` varchar(45) NOT NULL DEFAULT 'user',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'Ashutsh','Shinde','ashu@gmail.com','Pass@123',NULL,'2025-04-03 09:00:00.000000',NULL,'7972082468','user'),
(2,'Parking1','admin','admin@gmail.com','e86f78a8a3caf0b60d8e74e5942aa6d86dc150cd3c03338aef25b7d2d7e3acc7',NULL,'2025-04-03 09:00:00.000000',NULL,'7972082468','admin'),
(3,'Akshay','Umbarge','akshayumbarge6721@gmail.com','00000000',NULL,'2025-04-05 01:06:22.763285',NULL,'7219686060','user'),
(4,'Walter','White','walter2@gmail.com','pbkdf2_sha256$1000000$YpxLzDlkhdRh1PvJrwjMea$BKExX9lDErJ+VpAqyQrSUFrCyOLDgpEaVyzt48cB/ts=',NULL,'2025-04-20 19:47:41.675165',NULL,'1234567890','user'),
(18,'james','clear','james2@gmail.com','pbkdf2_sha256$1000000$6HQBNArmj2w4387qWgw3XA$t9Tz6nsBLuB5/31shF69Dma40YvqZmdbRHHfEZbRPcA=',NULL,'2025-04-20 20:22:16.000000',NULL,'8520025878','user'),
(19,'Ashutosh','Shinde','ashu1@gmail.comx','pbkdf2_sha256$1000000$OVmhRJzfHYTueMmtjwjJMs$ts7MpLs+PAKhFIIAFs2teSnmCmF4GE+4KZ3Xma+7RLw=',NULL,'2025-04-22 17:24:26.000000',NULL,'7894561230','user'),
(22,'Ragnar','Lothbrok','ragnar01@gmail.com','pbkdf2_sha256$1000000$rizt6e47SMV1XNBgB5y7PL$7MBB0VOUp4nklJuaTO6Q088XlugM4VUl/0jtz6/P7X0=',NULL,'2025-05-29 23:05:32.000000',NULL,'0000000000','user'),
(23,'Ashutosh','Shinde','shindeashutosh534@gmail.com','pbkdf2_sha256$1000000$JdjpNAXHzrFYrac4NDaMLP$tF3ZKFXqRtaZBNxUmAZCvAhC1PxC0MECAJ7QsssQBZs=',NULL,'2025-05-30 18:35:19.000000',NULL,'7972082468','user'),
(24,'Aditya','Bhosle','weebedits1426@gmail.com','pbkdf2_sha256$1000000$rGJZ9XDrtNcsT3TLylUVxF$AD8OZOzBghlYEU6Z+BI8Yf+ls0pmsytP3GbYOzfCuiI=',NULL,'2025-05-30 19:39:09.000000',NULL,'8956409848','user'),
(25,'Ganesh','Phulmante','ganeshphulmante2003@gmail.com','pbkdf2_sha256$1000000$giTTCFGWTuyndMMLOSJJIa$dJpNTODbmEEp1Uvlxf8XR4S2BCcEkxNN/VZe6CSZpjw=',NULL,'2025-05-31 05:19:14.000000',NULL,'9527149847','user'),
(26,'Ashutosh','Shinde','ashutosh@gmail.com','pbkdf2_sha256$1000000$UW4pFpAEvfGmOeuzdanykc$ltrt0QGpRavUpMWqTCixlkWcCL87p0QAxXTbJOoZ4cQ=',NULL,'2025-06-11 04:39:19.000000',NULL,'7972082468','user');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-21 15:59:41
