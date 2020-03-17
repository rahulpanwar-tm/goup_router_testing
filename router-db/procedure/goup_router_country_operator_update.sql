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

-- Dumping structure for procedure development_goup_router.goup_router_country_operator_update
DROP PROCEDURE IF EXISTS `goup_router_country_operator_update`;
DELIMITER //
CREATE  PROCEDURE `goup_router_country_operator_update`(
	IN `in_identifier` varchar(256),
	IN `in_identifier_value` varchar(256),
	IN `in_country_code` varchar(256),
	IN `in_operator_code` varchar(256)


)
    COMMENT 'This procedure is used to update country and operator in profile switch condition.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to update country and operator in profile switch condition.
		Created On  :  03/08/2018
		Created By	:  Nimisha Mittal
		Modified On :  21/01/2019
		Changes description: changes in input parameter
		----------------------------------------------------------------------------------------------------------------
		Inputs		:  IN `in_identifier` varchar(256),
							IN `in_identifier_value` varchar(256),
							IN `in_country_code` varchar(256),
							IN `in_operator_code` varchar(256)
		Output		:	Msg	
		-----------------------------------------------------------------------------------------------------------------
	*/
     -- get country id
    set @temp_country_id=(select id from country where code=in_country_code);
    -- get operator id
    set @temp_operator_id=(select id from operator where name=in_operator_code);
    -- get wso2 appilication id
    set @temp_wso2_appilication_id=(select id from wso2_appilication where operator=@temp_operator_id and country=@temp_country_id);
   
	 set @temp_unique_identifier:=(select sim_identfier_bin from sim_map where sim_identfier = in_identifier_value);
    set @temp_home_identifiers:=(select sim_identfier_bin from sim_home_identifiers where sim_id=in_identifier_value);
	 set @temp_donor_identifiers:=(select sim_identfier_bin from sim_donor_identfiers where sim_id=in_identifier_value);

    set @temp_sim_id_bin:=(select coalesce(@temp_unique_identifier,@temp_home_identifiers,@temp_donor_identifiers)) ;

	-- get sim id
     set @temp_sim_id =(SELECT id FROM sim_map where sim_identfier_bin=@temp_sim_id); 
	
     -- move data into sim map history table
     insert into sim_map_history (sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid)
     select sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid from sim_map where id=@temp_sim_id;
     
      -- update sim map table
	   update sim_map
		set wso2_appilication_id=@temp_wso2_appilication_id
		where id=@temp_sim_id ;
		select 'Country and operator is updated.' as msg;

   /* -- Check if unique sim identifier is null or blank
	if(in_unique_sim_identifier is null or in_unique_sim_identifier='') then 
		-- get sim id
        set @temp_sim_id =(SELECT id FROM sim_map where sim_identfier_bin in (SELECT sim_identfier_bin FROM sim_donor_identfiers where sim_id=in_iccid or sim_id=in_ban)); 
		
        -- move data into sim map history table
        insert into sim_map_history (sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid)
        select sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid from sim_map where id=@temp_sim_id;
        
        -- update sim map table
		update sim_map
		set wso2_appilication_id=@temp_wso2_appilication_id
		where id=@temp_sim_id ;
		select 'Country and operator is updated.' as msg;
	else
		-- get sim id
		set @temp_sim_id =(SELECT id FROM sim_map where sim_identfier=in_unique_sim_identifier); 
		
        -- move data into sim map history table
		insert into sim_map_history (sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid)
        select sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid from sim_map where id=@temp_sim_id;
       
       -- update sim map table
		update sim_map
		set  wso2_appilication_id=@temp_wso2_appilication_id
		where id=@temp_sim_id ;
		select 'Country and operator is updated.' as msg;
	end if;
	*/
end//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
