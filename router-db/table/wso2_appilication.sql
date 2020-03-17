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

-- Dumping structure for table goup_router_development.wso2_appilication
DROP TABLE IF EXISTS `wso2_appilication`;
CREATE TABLE `wso2_appilication` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `name` varchar(64) DEFAULT NULL COMMENT 'name of interface',
  `operator` int(11) DEFAULT NULL COMMENT 'interface belongs to which operator',
  `country` int(11) DEFAULT NULL COMMENT 'interface belongs to which country',
  `interface_id` int(16) DEFAULT NULL COMMENT 'interface belongs to which application',
  `host` varchar(45) DEFAULT NULL COMMENT 'host address of wso2 ',
  `port` varchar(45) DEFAULT NULL COMMENT 'port',
  `version` varchar(45) DEFAULT NULL COMMENT 'version of platform',
  `auth_app_key` varchar(64) DEFAULT NULL COMMENT 'auth application key',
  PRIMARY KEY (`id`),
  KEY `fk_country_idx` (`country`),
  KEY `fk_operator_idx` (`operator`),
  KEY `fk_interface_id201808211120_idx` (`interface_id`),
  CONSTRAINT `fk_country` FOREIGN KEY (`country`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_interface_id201808211120` FOREIGN KEY (`interface_id`) REFERENCES `interfaces` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_operator` FOREIGN KEY (`operator`) REFERENCES `operator` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='This table is used to store details of operator interface  on the basis of country and operator';


-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
