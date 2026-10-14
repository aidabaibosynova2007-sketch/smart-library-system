-- MySQL dump 10.13  Distrib 9.6.0, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: smart_library
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Books`
--

DROP TABLE IF EXISTS `Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Books` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genre` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publication_year` int DEFAULT NULL,
  `total_copies` int NOT NULL DEFAULT '1',
  `available_copies` int NOT NULL DEFAULT '1',
  `hall` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shelf` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`book_id`),
  CONSTRAINT `chk_copies` CHECK (((`total_copies` >= 0) and (`available_copies` >= 0) and (`available_copies` <= `total_copies`)))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Books`
--

LOCK TABLES `Books` WRITE;
/*!40000 ALTER TABLE `Books` DISABLE KEYS */;
INSERT INTO `Books` VALUES (1,'Абай жолы','Мұхтар Әуезов','Роман',1942,5,4,'A1','S01'),(2,'Менің атым Қожа','Бердібек Соқпақбаев','Повесть',1957,4,4,'A1','S02'),(3,'Көшпенділер','Ілияс Есенберлин','Тарихи роман',1969,6,6,'A2','S03'),(4,'Қан мен тер','Әбдіжәміл Нұрпейісов','Роман',1961,3,3,'A2','S04'),(5,'Қара сөздер','Абай Құнанбайұлы','Философия',1890,5,4,'A3','S05'),(6,'Python негіздері','Оқу ұжымы','IT',2022,8,7,'B1','S06'),(7,'Деректер қоры','Оқу ұжымы','IT',2023,7,7,'B1','S07'),(8,'Алгоритмдер','Оқу ұжымы','IT',2021,6,5,'B2','S08'),(9,'Жасанды интеллект','Оқу ұжымы','IT',2024,5,5,'B2','S09'),(10,'Веб бағдарламалау','Оқу ұжымы','IT',2023,6,6,'B3','S10'),(11,'Практикалық тексеру','Аида Байбосын','IT',2026,3,3,'B1','S11'),(12,'Smart Library тест кітабы','Аида Байбосын','IT',2026,3,3,'B1','S11'),(13,'Smart Library тест кітабы','Аида Байбосын','IT',2026,3,3,'B1','S12');
/*!40000 ALTER TABLE `Books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `position` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_employee_user` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (1,6,'Әкімші'),(2,7,'Кітапханашы'),(3,8,'Броньдау қызметкері');
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LibraryCards`
--

DROP TABLE IF EXISTS `LibraryCards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LibraryCards` (
  `card_id` int NOT NULL AUTO_INCREMENT,
  `reader_id` int NOT NULL,
  `issue_date` date NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`card_id`),
  UNIQUE KEY `reader_id` (`reader_id`),
  CONSTRAINT `fk_card_reader` FOREIGN KEY (`reader_id`) REFERENCES `Readers` (`reader_id`),
  CONSTRAINT `chk_card_status` CHECK ((`status` in (_utf8mb4'active',_utf8mb4'blocked')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LibraryCards`
--

LOCK TABLES `LibraryCards` WRITE;
/*!40000 ALTER TABLE `LibraryCards` DISABLE KEYS */;
INSERT INTO `LibraryCards` VALUES (1,1,'2026-09-01','blocked'),(2,2,'2026-09-02','active'),(3,3,'2026-09-03','active'),(4,4,'2026-09-04','active'),(5,5,'2026-09-05','blocked');
/*!40000 ALTER TABLE `LibraryCards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Loans`
--

DROP TABLE IF EXISTS `Loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Loans` (
  `loan_id` int NOT NULL AUTO_INCREMENT,
  `reader_id` int NOT NULL,
  `book_id` int NOT NULL,
  `loan_date` date NOT NULL,
  `due_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`loan_id`),
  KEY `fk_loan_reader` (`reader_id`),
  KEY `fk_loan_book` (`book_id`),
  CONSTRAINT `fk_loan_book` FOREIGN KEY (`book_id`) REFERENCES `Books` (`book_id`),
  CONSTRAINT `fk_loan_reader` FOREIGN KEY (`reader_id`) REFERENCES `Readers` (`reader_id`),
  CONSTRAINT `chk_loan_dates` CHECK (((`due_date` >= `loan_date`) and ((`return_date` is null) or (`return_date` >= `loan_date`)))),
  CONSTRAINT `chk_loan_status` CHECK ((`status` in (_utf8mb4'borrowed',_utf8mb4'returned',_utf8mb4'overdue')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Loans`
--

LOCK TABLES `Loans` WRITE;
/*!40000 ALTER TABLE `Loans` DISABLE KEYS */;
INSERT INTO `Loans` VALUES (1,1,1,'2026-09-15','2026-09-29',NULL,'overdue'),(2,2,3,'2026-09-20','2026-10-04','2026-10-01','returned'),(3,3,5,'2026-10-01','2026-10-15',NULL,'borrowed'),(4,4,6,'2026-10-02','2026-10-16',NULL,'borrowed'),(5,5,8,'2026-09-10','2026-09-24',NULL,'overdue');
/*!40000 ALTER TABLE `Loans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Readers`
--

DROP TABLE IF EXISTS `Readers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Readers` (
  `reader_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`reader_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_reader_user` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Readers`
--

LOCK TABLES `Readers` WRITE;
/*!40000 ALTER TABLE `Readers` DISABLE KEYS */;
INSERT INTO `Readers` VALUES (1,1,'+77000000001'),(2,2,'+77000000002'),(3,3,'+77000000003'),(4,4,'+77000000004'),(5,5,'+77000000005');
/*!40000 ALTER TABLE `Readers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservations`
--

DROP TABLE IF EXISTS `Reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reservations` (
  `reservation_id` int NOT NULL AUTO_INCREMENT,
  `reader_id` int NOT NULL,
  `book_id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `reservation_date` date NOT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `fk_res_reader` (`reader_id`),
  KEY `fk_res_book` (`book_id`),
  KEY `fk_res_employee` (`employee_id`),
  CONSTRAINT `fk_res_book` FOREIGN KEY (`book_id`) REFERENCES `Books` (`book_id`),
  CONSTRAINT `fk_res_employee` FOREIGN KEY (`employee_id`) REFERENCES `Employees` (`employee_id`),
  CONSTRAINT `fk_res_reader` FOREIGN KEY (`reader_id`) REFERENCES `Readers` (`reader_id`),
  CONSTRAINT `chk_res_status` CHECK ((`status` in (_utf8mb4'pending',_utf8mb4'confirmed',_utf8mb4'ready',_utf8mb4'cancelled')))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservations`
--

LOCK TABLES `Reservations` WRITE;
/*!40000 ALTER TABLE `Reservations` DISABLE KEYS */;
INSERT INTO `Reservations` VALUES (1,1,2,3,'2026-10-01','ready'),(2,2,4,3,'2026-10-02','confirmed'),(3,3,7,3,'2026-10-03','confirmed'),(4,4,9,3,'2026-10-04','pending'),(5,1,10,3,'2026-10-05','ready');
/*!40000 ALTER TABLE `Reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `chk_user_role` CHECK ((`role` in (_utf8mb4'reader',_utf8mb4'admin',_utf8mb4'librarian',_utf8mb4'booking_staff')))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'Айдана Серік','aidana@example.com','reader'),(2,'Нұржан Әли','nurzhan@example.com','reader'),(3,'Аружан Ермек','aruzhan@example.com','reader'),(4,'Данияр Болат','daniyar@example.com','reader'),(5,'Мадина Асқар','madina@example.com','reader'),(6,'Аида Байбосын','aida.admin@example.com','admin'),(7,'Іңкәр Әділхан','inkar.library@example.com','librarian'),(8,'Ерке Өмірзақ','erke.booking@example.com','booking_staff');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-14 16:12:50
