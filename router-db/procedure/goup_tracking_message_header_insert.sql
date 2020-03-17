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

-- Dumping structure for procedure development_goup_router.goup_tracking_message_header_insert
DROP PROCEDURE IF EXISTS `goup_tracking_message_header_insert`;
DELIMITER //
CREATE  PROCEDURE `goup_tracking_message_header_insert`(
IN in_tracking_message_header varchar(256)
)
    COMMENT 'This procedure is for inserting tracking message header.'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:  This procedure is for inserting tracking message header.
    Created By  :   Nimisha Mittal
	Created On 	:   5/9/2018
	----------------------------------------------------------------------------------------------------------------
	Inputs	    :  IN in_tracking_message_header varchar(256)
    Output	   :	
    
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
        
	-- Check if tracking message header already exists
	if(select count(id) from tracking_message_header where tracking_message_header=in_tracking_message_header) then 
		-- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isTrackingMessageHeaderExists",1,temp_lang_code));			
		SELECT @msg AS msg,'0' as is_inserted;
    else
     insert into tracking_message_header(tracking_message_header) values (in_tracking_message_header);
    -- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isTrackingMessageHeaderInserted",1,temp_lang_code));			
		SELECT @msg AS msg,'1' as is_inserted;
     end if;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
