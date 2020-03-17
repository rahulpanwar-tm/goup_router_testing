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

-- Dumping structure for table goup_router_development.sim_map_history
DROP TABLE IF EXISTS `sim_map_history`;
CREATE TABLE `sim_map_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `sim_identfier` varchar(20) DEFAULT NULL COMMENT 'standard unique identifier',
  `sim_identfier_bin` binary(16) DEFAULT NULL COMMENT 'binary format of standard unique identifier',
  `wso2_appilication_id` int(16) DEFAULT NULL,
  `sim_uid` varchar(64) DEFAULT NULL COMMENT 'used to store unique sim id ',
  `file_id` int(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wso2_appilication_id_201808211130_idx` (`wso2_appilication_id`),
  CONSTRAINT `fk_wso2_appilication_id_201808211130` FOREIGN KEY (`wso2_appilication_id`) REFERENCES `wso2_appilication` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table is used to create history of unique identifier .';

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
