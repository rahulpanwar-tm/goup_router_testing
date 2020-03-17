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

-- Dumping structure for procedure development_goup_router.goup_router_get_bulk_sim_inventory
DROP PROCEDURE IF EXISTS `goup_router_get_bulk_sim_inventory`;
DELIMITER //
CREATE  PROCEDURE `goup_router_get_bulk_sim_inventory`(In in_file_id int(16) , In in_is_faulty tinyint(4))
    COMMENT 'This Procedure Helps to get sim inventory of bulk upload.'
BEGIN
   /*
    	-----------------------------------------------------------------------------------------------------------------------------------
    	Description	:  This Procedure Helps to get sim inventory of bulk upload .
    	Created On	: 15/03/2019
    	Created By	: Nimisha Mittal
    	-----------------------------------------------------------------------------------------------------------------------------------
    */
	SELECT  wso2_appilication_name as id,sim_uid,bulk_upload_sim_inventory_errors.name,sim_id,type,remark ,wso2_appilication.name as wso2_appilication_name
    FROM bulk_upload_sim_inventory_errors 
    left join wso2_appilication on wso2_appilication.id=wso2_appilication_name WHERE file_id=in_file_id AND is_faulty=in_is_faulty ;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
