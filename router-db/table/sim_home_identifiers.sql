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

-- Dumping structure for table goup_router_development.sim_home_identifiers
DROP TABLE IF EXISTS `sim_home_identifiers`;
CREATE TABLE IF NOT EXISTS `sim_home_identifiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `name` varchar(256) DEFAULT NULL COMMENT 'name if unique sim id Such as iccid,ban,imsi etc',
  `sim_identfier_bin` binary(16) DEFAULT NULL COMMENT 'belongs to which unique identifier',
  `sim_id` varchar(256) DEFAULT NULL COMMENT 'value of sim identifier',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='This is  unique mapping of unique sime identifier with  sim id ';

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
