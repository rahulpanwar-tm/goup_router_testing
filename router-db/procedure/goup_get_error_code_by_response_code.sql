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

-- Dumping structure for procedure development_goup_router.goup_get_error_code_by_response_code
DROP PROCEDURE IF EXISTS `goup_get_error_code_by_response_code`;
DELIMITER //
CREATE  PROCEDURE `goup_get_error_code_by_response_code`(
	IN `in_response_code` varchar(45)
)
    COMMENT 'This procedure is for getting error codes by response code.'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:  This procedure is for getting error codes by response code.
    Created By  :   Nimisha Mittal
	Created On 	:   5/9/2018
	----------------------------------------------------------------------------------------------------------------
	Inputs	    :  IN in_response_code varchar(45)
    Output	   :	
	-----------------------------------------------------------------------------------------------------------------
*/
	-- Check if error codes already exists
	if(select count(id) from error_codes where response_code=in_response_code) then 
     select * from error_codes where response_code=in_response_code;
   else
   	select * from error_codes where response_code=500; 
   end if;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
