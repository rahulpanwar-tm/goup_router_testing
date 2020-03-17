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

-- Dumping structure for procedure development_goup_interface_thirdparty.audit_log_get_by_tracking_message_header
DROP PROCEDURE IF EXISTS `audit_log_get_by_tracking_message_header`;
DELIMITER //
CREATE  PROCEDURE `audit_log_get_by_tracking_message_header`(
	IN `in_tracking_message_header` varchar(256)
)
    COMMENT 'This procedure is used to get logs by tracking message header'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:  This procedure is used to get logs by  tracking message header
    Created On  :   07/02/2019
    Created By  :   Nimisha Mittal 
    Update On   :   26/03/2019
    Changes description : Return message data not available
	----------------------------------------------------------------------------------------------------------------
	Inputs	:   	IN in_tracking_message_header varchar(256)
    Output	:		
	-----------------------------------------------------------------------------------------------------------------
*/
	if(SELECT count(*) from log_audit where tracking_message_header=in_tracking_message_header) then
	SELECT * from log_audit where tracking_message_header=in_tracking_message_header order by log_time asc;
    else
    select 'Data not available' as msg;
    end if;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
