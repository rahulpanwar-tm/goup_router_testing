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

-- Dumping structure for procedure development_goup_router.goup_audit_log_insert
DROP PROCEDURE IF EXISTS `goup_audit_log_insert`;
DELIMITER //
CREATE  PROCEDURE `goup_audit_log_insert`(
IN in_tracking_message_header varchar(256) ,
IN in_input_parameters text ,
IN in_ip_address varchar(45) ,
IN in_start_time int(16) ,
IN in_url_accessed varchar(256) ,
IN in_api_name varchar(256) ,
IN in_api_type varchar(64) ,
IN in_is_header text ,
IN in_message text ,
IN in_is_successful tinyint(16) ,
IN in_target_api_name varchar(256) ,
IN in_logtype varchar(45),
IN in_api_response text,
IN in_end_time int(16),
In in_country varchar(45),
In in_operator varchar(45),
In in_country_id int(16) ,
In in_operator_id int(16)
)
    COMMENT 'This procedure is for creating Logs'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:  This procedure is for creating Logs
    Created By  :   Nimisha Mittal
	Created On :   6/09/2018
    Modified By :   Nimisha Mittal
    Modified On :   13/03/2019
    Changed description : Added country id and operator id
	----------------------------------------------------------------------------------------------------------------
	Inputs	    :   IN in_tracking_message_header varchar(256) ,
					IN in_input_parameters text ,
					IN in_ip_address varchar(45) ,
					IN in_start_time datetime ,
					IN in_url_accessed varchar(256) ,
					IN in_api_name varchar(256) ,
					IN in_api_type varchar(64) ,
					IN in_is_header text ,
					IN in_message text ,
					IN in_is_successful tinyint(16) ,
					IN in_target_api_name varchar(256) ,
					IN in_logtype varchar(45),
					IN in_api_response text,
					IN in_end_time datetime,
					In in_country varchar(45),
					In in_operator varchar(45),
                    In in_country_id int(16) ,
					In in_operator_id int(16)
    Output	   :	Update in audit_log table
	-----------------------------------------------------------------------------------------------------------------
*/		DECLARE catchAribitrary BOOLEAN; 
		DECLARE in_lang_code INT ;
		DECLARE temp_default_lang_code INT;
		DECLARE temp_lang_code INT ;
        
		SET in_lang_code=null;
        SET temp_default_lang_code=(SELECT code FROM language WHERE is_default=1);
        SET temp_lang_code=(SELECT COALESCE(in_lang_code , temp_default_lang_code));
	
		INSERT INTO log_audit (
						tracking_message_header,
						input_parameters  ,
						ip_address  ,
						start_time  ,
						url_accessed  ,
						api_name ,
						api_type  ,
						is_header  ,
						message  ,
						is_successful  ,
						target_api_name  ,
						logtype ,
						api_response ,
						end_time ,
                        country,
                        operator,
                        country_id,
                        operator_id
                        )
			VALUES (
					in_tracking_message_header,
					in_input_parameters  ,
					in_ip_address  ,
					in_start_time  ,
					in_url_accessed  ,
					in_api_name ,
					in_api_type  ,
					in_is_header  ,
					in_message  ,
					in_is_successful  ,
					in_target_api_name  ,
					in_logtype ,
					in_api_response ,
					in_end_time ,
                    in_country,
                    in_operator,
                    in_country_id,
                    in_operator_id
					);
		-- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isLogInserted",1,temp_lang_code));			
		SELECT @msg AS msg;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
