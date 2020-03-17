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

-- Dumping structure for table goup_router_development.log_audit
DROP TABLE IF EXISTS `log_audit`;
CREATE TABLE `log_audit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto-Incremented ID',
  `tracking_message_header` varchar(256) DEFAULT NULL COMMENT 'request id',
  `input_parameters` text COMMENT 'Input in the api',
  `ip_address` varchar(45) DEFAULT NULL COMMENT 'Ip address of the device',
  `start_time` int(16) DEFAULT NULL COMMENT 'Time at which api was called',
  `url_accessed` varchar(256) DEFAULT NULL COMMENT 'Url api accesed',
  `api_name` varchar(256) DEFAULT NULL COMMENT 'name of api',
  `api_type` varchar(64) DEFAULT NULL COMMENT 'type of api called',
  `is_header` text COMMENT '1 if parameter is header else 0',
  `message` text COMMENT 'message ',
  `is_successful` tinyint(16) DEFAULT NULL COMMENT 'call is successfull or not',
  `api_response` text COMMENT 'response of api',
  `target_api_name` varchar(256) CHARACTER SET latin7 COLLATE latin7_estonian_cs DEFAULT NULL COMMENT 'target api name',
  `end_time` int(16) DEFAULT NULL COMMENT 'time at which api call finished',
  `logtype` varchar(45) DEFAULT NULL COMMENT 'error/exception',
  `country` varchar(45) DEFAULT NULL,
  `operator` varchar(45) DEFAULT NULL,
  `country_id` int(16) DEFAULT NULL,
  `operator_id` int(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='This table will contain the audit_log of the api''s called and views accessed';

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
