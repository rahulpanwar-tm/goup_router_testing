-- --------------------------------------------------------
-- Host:                         192.168.1.117
-- Server version:               5.7.21 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table goup_router_development_ui.file_registration
DROP TABLE IF EXISTS `file_registration`;
CREATE TABLE `file_registration` (
  `id` int(16) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `file_name` varchar(255) DEFAULT NULL COMMENT 'name of file',
  `file_path` varchar(255) DEFAULT NULL COMMENT 'path of file',
  `uploaded_on` int(16) DEFAULT NULL COMMENT 'uploaded time',
  `uploaded_by` varchar(255) DEFAULT NULL COMMENT 'uploaded by ',
  `description` varchar(255) DEFAULT NULL COMMENT 'description',
  `is_fault` tinyint(4) DEFAULT NULL COMMENT 'file is faulty or not',
  `is_status` int(16) DEFAULT NULL COMMENT 'what is status for file',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='This table is used to store uploaded files';

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
