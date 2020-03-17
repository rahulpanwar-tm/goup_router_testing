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

-- Dumping structure for procedure development_goup_router.get_messages
DROP PROCEDURE IF EXISTS `get_messages`;
DELIMITER //
CREATE  PROCEDURE `get_messages`( IN in_lang_code INT,IN in_msg_code INT)
    COMMENT 'This Procedure helps to get messages .'
BEGIN
  /*
  	-----------------------------------------------------------------------------------------------------------------------------------
  	Description	:  This Procedure helps to get messages .
  	Created On	:	11/10/2018
  	Created By	:	Sarang Sapre 
	Change Description	:  handel null value .
  	Modified On	:	16/11/2018
  	Modified By	:	Nimisha Mittal
  	-----------------------------------------------------------------------------------------------------------------------------------

  */
	DECLARE temp_template INT;
	DECLARE temp_default_lang_code INT;
	DECLARE temp_lang_code INT ;
	-- Check if languadge code is null

	if (in_lang_code is null) then 
		SET temp_default_lang_code=(SELECT code FROM language WHERE is_default=1);
        
		SELECT  message FROM messages WHERE  language_id=temp_default_lang_code and code=in_msg_code;
	else
		SELECT  message FROM messages WHERE  language_id=in_lang_code and code=in_msg_code;
	end if;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
