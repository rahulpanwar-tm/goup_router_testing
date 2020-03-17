-- --------------------------------------------------------
-- Host:                         192.168.1.117
-- Server version:               5.7.22 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table comarch_testing_goup_interface_thirdparty.goup_notification_url
DROP TABLE IF EXISTS `goup_notification_url`;
CREATE TABLE IF NOT EXISTS `goup_notification_url` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'auto increment id',
  `request_id` varchar(100) DEFAULT NULL COMMENT 'request id',
  `returnUrl` varchar(100) NOT NULL COMMENT 'return url of OEM',
  `createdAT` int(11) DEFAULT NULL COMMENT 'no of seconds',
  `country_code` varchar(45) NOT NULL COMMENT 'code of country',
  `operator_name` varchar(45) NOT NULL COMMENT 'name of operator',
  `api_group_name` varchar(100) DEFAULT NULL COMMENT 'name of api group',
  `iccid` varchar(100) DEFAULT NULL COMMENT 'iccid',
  `ban` varchar(100) DEFAULT NULL COMMENT 'ban',
  `unique_sim_identifier` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_iccid_ban_request` (`request_id`,`api_group_name`,`iccid`,`ban`,`unique_sim_identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
