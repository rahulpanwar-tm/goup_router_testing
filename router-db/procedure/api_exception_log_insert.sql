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

-- Dumping structure for procedure development_goup_router.api_exception_log_insert
DROP PROCEDURE IF EXISTS `api_exception_log_insert`;
DELIMITER //
CREATE  PROCEDURE `api_exception_log_insert`(
	IN `in_controller_url` text, 
	IN `in_input_parameter` text, 
	IN `in_output` text, 
	IN `in_exception` text,
	IN `in_user_id` varchar(256)
 )
    COMMENT 'Helps to create exception log'
BEGIN
/*
	-----------------------------------------------------------------------------------------------------------------------------------
	Description	:  This Procedure Helps to create exception log.
	Created On	:	08/02/2019
	Created By	:	Nimisha Mittal
	----------------------------------------------------------------------------------------------------------------
	Inputs		:   IN `in_controller_name` TEXT, 
					IN `in_input_parameters` TEXT,
					IN `in_ip_address` VARCHAR(64), 
					IN `in_url_accessed`TEXT, 
					IN `in_user_id` VARCHAR(256)
	Output	   :	insert in api log exception table
	-----------------------------------------------------------------------------------------------------------------
*/
	DECLARE catchAribitrary BOOLEAN; 
	DECLARE in_lang_code INT ;
	DECLARE temp_default_lang_code INT;
	DECLARE temp_lang_code INT ;
	
	SET in_lang_code=null;
	SET temp_default_lang_code=(SELECT code FROM language WHERE is_default=1);
	SET temp_lang_code=(SELECT COALESCE(in_lang_code , temp_default_lang_code));
        
	INSERT INTO api_log_exception
	(
	`controller_url`,
	`input_parameter`,
	`output`,
	`exception`,
	`user_id`,
	timeaccessed
	)
	VALUES
	(
	in_controller_url,
	in_input_parameter,
	in_output,
	in_exception,
	in_user_id,
	unix_timestamp()
	);
	
    -- Get Message From messages table
	SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isExceptionInserted",1,temp_lang_code));			
	SELECT @msg AS msg;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
