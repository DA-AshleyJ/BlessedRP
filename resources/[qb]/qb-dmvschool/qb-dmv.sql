-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.17-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for qbcoreframework_78c438
CREATE DATABASE IF NOT EXISTS `qbcoreframework_78c438` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `qbcoreframework_78c438`;

-- Dumping structure for table qbcoreframework_78c438.qb_dmv
CREATE TABLE IF NOT EXISTS `qb_dmv` (
  `id` varchar(100) NOT NULL,
  `citizenid` varchar(50) NOT NULL,
  `type` varchar(50) DEFAULT '0',
  `mistakes` varchar(50) DEFAULT '0',
  `created` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dumping data for table qbcoreframework_78c438.qb_dmv: ~0 rows (approximately)
/*!40000 ALTER TABLE `qb_dmv` DISABLE KEYS */;
/*!40000 ALTER TABLE `qb_dmv` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
