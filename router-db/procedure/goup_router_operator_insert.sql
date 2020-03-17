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

-- Dumping structure for procedure development_goup_router.goup_router_operator_insert
DROP PROCEDURE IF EXISTS `goup_router_operator_insert`;
DELIMITER //
CREATE  PROCEDURE `goup_router_operator_insert`(
IN in_interface_id int(16),
In in_name varchar(64),
In in_code varchar(64)
)
    COMMENT 'This Procedure helps to insert operator'
BEGIN
	/*
		--------------------------------------------------------------------------------------------------------------------------------------
		Description	:   This Procedure helps to insert operator
		Created On	:	20/07/2018
		Created By	:	Nimisha Mittal
		--------------------------------------------------------------------------------------------------------------------------------------
		Inputs 		:	In in_name varchar(64),
						In in_code varchar(64)
		Output		:	This Procedure helps to insert operator
        
		Modified On	:	29/10/2018
		Modified By	:	Nimisha Mittal
		Modification:	operator added in both interface and router 
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
        
	-- Check if operator name already exists
	if(select count(id) from operator where name=in_name) then 
		 -- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isOperatorExists",1,temp_lang_code));			
		SELECT @msg AS msg;
	else
		INSERT INTO operator
		(
		name,
		code
		)
		VALUES
		(
		in_name,
		in_code
		);
        set @temp_operator_id:=(last_insert_id());
        
        insert into operator_interface(operator_id,interface_id)
        values(@temp_operator_id,in_interface_id);
        
        -- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("OperatorInserted",1,temp_lang_code));			
		SELECT @msg AS msg,@temp_operator_id as operator_id;
	end if;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
