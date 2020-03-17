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

-- Dumping structure for procedure development_goup_router.goup_router_wso2_appilication_insert
DROP PROCEDURE IF EXISTS `goup_router_wso2_appilication_insert`;
DELIMITER //
CREATE  PROCEDURE `goup_router_wso2_appilication_insert`(
In in_name varchar(64) ,
In in_operator int(11) ,
In in_country int(11) ,
In in_interface_id int(16) ,
In in_host varchar(45) ,
In in_port varchar(45) ,
In in_version varchar(45),
IN in_auth_app_key varchar(64)
)
    COMMENT 'This procedure is used to insert wso2 appilication.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to insert wso2 appilication.
		Created On  :  27/08/2018
		Created By	:  Nimisha Mittal
		Modified On :  26/09/2018
		Changed Description: Check for wso2 application already exists or not
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   In in_name varchar(64) ,
						In in_operator int(11) ,
						In in_country int(11) ,
						In in_interface_id int(16) ,
						In in_host varchar(45) ,
						In in_port varchar(45) ,
						In in_version varchar(45),
						IN in_auth_app_key varchar(64)
		Output		:	Msg	
        
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
	-- get wso2 applications on the basis of country and operator
    drop temporary table if exists temp_wso2_appilication;
    create temporary table temp_wso2_appilication
    select * from wso2_appilication where operator=in_operator and country=in_country ;
    
   -- get wso2 applications on the basis of name and host address of wso2 application.
    drop temporary table if exists temp_wso2_appilication_name;
    create temporary table temp_wso2_appilication_name
    select * from temp_wso2_appilication where name=in_name or host=in_host ;
    
    -- Check if wso2 application already exists.
    if (select count(id) from temp_wso2_appilication_name)=0 then 
		insert into wso2_appilication
		(
		name,
		operator,
		country,
		interface_id,
		host,
		port,
		version,
		auth_app_key
		)
		VALUES
		(
		in_name  ,
		in_operator  ,
		in_country ,
		in_interface_id ,
		in_host  ,
		in_port  ,
		in_version ,
		in_auth_app_key
		);
        -- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isWso2AppilicationInserted",1,temp_lang_code));			
		SELECT @msg AS msg;
	else
		-- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isWso2AppilicationExists",1,temp_lang_code));			
		SELECT @msg AS msg;
    end if;
end//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
