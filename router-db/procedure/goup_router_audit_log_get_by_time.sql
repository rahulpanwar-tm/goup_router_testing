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

-- Dumping structure for procedure development_goup_router.goup_router_audit_log_get_by_time
DROP PROCEDURE IF EXISTS `goup_router_audit_log_get_by_time`;
DELIMITER //
CREATE  PROCEDURE `goup_router_audit_log_get_by_time`(
	IN `in_start_time` int(16),
	IN `in_end_time` int(16),
	IN `in_limit` INT(16),
	IN `in_offset` INT(16)
)
    COMMENT 'This procedure is used to get logs in specific time interval'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:   This procedure is used to get logs in specific time interval
	Created On  :   10/10/2018
	Created By  :   Nimisha Mittal
	Modified On :   13/03/2019
    Changed description : Added country id and operator id
	----------------------------------------------------------------------------------------------------------------
	Inputs		:   IN `in_start_date` int(16),
					IN in_end_date int(16),
                    IN `in_limit` INT(16),
					IN `in_offset` INT(16)
    Output		:		
	-----------------------------------------------------------------------------------------------------------------
*/
	select 
    log_audit.id,
    log_audit.tracking_message_header,
    log_audit.input_parameters,
    log_audit.ip_address,
    log_audit.start_time,
    log_audit.url_accessed,
    log_audit.api_name,
    log_audit.api_type,
    log_audit.is_header,
    log_audit.message,
    log_audit.is_successful,
    log_audit.api_response,
    log_audit.target_api_name,
    log_audit.end_time,
    log_audit.logtype,
    log_audit.country as country,
    log_audit.operator as operator,
    log_audit.country_id as country_id,
    log_audit.operator_id as operator_id
    from log_audit 
	where start_time between in_start_time and in_end_time 
	group by tracking_message_header order by start_time desc
	 limit in_limit offset in_offset ;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
