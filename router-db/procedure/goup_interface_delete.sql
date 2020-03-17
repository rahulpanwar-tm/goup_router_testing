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

-- Dumping structure for procedure development_goup_router.goup_interface_delete
DROP PROCEDURE IF EXISTS `goup_interface_delete`;
DELIMITER //
CREATE  PROCEDURE `goup_interface_delete`(
	IN `in_id` int(16)

)
    COMMENT 'This procedure is for deleting interfaces with mysql configs.'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:  This procedure is for deleting interfaces with mysql configs.
    Created By  :   Nimisha Mittal
	Created On 	:   5/9/2018
	Modified On :   26/09/2018
	Changed description : delete all the data releated to interface
	----------------------------------------------------------------------------------------------------------------
	 Inputs	    :   IN in_id int(16)
     Output	   :	Msg
     
	Modified On	:	24 Oct 2018
	Modified By	:	Saurabh kumar
	Modification:	Added logic of localization
	-----------------------------------------------------------------------------------------------------------------
*/
		-- temporary variable for localization concept
		DECLARE catchAribitrary BOOLEAN; 
		DECLARE in_lang_code INT ;
		DECLARE temp_default_lang_code INT;
		DECLARE temp_lang_code INT ;

        
		SET in_lang_code=null;
        SET temp_default_lang_code=(SELECT code FROM language WHERE is_default=1);
        SET temp_lang_code=(SELECT COALESCE(in_lang_code , temp_default_lang_code));
	-- get sim identifieres of all interface
	drop temporary table if exists temp_sim_indentifier_bin;
	create temporary table temp_sim_indentifier_bin
	select sim_identfier_bin,wso2_appilication_id from sim_map where wso2_appilication_id in (select id from wso2_appilication where interface_id=in_id);

	-- delete data mapping of wso2 application from sim home identifiers
	delete from sim_home_identifiers where sim_identfier_bin in (select sim_identfier_bin from temp_sim_indentifier_bin);

	-- delete data mapping of wso2 application from sim donor identifiers
	delete from sim_donor_identfiers where sim_identfier_bin in (select sim_identfier_bin from temp_sim_indentifier_bin);

	-- delete data mapping of wso2 application from sim map
	delete from sim_map where wso2_appilication_id in (select id from wso2_appilication where interface_id=in_id);

-- delete data mapping of wso2 application from sim map hsitory
	delete from sim_map_history where wso2_appilication_id in (select wso2_appilication_id from temp_sim_indentifier_bin);

	--  delete data from wso2 application
	delete from wso2_appilication where  interface_id=in_id;

	-- delete interface
	delete from  interfaces where id=in_id;
	
    -- Get Message From messages table
	SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isInterfaceDeleted",1,temp_lang_code));			
	SELECT @msg AS msg;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
