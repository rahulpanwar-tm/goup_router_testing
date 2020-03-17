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

-- Dumping structure for procedure development_goup_interface_thirdparty.goup_insert_notification_url
DROP PROCEDURE IF EXISTS `goup_insert_notification_url`;
DELIMITER //
CREATE  PROCEDURE `goup_insert_notification_url`( in api_group_name varchar(100),
in request_id varchar(100),
in iccid varchar(100),
in ban varchar(100),
in unique_sim_identifier varchar(100),
in returnUrl varchar(100),
in country_code varchar(45), 
in operator_name varchar(45))
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:   This procedure is used to insert into goup notification url table
		Created By	:	Dushyant Soni
        
        Modified By :	Saurabh kumar
        Modified On :	3 Sep 2018
        Description :	Added comments in code
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   in request_id varchar(100),
						in iccid varchar(100),
						in ban varchar(100),
						in unique_sim_identifier varchar(100),
						in returnUrl varchar(100),
						in country_code varchar(45), 
						in operator_name varchar(45)	
		Output		:	Returns message if successfully inserted
		-----------------------------------------------------------------------------------------------------------------
	*/

	set request_id=COALESCE(request_id,"");
    set iccid=COALESCE(iccid,"");
    set ban=COALESCE(ban,"");
    set unique_sim_identifier=COALESCE(unique_sim_identifier,"");
	
    -- insertion into table goup notification url
	insert into goup_notification_url(api_group_name,request_id,returnUrl,createdAT,
    country_code,operator_name,iccid,ban,unique_sim_identifier) 
	values(api_group_name,request_id,returnUrl,unix_timestamp(now()),
    country_code,operator_name,iccid,ban,unique_sim_identifier);
	
    -- returns message of successfull insertion
	select 'Notification inserted Successfully' as msg,LAST_INSERT_ID() as id;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
