CREATE DATABASE  IF NOT EXISTS `booking_system` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `booking_system`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: booking_system
-- ------------------------------------------------------
-- Server version	5.5.27

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
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `address_line1` varchar(100) NOT NULL,
  `address_line2` varchar(100) DEFAULT NULL,
  `city` varchar(45) NOT NULL,
  `province` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  `postal_code` varchar(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'naresh','naresh','Naresh k','nnaresh@gmail.com','09032646523','Flat No. 301, Surabhi Enclave,','Road No. 14, Banjara Hills,','Hyderabad','Andhra Paresh','India','500034'),(2,'naresh123','naresh123','Naresh kumar Reddy Nallagatla','nnaresh@gmail.com','09032646523','Flat No. 301, Surabhi Enclave,','Road No. 14, Banjara Hills,','Hyderabad','Andhra Paresh','India','500034');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facility`
--

DROP TABLE IF EXISTS `facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facility`
--

LOCK TABLES `facility` WRITE;
/*!40000 ALTER TABLE `facility` DISABLE KEYS */;
INSERT INTO `facility` VALUES (1,'Badminton'),(2,'Squash'),(3,'Lawn Tennis'),(4,'Table Tennis');
/*!40000 ALTER TABLE `facility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facility_instances`
--

DROP TABLE IF EXISTS `facility_instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility_instances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facility_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `facility_id_idx` (`facility_id`),
  CONSTRAINT `facility_id` FOREIGN KEY (`facility_id`) REFERENCES `facility` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facility_instances`
--

LOCK TABLES `facility_instances` WRITE;
/*!40000 ALTER TABLE `facility_instances` DISABLE KEYS */;
INSERT INTO `facility_instances` VALUES (1,1,'Court 1'),(2,1,'Court 2'),(3,1,'Court 3'),(4,1,'Court 4'),(5,2,'Court 1'),(6,2,'Court 2'),(7,2,'Court 3'),(8,2,'Court 4'),(9,3,'Court 1'),(10,3,'Court 2'),(11,3,'Court 3'),(12,3,'Court 4'),(13,4,'Table 1'),(14,4,'Table 2'),(15,4,'Table 3'),(16,4,'Table 4');
/*!40000 ALTER TABLE `facility_instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_query`
--

DROP TABLE IF EXISTS `user_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_query` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `query` text NOT NULL,
  `is_resolved` bit(1) NOT NULL DEFAULT b'0',
  `submitted_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_query`
--

LOCK TABLES `user_query` WRITE;
/*!40000 ALTER TABLE `user_query` DISABLE KEYS */;
INSERT INTO `user_query` VALUES (-1,'test','86574116','nnaresh@gmail.com','test','\0','2013-04-18 13:00:11'),(1,'Naresh kumar Reddy Nallagatla','09032646523','nnaresh@gmail.com','this is a test query which is going to be longer than the previous one.. check this..check this..check this..check this..check this..check this..check this..check this..check this..check this..check this..','\0','2013-04-18 13:13:35');
/*!40000 ALTER TABLE `user_query` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `facility_instance_id` int(11) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `booking_from` int(11) NOT NULL,
  `booking_to` int(11) NOT NULL,
  `is_cancelled` bit(1) NOT NULL DEFAULT b'0',
  `cancellation_date` timestamp NULL DEFAULT NULL,
  `booking_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id_idx` (`customer_id`),
  KEY `facility_instance_id_idx` (`facility_instance_id`),
  CONSTRAINT `customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `facility_instance_id` FOREIGN KEY (`facility_instance_id`) REFERENCES `facility_instances` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,1,5,'2013-04-18 15:44:18',8,9,'\0',NULL,'2013-04-18'),(2,1,5,'2013-04-18 15:44:18',9,10,'\0',NULL,'2013-04-19'),(3,1,5,'2013-04-18 15:44:47',8,9,'\0',NULL,'2013-04-19'),(4,1,5,'2013-04-18 15:44:47',9,10,'\0',NULL,'2013-04-19'),(5,1,5,'2013-04-18 16:33:38',12,13,'\0',NULL,'2013-04-19');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping routines for database 'booking_system'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-04-19  1:30:24
