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

-- Dumping structure for procedure development_goup_router.goup_router_get_mysql_config_by_tracking_message_header
DROP PROCEDURE IF EXISTS `goup_router_get_mysql_config_by_tracking_message_header`;
DELIMITER //
CREATE  PROCEDURE `goup_router_get_mysql_config_by_tracking_message_header`(
	IN `in_tracking_message_header` VARCHAR(256)
)
    COMMENT 'This procedure is used to get mysql config on the basis of tracking message header.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to get mysql config on the basis of tracking message header.
		Created On  :  28/08/2018
		Created By	:  Nimisha Mittal
		Modified On :   16/01/2019
		Changed description : use id of country and operator instead of code 
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   In in_tracking_message_header int(16)
		Output		:	
		-----------------------------------------------------------------------------------------------------------------
	*/
    -- get the logs of reuest id.
    drop temporary table if exists temp_log_audit;
    create temporary table temp_log_audit
	select * from log_audit where tracking_message_header=in_tracking_message_header and country is not null limit 1;
    -- get country id
   set @temp_country_id:=(select country_id from temp_log_audit);
    -- get operator id
   set @temp_operator_id:=(select operator_id from temp_log_audit);

    select 
		`name` ,
		`mysql_host`,
		`mysql_port`,
		`mysql_username`,
		`mysql_password`,
		`mysql_password_salt`,
		`version`,
         database_name
    from interfaces where id in (select interface_id from wso2_appilication where operator=@temp_operator_id and country=@temp_country_id)
    union 
	select 
		`name` ,
		`mysql_host`,
		`mysql_port`,
		`mysql_username`,
		`mysql_password`,
		`mysql_password_salt`,
		`version`,
         thirdparty_database_name as database_name
		from interfaces where id in (select interface_id from wso2_appilication where operator=@temp_operator_id and country=@temp_country_id);

end//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
