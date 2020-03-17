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

-- Dumping structure for table goup_router_development.interfaces
DROP TABLE IF EXISTS `interfaces`;
CREATE TABLE `interfaces` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `name` varchar(256) DEFAULT NULL COMMENT 'name of application (interfaces)',
  `mysql_host` varchar(64) DEFAULT NULL COMMENT 'host address of db ',
  `mysql_port` varchar(64) DEFAULT NULL COMMENT 'port of db server',
  `mysql_username` varchar(64) DEFAULT NULL COMMENT 'username  of db ',
  `mysql_password` varchar(64) DEFAULT NULL COMMENT 'password of db',
  `mysql_password_salt` varchar(64) DEFAULT NULL COMMENT 'salt of password',
  `version` varchar(45) DEFAULT NULL COMMENT 'version of interfaces',
  `database_name` varchar(45) DEFAULT NULL COMMENT 'name of database',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='This table is used to store details of application and mysql connection string';

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
