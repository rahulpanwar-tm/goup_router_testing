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

-- Dumping structure for procedure development_goup_interface_thirdparty.goup_get_notification_url
DROP PROCEDURE IF EXISTS `goup_get_notification_url`;
DELIMITER //
CREATE  PROCEDURE `goup_get_notification_url`(
in request_id varchar(100),
in iccid varchar(100),
in ban varchar(100),
in unique_sim_identifier varchar(100),
in api_group_name varchar(100))
    COMMENT 'This procedure is used to get notification url on the basis of request id,iccid,ban,unique sim identifier,api group name'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:   This procedure is used to get notification url on the basis of request id,iccid,ban,unique sim identifier, api group name
		Created By	:	Dushyant Soni
        
        Modified By :   Saurabh kumar
        Description :	Added comments in code
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   in request_id varchar(100),
						in iccid varchar(100),
						in ban varchar(100),
						in unique_sim_identifier varchar(100),
						in api_group_name varchar(100)	
		Output		:	Returns details of notification url.
		-----------------------------------------------------------------------------------------------------------------
	*/

	set request_id=COALESCE(request_id,"");
    set iccid=COALESCE(iccid,"");
    set ban=COALESCE(ban,"");
    set unique_sim_identifier=COALESCE(unique_sim_identifier,"");
    
    -- selecting id on the basis of request id or icci id or ban or unique sim identifier and api group name
	set @id=(select id from goup_notification_url where
    (goup_notification_url.request_id=request_id or
    goup_notification_url.iccid=iccid or
    goup_notification_url.ban=ban or
    goup_notification_url.unique_sim_identifier=unique_sim_identifier)
    and goup_notification_url.api_group_name=api_group_name);
	
    if(@id is not null) then
        -- temporary table to store the details on the basis of id
		drop temporary table if exists test;
		create temporary table test
		select * from goup_notification_url where goup_notification_url.id=@id;

		select * from test;
    
    else
		-- temporary table to store Record not found message
		drop temporary table if exists test;
		create temporary table test
		select 'Record Not Found' as msg; 

		select * from test;
        
    end if;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
