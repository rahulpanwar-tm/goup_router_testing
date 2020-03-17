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

-- Dumping structure for function development_goup_interface_thirdparty.goup_message_by_parameter_and_langauge_code
DROP FUNCTION IF EXISTS `goup_message_by_parameter_and_langauge_code`;
DELIMITER //
CREATE  FUNCTION `goup_message_by_parameter_and_langauge_code`(
	`in_parameter` varchar(256),
	`in_parameter_value` TINYINT(4) ,
	`in_lang_code` INT 
) RETURNS int(11)
BEGIN
	set @code=null;
    set @msg=null;
	SELECT code,message,value into @code,@msg,@value FROM messages where parameter=in_parameter and value=in_parameter_value and language_id=in_lang_code limit 1;
RETURN 1;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
