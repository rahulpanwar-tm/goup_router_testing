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

-- Dumping structure for procedure development_goup_router.api_exception_log_count
DROP PROCEDURE IF EXISTS `api_exception_log_count`;
DELIMITER //
CREATE  PROCEDURE `api_exception_log_count`(
IN `in_from_date` int(16),
IN `in_end_date` int(16)
)
    COMMENT ' This Procedure helps to get the count of exception logs'
BEGIN
 /*
	--------------------------------------------------------------------------------------------------------------------------------------
	Description	:  This Procedure helps to get the count of exception logs
	Created On	:	08/02/2019
	Created By	:	Nimisha Mittal
	--------------------------------------------------------------------------------------------------------------------------------------
	Inputs :	IN `in_from_date` int(16),
				IN `in_end_date` int(16)
	Output	:	This Procedure helps to get the count of exception logs
	---------------------------------------------------------------------------------------------------------------------------------------
*/
	select count(id) as log_count from api_log_exception where timeaccessed between in_from_date and in_end_date;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
