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

-- Dumping structure for table goup_router_development_ui.bulk_upload_sim_inventory
DROP TABLE IF EXISTS `bulk_upload_sim_inventory`;
CREATE TABLE IF NOT EXISTS `bulk_upload_sim_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremeted id.',
  `wso2_appilication_name` varchar(256) DEFAULT NULL COMMENT 'sim invenory belongs to which wso2 application',
  `sim_uid` text COMMENT 'sim''s unique id',
  `name` text COMMENT 'name are the unique parameters of sim like imsi,iccid ',
  `sim_id` text COMMENT 'sim id are the unique values of sim''s parameters like  imsi,iccid ',
  `type` text COMMENT 'type of parameters like home or donor',
  `file_id` int(16) DEFAULT NULL COMMENT 'id of file',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table stores details of temporary sim inventory details before inserting data into actual tables.';

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
