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

-- Dumping structure for view goup_router_development.vw_wso2_appilication_details
DROP VIEW IF EXISTS `vw_wso2_appilication_details`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_wso2_appilication_details`;
 SELECT 
        `sim_map`.`id` AS `sim_map_id`,
        `sim_map`.`sim_identfier` AS `sim_identfier`,
        `sim_map`.`sim_identfier_bin` AS `sim_identfier_bin`,
        `sim_map`.`wso2_appilication_id` AS `sim_map_wso2_appilication_id`,
        `sim_map`.`sim_uid` AS `sim_map_sim_uid`,
        `wso2_appilication`.`id` AS `wso2_appilication_id`,
        `wso2_appilication`.`name` AS `wso2_appilication_name`,
        `wso2_appilication`.`operator` AS `wso2_appilication_operator_id`,
        `wso2_appilication`.`country` AS `wso2_appilication_country_id`,
        `wso2_appilication`.`host` AS `wso2_appilication_host`,
        `wso2_appilication`.`version` AS `wso2_appilication_version`,
        `wso2_appilication`.`port` AS `wso2_appilication_port`,
        `wso2_appilication`.`auth_app_key` AS `wso2_appilication_auth_app_key`,
        `sim_donor_identfiers`.`id` AS `sim_donor_identfiers_id`,
        `sim_donor_identfiers`.`name` AS `sim_donor_identfiers_name`,
        `sim_donor_identfiers`.`sim_identfier_bin` AS `sim_donor_identfiers_sim_identfier_bin`,
        `sim_donor_identfiers`.`sim_id` AS `sim_donor_identfiers_sim_id`,
        `sim_home_identifiers`.`id` AS `sim_home_identfiers_id`,
        `sim_home_identifiers`.`name` AS `sim_home_identfiers_name`,
        `sim_home_identifiers`.`sim_identfier_bin` AS `sim_home_identfiers_sim_identfier_bin`,
        `sim_home_identifiers`.`sim_id` AS `sim_home_identfiers_sim_id`,
        `country`.`name` AS `country_name`,
        `country`.`code` AS `country_code`,
        `operator`.`name` AS `operator_name`,
        `interfaces`.`id` AS `interfaces_id`,
        `interfaces`.`name` AS `interfaces_name`,
        `interfaces`.`mysql_host` AS `mysql_host`,
        `interfaces`.`mysql_port` AS `mysql_port`,
        `interfaces`.`mysql_username` AS `mysql_username`,
        `interfaces`.`mysql_password` AS `mysql_password`,
        `interfaces`.`mysql_password_salt` AS `mysql_password_salt`,
        `interfaces`.`version` AS `interfaces_version`,
        `interfaces`.`database_name` AS `database_name`
    FROM
        ((((((`sim_map`
        JOIN `wso2_appilication` ON ((`sim_map`.`wso2_appilication_id` = `wso2_appilication`.`id`)))
        LEFT JOIN `sim_home_identifiers` ON ((`sim_map`.`sim_identfier_bin` = `sim_home_identifiers`.`sim_identfier_bin`)))
        LEFT JOIN `sim_donor_identfiers` ON ((`sim_map`.`sim_identfier_bin` = `sim_donor_identfiers`.`sim_identfier_bin`)))
        JOIN `operator` ON ((`operator`.`id` = `wso2_appilication`.`operator`)))
        JOIN `country` ON ((`country`.`id` = `wso2_appilication`.`country`)))
        JOIN `interfaces` ON ((`interfaces`.`id` = `wso2_appilication`.`interface_id`)))
		
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
