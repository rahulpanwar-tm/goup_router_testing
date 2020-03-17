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

-- Dumping structure for procedure development_goup_router.goup_interface_insert
DROP PROCEDURE IF EXISTS `goup_interface_insert`;
DELIMITER //
CREATE  PROCEDURE `goup_interface_insert`(
	IN `in_name` varchar(256) ,
	IN `in_mysql_host` varchar(64) ,
	IN `in_mysql_port` varchar(64) ,
	IN `in_mysql_username` varchar(64) ,
	IN `in_mysql_password` varchar(64) ,
	IN `in_version` varchar(45) ,
	IN `in_database_name` varchar(256),
    In in_thirdparty_database_name varchar(256)
)
    COMMENT 'This procedure is for inserting interfaces with mysql configs.'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:  This procedure is for inserting interfaces with mysql configs.
    Created By  :   Nimisha Mittal
	Created On 	:   5/9/2018
    Modified On :   13/03/2019
    Changed Description: insert third party name
	----------------------------------------------------------------------------------------------------------------
	Inputs	    :   IN in_name varchar(256) ,
					IN in_mysql_host varchar(64) ,
					IN in_mysql_port varchar(64) ,
					IN in_mysql_username varchar(64) ,
					IN in_mysql_password varchar(64) ,
					IN in_mysql_password_salt varchar(64) ,
					IN in_version varchar(45) ,
					IN in_database_name  varchar(256),
					In in_thirdparty_database_name varchar(256)
    Output	   :	Msg
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
        
	-- Check if interface already exists.
	if(select count(id) from interfaces where name=in_name) then
		  -- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isInterfaceAlreadyExists",1,temp_lang_code));			
		SELECT @msg AS msg;
	else	
			insert into interfaces
		(
	   `name`,
		mysql_host  ,
		mysql_port  ,
		mysql_username  ,
		mysql_password  ,
		version  ,
		database_name ,
        thirdparty_database_name
		) 
		values
		(
		in_name,
		in_mysql_host  ,
		in_mysql_port  ,
		in_mysql_username  ,
		in_mysql_password  ,
		in_version  ,
		in_database_name ,
        in_thirdparty_database_name
		);
          -- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isInterfaceInserted",1,temp_lang_code));			
		SELECT @msg AS msg;
	end if;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
