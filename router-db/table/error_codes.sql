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

-- Dumping structure for table goup_router_development.error_codes
DROP TABLE IF EXISTS `error_codes`;
CREATE TABLE `error_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `response_code` varchar(45) NOT NULL COMMENT 'response code',
  `error_template` text COMMENT 'error template',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_response_template_2018904` (`response_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='This table is ued to store custome error codes for goup api';

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
