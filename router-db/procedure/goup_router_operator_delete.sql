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

-- Dumping structure for procedure development_goup_router.goup_router_operator_delete
DROP PROCEDURE IF EXISTS `goup_router_operator_delete`;
DELIMITER //
CREATE  PROCEDURE `goup_router_operator_delete`(
IN in_interface_id int(16),
In in_id int(16)
)
    COMMENT 'This Procedure helps to delete operator'
BEGIN
/*
	--------------------------------------------------------------------------------------------------------------------------------------
	Description	:  	This Procedure helps to delete operator
	Created On	:	20/07/2018
	Created By	:	Nimisha Mittal
	--------------------------------------------------------------------------------------------------------------------------------------
	Inputs 		:	In in_id int(16)
	Output		:	This Procedure helps to delete operator
    
    Modified On	:	23/04/2019
	Modified By	:	Nimisha Mittal
	Modification:	delete from operator from router
	---------------------------------------------------------------------------------------------------------------------------------------
	*/
		-- temporary variable for localization concept
        DECLARE catchAribitrary BOOLEAN; 
		DECLARE in_lang_code INT ;
		DECLARE temp_default_lang_code INT;
		DECLARE temp_lang_code INT ;

		SET in_lang_code=null;
        SET temp_default_lang_code=(SELECT code FROM language WHERE is_default=1);
        SET temp_lang_code=(SELECT COALESCE(in_lang_code , temp_default_lang_code));
        
        if(in_id=(select operator from wso2_appilication where interface_id=in_interface_id and operator=in_id)) then 
			-- select 'Operator is linked with application.First delete that.' as msg;
            SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isWso2OperatorLinked",1,temp_lang_code));			
			SELECT @msg AS msg ;
		else
        
        if(select count(id) from operator_interface where operator_id=in_id) > 0 then
			delete from operator_interface where  operator_id=in_id ;
			 -- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isOperatorDeleted",1,temp_lang_code));			
			SELECT @msg AS msg ;
        else
			delete from operator where id=in_id;
			 -- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isOperatorDeleted",1,temp_lang_code));			
			SELECT @msg AS msg;
        end if;
        
    if(select count(id) from operator_interface where operator_id=in_id) = 0 then
			delete from operator where id=in_id;
			 -- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isOperatorDeleted",1,temp_lang_code));			
			SELECT @msg AS msg;
        else
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isOperatorDeleted",1,temp_lang_code));			
			SELECT @msg AS msg;
        end if;
	end if;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
