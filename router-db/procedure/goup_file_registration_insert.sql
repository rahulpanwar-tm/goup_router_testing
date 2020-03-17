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

-- Dumping structure for procedure development_goup_router.goup_file_registration_insert
DROP PROCEDURE IF EXISTS `goup_file_registration_insert`;
DELIMITER //
CREATE  PROCEDURE `goup_file_registration_insert`(
	IN in_file_name VARCHAR(256), 
	IN in_uploaded_by VARCHAR(256),
	IN in_file_path VARCHAR(256) ,
	IN in_description VARCHAR(256)
 )
    COMMENT 'This Procedure Helps to register  File of sim inventory'
BEGIN
  /*
  	-----------------------------------------------------------------------------------------------------------------------------------
  	Description	:	 This Procedure Helps to Register Bulk Upload File.
  	Created On	:	 18/09/2018
  	Created By	:	 Nimisha Mittal
    Modified On	:	1/2/2019
	Modification:	Same name file insert
	----------------------------------------------------------------------------------------------------------------
	Inputs		:    IN in_file_name VARCHAR(256), 
					 IN in_uploaded_by VARCHAR(256),
					 IN in_file_path VARCHAR(256) ,
					 IN in_description VARCHAR(256)
	Output		:	 Msg	

		-----------------------------------------------------------------------------------------------------------------
	*/
    DECLARE catchAribitrary BOOLEAN; 
	DECLARE in_lang_code INT ;
	DECLARE temp_default_lang_code INT;
	DECLARE temp_lang_code INT ;
	
	SET in_lang_code=null;
	SET temp_default_lang_code=(SELECT code FROM language WHERE is_default=1);
	SET temp_lang_code=(SELECT COALESCE(in_lang_code , temp_default_lang_code));

	  insert into file_registration
		(
		`file_name`,
		`uploaded_by`,
		`file_path`,
		`uploaded_on`,
		`is_status`,
		description,
		is_fault
		 )
	  values
		(
		  in_file_name ,
		  in_uploaded_by,
		  in_file_path,
		  unix_timestamp(),
		  0,
		  in_description,
		  0
		);
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isFileRegistered",1,temp_lang_code));			
		SELECT @msg AS msg, LAST_INSERT_ID() as file_id;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
