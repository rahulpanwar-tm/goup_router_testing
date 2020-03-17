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

-- Dumping structure for procedure development_goup_router.goup_router_file_detail_get_all
DROP PROCEDURE IF EXISTS `goup_router_file_detail_get_all`;
DELIMITER //
CREATE  PROCEDURE `goup_router_file_detail_get_all`(
IN `in_start_date` bigint,
IN `in_end_date` bigint
)
    COMMENT 'This procedure helps to get all details of uploaded files on the basis of given start and end date.'
BEGIN
 /*
  	-----------------------------------------------------------------------------------------------------------------------------------
  	Description	:  This procedure helps to get all details of uploaded files on the basis of given start and end date.
  	Created On	:	19/09/2018
  	Created By	:  Nimisha Mittal
    
    Modified On	:	24/05/2019
    Modification:	order by data
  	-----------------------------------------------------------------------------------------------------------------------------------
  */
	SELECT 
		 file_registration.id, 
       file_registration.file_name, 
       file_registration.file_path, 
       file_registration.uploaded_on, 
       file_registration.uploaded_by, 
       file_registration.description, 
       file_registration.is_fault,
       `status`.message AS Status
	FROM file_registration
	INNER JOIN `status` ON file_registration.is_status=`status`.`status`
    WHERE file_registration.uploaded_on between in_start_date/1000 and in_end_date/1000
    order by file_registration.uploaded_on desc;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
