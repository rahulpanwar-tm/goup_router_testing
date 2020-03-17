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

-- Dumping structure for procedure development_goup_router.goup_router_utility_string_split
DROP PROCEDURE IF EXISTS `goup_router_utility_string_split`;
DELIMITER //
CREATE  PROCEDURE `goup_router_utility_string_split`(IN in_string TEXT)
    COMMENT 'A  Utility procedure. It helps to convert a C.S.V. into a single column table '
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:   A  Utility procedure. It helps to convert a C.S.V. into a single column table
		Created On	:	November 11,2016
		Created By	:	Shantanu Bansal
        Modify By 	:   Nimisha Mittal
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   Comma Sperated String
		Output		:	Each Comma Sperated value in the cell in a single column
		-----------------------------------------------------------------------------------------------------------------
	*/

	-- Temporary table to hold splited row value of string

   drop temporary table if exists temp_convert;
	create temporary table temp_convert(split_data TEXT );
	-- dynamic query to break comma separated string as rows and insert into column
   
	   set @sql = CONCAT_WS("","
	insert into temp_convert (split_data) values ('",
	replace(in_string ,
	"|#@|",
	"'),('"),"'
											   );" );

prepare stmt1 from @sql;
execute stmt1;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
