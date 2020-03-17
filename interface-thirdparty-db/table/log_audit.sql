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

-- Dumping structure for table comarch_testing_goup_interface_thirdparty.log_audit
DROP TABLE IF EXISTS `log_audit`;
CREATE TABLE IF NOT EXISTS `log_audit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tracking_message_header` varchar(256) DEFAULT NULL,
  `log_time` int(16) DEFAULT NULL,
  `log_type` varchar(64) DEFAULT NULL,
  `log_message` text,
  `log_data` text,
  `ip_address` varchar(64) DEFAULT NULL,
  `api_name` varchar(64) DEFAULT NULL,
  `api_method_type` varchar(64) DEFAULT NULL,
  `country_code` varchar(64) DEFAULT NULL,
  `operator_code` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
