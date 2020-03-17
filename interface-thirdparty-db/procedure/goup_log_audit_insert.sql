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

-- Dumping structure for procedure development_goup_interface_thirdparty.goup_log_audit_insert
DROP PROCEDURE IF EXISTS `goup_log_audit_insert`;
DELIMITER //
CREATE  PROCEDURE `goup_log_audit_insert`(
	IN in_tracking_message_header varchar(256),
	IN in_log_time int(16),
	IN in_log_type  varchar(64),
	IN in_log_message text,
	IN in_log_data text,
	IN in_ip_address varchar(64),
	IN in_api_name varchar(64),
	IN in_api_method_type varchar(64),
	IN in_country_code varchar(64),
	IN in_operator_code varchar(64)
)
    COMMENT 'This Procedure helps to insert the logs audits.'
BEGIN
 /*
	--------------------------------------------------------------------------------------------------------------------------------------
	Description	:  This Procedure helps to insert the logs audits.
	Created On	:	07/02/2019
	Created By	:	Nimisha Mittal 
	--------------------------------------------------------------------------------------------------------------------------------------
	Inputs 		:	IN in_tracking_message_header varchar(256),
					IN in_log_time int(16),
					IN in_log_type  varchar(64),
					IN in_log_message text,
					IN in_log_data text,
					IN in_ip_address varchar(64),
					IN in_api_name varchar(64),
					IN in_api_method_type varchar(64),
					IN in_country_code varchar(64),
					IN in_operator_code varchar(64)
	Output		:	This Procedure helps to insert the logs audits
	---------------------------------------------------------------------------------------------------------------------------------------
*/
	INSERT INTO `log_audit`
	(
	`tracking_message_header`,
	`log_time`,
	`log_type`,
	`log_message`,
	`log_data`,
	`ip_address`,
	`api_name`,
	`api_method_type`,
	`country_code`,
	`operator_code`)
	VALUES
	(
	in_tracking_message_header,
	in_log_time,
	in_log_type,
	in_log_message,
	in_log_data,
	in_ip_address,
	in_api_name,
	in_api_method_type,
	in_country_code,
	in_operator_code
	);
	select 'Log audit is inserted' as msg;
end//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
