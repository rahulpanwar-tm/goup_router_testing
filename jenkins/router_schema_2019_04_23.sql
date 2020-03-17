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


-- Dumping database structure for goup_router
DROP DATABASE IF EXISTS goup_router;
CREATE DATABASE IF NOT EXISTS goup_router /*!40100 DEFAULT CHARACTER SET utf8 */;
USE goup_router;

-- Dumping structure for procedure goup_router.api_audit_log_count
DROP PROCEDURE IF EXISTS `api_audit_log_count`;
DELIMITER //
CREATE  PROCEDURE `api_audit_log_count`(
	IN `in_from_date` int(16), 
	IN `in_end_date` int(16)
)
BEGIN
 /*
	--------------------------------------------------------------------------------------------------------------------------------------
	Description	:  This Procedure helps to count the number of audit logs
	Created On	:  08/02/2019
	Created By	:  Nimisha Mittal
	--------------------------------------------------------------------------------------------------------------------------------------
	Inputs :		IN `in_from_date` int(16), 
					IN `in_end_date` int(16)
	Output	:		This Procedure helps to count the number of audit logs
	---------------------------------------------------------------------------------------------------------------------------------------
*/
	select  count(id) as log_count from api_log_audit where timeaccessed between in_from_date and in_end_date;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.api_audit_log_get_all
DROP PROCEDURE IF EXISTS `api_audit_log_get_all`;
DELIMITER //
CREATE  PROCEDURE `api_audit_log_get_all`(
IN `in_from_date` int(16),
IN `in_end_date` int(16)
)
BEGIN
	/*
	--------------------------------------------------------------------------------------------------------------------------------------
	Description	:  This Procedure helps to get the  audit logs with limits
	Created On	:	08/02/2019
	Created By	:	Nimisha Mittal
	--------------------------------------------------------------------------------------------------------------------------------------
	Inputs :		IN `in_from_date` int(16), 
					IN `in_end_date` int(16)
	Output	:	    This Procedure helps to get the  audit logs
	---------------------------------------------------------------------------------------------------------------------------------------
*/
	select * from api_log_audit where timeaccessed between in_from_date and in_end_date   order by timeaccessed desc;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.api_audit_log_get_all_limit
DROP PROCEDURE IF EXISTS `api_audit_log_get_all_limit`;
DELIMITER //
CREATE  PROCEDURE `api_audit_log_get_all_limit`(
	IN `in_from_date` int(16), 
	IN `in_end_date` int(16), 
	IN `in_limit` int(16), 
	IN `in_offset` int(16)
)
BEGIN
 /*
	--------------------------------------------------------------------------------------------------------------------------------------
	Description	:  This Procedure helps to get the  audit logs with limits
	Created On	:	08/02/2019
	Created By	:	Nimisha Mittal
	--------------------------------------------------------------------------------------------------------------------------------------
	Inputs :		IN `in_from_date` int(16), 
					IN `in_end_date` int(16), 
					IN `in_limit` int(16), 
					IN `in_offset` int(16)
	Output	:	 This Procedure helps to get the  audit logs
	---------------------------------------------------------------------------------------------------------------------------------------
*/
	select * from api_log_audit where timeaccessed between in_from_date and in_end_date   order by timeaccessed desc limit in_limit offset in_offset;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.api_audit_log_insert
DROP PROCEDURE IF EXISTS `api_audit_log_insert`;
DELIMITER //
CREATE  PROCEDURE `api_audit_log_insert`(
	IN `in_controller_name` TEXT, 
	IN `in_input_parameters` TEXT,
	IN `in_ip_address` VARCHAR(64), 
	IN `in_url_accessed`TEXT, 
	IN `in_user_id` VARCHAR(256),
    In in_log_type varchar(64)
)
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:  This procedure is for creating Logs
	Created On	:	08/02/2019
	Created By	:	Nimisha Mittal
	----------------------------------------------------------------------------------------------------------------
	Inputs		:   IN `in_controller_name` TEXT, 
					IN `in_input_parameters` TEXT,
					IN `in_ip_address` VARCHAR(64), 
					IN `in_url_accessed`TEXT, 
					IN `in_user_id` VARCHAR(256),
					In in_log_type varchar(64)
	Output	   :	insert in api log audit table
	-----------------------------------------------------------------------------------------------------------------
*/
		DECLARE catchAribitrary BOOLEAN; 
		DECLARE in_lang_code INT ;
		DECLARE temp_default_lang_code INT;
		DECLARE temp_lang_code INT ;
        
		SET in_lang_code=null;
        SET temp_default_lang_code=(SELECT code FROM language WHERE is_default=1);
        SET temp_lang_code=(SELECT COALESCE(in_lang_code , temp_default_lang_code));
	
		INSERT INTO api_log_audit (
		controller_name ,
		input_parameters , 
		ip_address , 
		url_accessed , 
		user_id ,
		log_type ,
		timeaccessed 
		) 
		VALUES 
		(
			in_controller_name,
			in_input_parameters,
			in_ip_address,
			in_url_accessed,
			in_user_id,
			in_log_type,
			unix_timestamp()
		);
		-- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isLogInserted",1,temp_lang_code));			
		SELECT @msg AS msg;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.api_exception_log_count
DROP PROCEDURE IF EXISTS `api_exception_log_count`;
DELIMITER //
CREATE  PROCEDURE `api_exception_log_count`(
IN `in_from_date` int(16),
IN `in_end_date` int(16)
)
    COMMENT ' This Procedure helps to get the count of exception logs'
BEGIN
 /*
	--------------------------------------------------------------------------------------------------------------------------------------
	Description	:  This Procedure helps to get the count of exception logs
	Created On	:	08/02/2019
	Created By	:	Nimisha Mittal
	--------------------------------------------------------------------------------------------------------------------------------------
	Inputs :	IN `in_from_date` int(16),
				IN `in_end_date` int(16)
	Output	:	This Procedure helps to get the count of exception logs
	---------------------------------------------------------------------------------------------------------------------------------------
*/
	select count(id) as log_count from api_log_exception where timeaccessed between in_from_date and in_end_date;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.api_exception_log_get_all_limit
DROP PROCEDURE IF EXISTS `api_exception_log_get_all_limit`;
DELIMITER //
CREATE  PROCEDURE `api_exception_log_get_all_limit`(
	IN `in_from_date` int(16),
	IN `in_end_date` int(16),
	IN `in_limit` int(16),
	IN `in_offset` int(16)
)
    COMMENT ' This Procedure helps to get the exception logs'
BEGIN
 /*
	--------------------------------------------------------------------------------------------------------------------------------------
	Description	:  This Procedure helps to get the exception logs
	Created On	:	08/02/2019
	Created By	:	Nimisha Mittal
	--------------------------------------------------------------------------------------------------------------------------------------
	Inputs :	IN `in_from_date` int(16),
				IN `in_end_date` int(16),
                IN `in_limit` int(16),
				IN `in_offset` int(16),
	Output	:	This Procedure helps to get the exception logs
	---------------------------------------------------------------------------------------------------------------------------------------
*/
	select * from api_log_exception where timeaccessed between in_from_date and in_end_date  order by timeaccessed desc limit in_limit offset in_offset
 ;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.api_exception_log_insert
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

-- Dumping structure for table goup_router.api_log_audit
DROP TABLE IF EXISTS `api_log_audit`;
CREATE TABLE IF NOT EXISTS `api_log_audit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto-Incremented ID',
  `controller_name` text,
  `input_parameters` text,
  `ip_address` varchar(64) DEFAULT NULL,
  `url_accessed` text,
  `user_id` varchar(256) DEFAULT NULL,
  `log_type` varchar(64) DEFAULT NULL,
  `timeaccessed` int(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This table will contain the audit_log of the api''s called and views accessed';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.api_log_exception
DROP TABLE IF EXISTS `api_log_exception`;
CREATE TABLE IF NOT EXISTS `api_log_exception` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `controller_url` text NOT NULL,
  `input_parameter` text,
  `output` text,
  `exception` text,
  `user_id` varchar(256) DEFAULT NULL,
  `timeaccessed` int(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Contains exception logs';

-- Data exporting was unselected.
-- Dumping structure for procedure goup_router.audit_log_get_by_tracking_message_header
DROP PROCEDURE IF EXISTS `audit_log_get_by_tracking_message_header`;
DELIMITER //
CREATE  PROCEDURE `audit_log_get_by_tracking_message_header`(
	IN `in_tracking_message_header` varchar(256)
)
    COMMENT 'This procedure is used to get logs by tracking message header'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:  This procedure is used to get logs by  tracking message header
    Created On  :   04/08/2018
    Created By  :   Nimisha Mittal
	Modified On :   13/03/2019
    Changed description : Added country id and operator id
	----------------------------------------------------------------------------------------------------------------
	Inputs	:   	IN in_request_id varchar(256)
    Output	:		
	-----------------------------------------------------------------------------------------------------------------
*/
	SELECT log_audit.id,
    log_audit.tracking_message_header,
    log_audit.input_parameters,
    log_audit.ip_address,
    log_audit.start_time,
    log_audit.url_accessed,
    log_audit.api_name,
    log_audit.api_type,
    log_audit.is_header,
    log_audit.message,
    log_audit.is_successful,
    log_audit.api_response,
    log_audit.target_api_name,
    log_audit.end_time,
    log_audit.logtype,
    log_audit.country as country,
    log_audit.operator as operator,
    log_audit.country_id as country_id,
    log_audit.operator_id as operator_id
    from log_audit 
    where tracking_message_header=in_tracking_message_header;
END//
DELIMITER ;

-- Dumping structure for table goup_router.bulk_upload_sim_inventory
DROP TABLE IF EXISTS `bulk_upload_sim_inventory`;
CREATE TABLE IF NOT EXISTS `bulk_upload_sim_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremeted id.',
  `wso2_appilication_name` varchar(256) DEFAULT NULL COMMENT 'sim invenory belongs to which wso2 application',
  `sim_uid` text COMMENT 'sim''s unique id',
  `name` text COMMENT 'name are the unique parameters of sim like imsi,iccid ',
  `sim_id` text COMMENT 'sim id are the unique values of sim''s parameters like  imsi,iccid ',
  `type` text COMMENT 'type of parameters like home or donor',
  `file_id` int(16) DEFAULT NULL COMMENT 'id of file',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This table stores details of temporary sim inventory details before inserting data into actual tables.';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.bulk_upload_sim_inventory_errors
DROP TABLE IF EXISTS `bulk_upload_sim_inventory_errors`;
CREATE TABLE IF NOT EXISTS `bulk_upload_sim_inventory_errors` (
  `id` int(16) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremeted id.',
  `wso2_appilication_name` int(16) DEFAULT NULL COMMENT 'sim invenory belongs to which wso2 application',
  `sim_uid` text COMMENT 'sim''s unique id',
  `name` text COMMENT 'name are the unique parameters of sim like imsi,iccid ',
  `sim_id` text COMMENT 'sim id are the unique values of sim''s parameters like  imsi,iccid ',
  `type` text COMMENT 'type of parameters like home or donor',
  `file_id` int(16) DEFAULT NULL COMMENT 'id of file',
  `remark` varchar(256) DEFAULT NULL COMMENT 'remarks for sim inventory',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This table stores details of temporary sim inventory errors before inserting data into actual tables.';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.country
DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auo incremented id',
  `name` varchar(64) DEFAULT NULL COMMENT 'name of country',
  `code` varchar(64) DEFAULT NULL COMMENT 'code of country',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This table is used to store country';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.error_codes
DROP TABLE IF EXISTS `error_codes`;
CREATE TABLE IF NOT EXISTS `error_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `response_code` varchar(45) NOT NULL,
  `error_template` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_response_template_2018904` (`response_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.
-- Dumping structure for table goup_router.file_registration
DROP TABLE IF EXISTS `file_registration`;
CREATE TABLE IF NOT EXISTS `file_registration` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `uploaded_on` int(16) DEFAULT NULL,
  `uploaded_by` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_fault` tinyint(4) DEFAULT NULL,
  `is_status` int(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.
-- Dumping structure for procedure goup_router.get_messages
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

-- Dumping structure for procedure goup_router.goup_audit_log_count
DROP PROCEDURE IF EXISTS `goup_audit_log_count`;
DELIMITER //
CREATE  PROCEDURE `goup_audit_log_count`(
	IN `in_from_date` INT(16),
	IN `in_end_date` INT(16)
)
    COMMENT 'This Procedure helps to count the number of audit logs'
BEGIN
 /*
	--------------------------------------------------------------------------------------------------------------------------------------
	Description	:  This Procedure helps to count the number of audit logs
	Created On	:	11/10/2018
	Created By	:	Shantanu Bansal
	Modified By :   Nimisha Mittal
    Modified On :   2/1/2019
    Changed description : Changed the type of start time and end time 
	--------------------------------------------------------------------------------------------------------------------------------------
	Inputs 		:	in_from_date			-----------
					in_end_date				-----------
	Output		:	This Procedure helps to count the number of audit logs
	---------------------------------------------------------------------------------------------------------------------------------------
*/
	SELECT COUNT(DISTINCT(tracking_message_header)) as log_count
	FROM log_audit WHERE start_time BETWEEN in_from_date AND in_end_date;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_audit_log_insert
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

-- Dumping structure for procedure goup_router.goup_bulk_upload_sim_inventory_column_details
DROP PROCEDURE IF EXISTS `goup_bulk_upload_sim_inventory_column_details`;
DELIMITER //
CREATE  PROCEDURE `goup_bulk_upload_sim_inventory_column_details`()
BEGIN
 /*
  	-----------------------------------------------------------------------------------------------------------------------------------
  	Description	:  This Procedure Helps to get column details .
  	Created On	:  18/09/2018
  	Created By	:  Nimisha Mittal
  	----------------------------------------------------------------------------------------------------------------
	Inputs		:  
	Output		:	Msg	
		-----------------------------------------------------------------------------------------------------------------
	*/
	SELECT CONCAT( GROUP_CONCAT(column_name ORDER BY ordinal_position SEPARATOR',')) AS columns
	FROM information_schema.columns
	WHERE table_name = 'bulk_upload_sim_inventory' AND column_name!='id' AND column_name!='file_id'AND TABLE_SCHEMA='development_goup_router';
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_file_registration_insert
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

-- Dumping structure for procedure goup_router.goup_get_error_code_by_response_code
DROP PROCEDURE IF EXISTS `goup_get_error_code_by_response_code`;
DELIMITER //
CREATE  PROCEDURE `goup_get_error_code_by_response_code`(
	IN `in_response_code` varchar(45)
)
    COMMENT 'This procedure is for getting error codes by response code.'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:  This procedure is for getting error codes by response code.
    Created By  :   Nimisha Mittal
	Created On 	:   5/9/2018
	----------------------------------------------------------------------------------------------------------------
	Inputs	    :  IN in_response_code varchar(45)
    Output	   :	
	-----------------------------------------------------------------------------------------------------------------
*/
	-- Check if error codes already exists
	if(select count(id) from error_codes where response_code=in_response_code) then 
     select * from error_codes where response_code=in_response_code;
   else
   	select * from error_codes where response_code=500; 
   end if;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_interface_delete
DROP PROCEDURE IF EXISTS `goup_interface_delete`;
DELIMITER //
CREATE  PROCEDURE `goup_interface_delete`(
	IN `in_id` int(16)

)
    COMMENT 'This procedure is for deleting interfaces with mysql configs.'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:  This procedure is for deleting interfaces with mysql configs.
    Created By  :   Nimisha Mittal
	Created On 	:   5/9/2018
	Modified On :   26/09/2018
	Changed description : delete all the data releated to interface
	----------------------------------------------------------------------------------------------------------------
	 Inputs	    :   IN in_id int(16)
     Output	   :	Msg
     
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
	-- get sim identifieres of all interface
	drop temporary table if exists temp_sim_indentifier_bin;
	create temporary table temp_sim_indentifier_bin
	select sim_identfier_bin,wso2_appilication_id from sim_map where wso2_appilication_id in (select id from wso2_appilication where interface_id=in_id);

	-- delete data mapping of wso2 application from sim home identifiers
	delete from sim_home_identifiers where sim_identfier_bin in (select sim_identfier_bin from temp_sim_indentifier_bin);

	-- delete data mapping of wso2 application from sim donor identifiers
	delete from sim_donor_identfiers where sim_identfier_bin in (select sim_identfier_bin from temp_sim_indentifier_bin);

	-- delete data mapping of wso2 application from sim map
	delete from sim_map where wso2_appilication_id in (select id from wso2_appilication where interface_id=in_id);

-- delete data mapping of wso2 application from sim map hsitory
	delete from sim_map_history where wso2_appilication_id in (select wso2_appilication_id from temp_sim_indentifier_bin);

	--  delete data from wso2 application
	delete from wso2_appilication where  interface_id=in_id;

	-- delete interface
	delete from  interfaces where id=in_id;
	
    -- Get Message From messages table
	SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isInterfaceDeleted",1,temp_lang_code));			
	SELECT @msg AS msg;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_interface_get_by_id
DROP PROCEDURE IF EXISTS `goup_interface_get_by_id`;
DELIMITER //
CREATE  PROCEDURE `goup_interface_get_by_id`(
	IN `in_id` int(16)
)
    COMMENT 'This procedure is for getting interfaces with mysql configs on the basis of id'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:  This procedure is for getting interfaces with mysql configs on the basis of id
    Created By  :   Nimisha Mittal
	Created On 	:   5/9/2018
	Modified On :   14/09/2018
	Changed description : Modify documentation
	----------------------------------------------------------------------------------------------------------------
	Inputs	    :    IN in_id int(16),
    Output	   :	Msg
	-----------------------------------------------------------------------------------------------------------------
*/	
	select *  from  interfaces where id=in_id;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_interface_insert
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

-- Dumping structure for procedure goup_router.goup_interface_update
DROP PROCEDURE IF EXISTS `goup_interface_update`;
DELIMITER //
CREATE  PROCEDURE `goup_interface_update`(
	IN `in_id` int(16),
	IN `in_name` varchar(256) ,
	IN `in_mysql_host` varchar(64) ,
	IN `in_mysql_port` varchar(64) ,
	IN `in_mysql_username` varchar(64) ,
	IN `in_mysql_password` varchar(64) ,
	IN `in_version` varchar(45) ,
	IN `in_database_name` varchar(256),
    In in_thirdparty_database_name varchar(256)
)
    COMMENT 'This procedure is for updating interfaces with mysql configs.'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:  This procedure is for updating interfaces with mysql configs.
    Created By  :   Nimisha Mittal
	Created On 	:   5/9/2018
	Modified On :   13/03/2019
    Changed Description: insert third party name 
	----------------------------------------------------------------------------------------------------------------
	Inputs	    :   IN in_id int(16),
					IN in_name varchar(256) ,
					IN in_mysql_host varchar(64) ,
					IN in_mysql_port varchar(64) ,
					IN in_mysql_username varchar(64) ,
					IN in_mysql_password varchar(64) ,
					IN in_version varchar(45) ,
					IN in_database_name varchar(256),
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
		
        -- Check if interface already exists
		if(select count(id) from interfaces where in_name not in (select name from interfaces) and id!=in_id) then
			update interfaces
			set 
				`name`=in_name,
				mysql_host = in_mysql_host,
				mysql_port = in_mysql_port,
				mysql_username = in_mysql_username,
				mysql_password = in_mysql_password,
				version  =in_version,
				database_name =in_database_name,
                thirdparty_database_name=in_thirdparty_database_name
			where id=in_id;
			 -- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isInterfaceUpdated",1,temp_lang_code));			
			SELECT @msg AS msg;
		else
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isInterfaceExists",1,temp_lang_code));			
			SELECT @msg AS msg;
		end if;
END//
DELIMITER ;

-- Dumping structure for function goup_router.goup_message_by_parameter_and_langauge_code
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

-- Dumping structure for procedure goup_router.goup_router_audit_log_get_by_time
DROP PROCEDURE IF EXISTS `goup_router_audit_log_get_by_time`;
DELIMITER //
CREATE  PROCEDURE `goup_router_audit_log_get_by_time`(
	IN `in_start_time` int(16),
	IN `in_end_time` int(16),
	IN `in_limit` INT(16),
	IN `in_offset` INT(16)
)
    COMMENT 'This procedure is used to get logs in specific time interval'
BEGIN 
/*
	----------------------------------------------------------------------------------------------------------------
	Description	:   This procedure is used to get logs in specific time interval
	Created On  :   10/10/2018
	Created By  :   Nimisha Mittal
	Modified On :   13/03/2019
    Changed description : Added country id and operator id
	----------------------------------------------------------------------------------------------------------------
	Inputs		:   IN `in_start_date` int(16),
					IN in_end_date int(16),
                    IN `in_limit` INT(16),
					IN `in_offset` INT(16)
    Output		:		
	-----------------------------------------------------------------------------------------------------------------
*/
	select 
    log_audit.id,
    log_audit.tracking_message_header,
    log_audit.input_parameters,
    log_audit.ip_address,
    log_audit.start_time,
    log_audit.url_accessed,
    log_audit.api_name,
    log_audit.api_type,
    log_audit.is_header,
    log_audit.message,
    log_audit.is_successful,
    log_audit.api_response,
    log_audit.target_api_name,
    log_audit.end_time,
    log_audit.logtype,
    log_audit.country as country,
    log_audit.operator as operator,
    log_audit.country_id as country_id,
    log_audit.operator_id as operator_id
    from log_audit 
	where start_time between in_start_time and in_end_time 
	group by tracking_message_header order by start_time desc
	 limit in_limit offset in_offset ;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_country_operator_update
DROP PROCEDURE IF EXISTS `goup_router_country_operator_update`;
DELIMITER //
CREATE  PROCEDURE `goup_router_country_operator_update`(
	IN `in_identifier` varchar(256),
	IN `in_identifier_value` varchar(256),
	IN `in_country_code` varchar(256),
	IN `in_operator_code` varchar(256)


)
    COMMENT 'This procedure is used to update country and operator in profile switch condition.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to update country and operator in profile switch condition.
		Created On  :  03/08/2018
		Created By	:  Nimisha Mittal
		Modified On :  21/01/2019
		Changes description: changes in input parameter
		----------------------------------------------------------------------------------------------------------------
		Inputs		:  IN `in_identifier` varchar(256),
							IN `in_identifier_value` varchar(256),
							IN `in_country_code` varchar(256),
							IN `in_operator_code` varchar(256)
		Output		:	Msg	
		-----------------------------------------------------------------------------------------------------------------
	*/
     -- get country id
    set @temp_country_id=(select id from country where code=in_country_code);
    -- get operator id
    set @temp_operator_id=(select id from operator where name=in_operator_code);
    -- get wso2 appilication id
    set @temp_wso2_appilication_id=(select id from wso2_appilication where operator=@temp_operator_id and country=@temp_country_id);
   
	 set @temp_unique_identifier:=(select sim_identfier_bin from sim_map where sim_identfier = in_identifier_value);
    set @temp_home_identifiers:=(select sim_identfier_bin from sim_home_identifiers where sim_id=in_identifier_value);
	 set @temp_donor_identifiers:=(select sim_identfier_bin from sim_donor_identfiers where sim_id=in_identifier_value);

    set @temp_sim_id_bin:=(select coalesce(@temp_unique_identifier,@temp_home_identifiers,@temp_donor_identifiers)) ;

	-- get sim id
     set @temp_sim_id =(SELECT id FROM sim_map where sim_identfier_bin=@temp_sim_id); 
	
     -- move data into sim map history table
     insert into sim_map_history (sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid)
     select sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid from sim_map where id=@temp_sim_id;
     
      -- update sim map table
	   update sim_map
		set wso2_appilication_id=@temp_wso2_appilication_id
		where id=@temp_sim_id ;
		select 'Country and operator is updated.' as msg;

   /* -- Check if unique sim identifier is null or blank
	if(in_unique_sim_identifier is null or in_unique_sim_identifier='') then 
		-- get sim id
        set @temp_sim_id =(SELECT id FROM sim_map where sim_identfier_bin in (SELECT sim_identfier_bin FROM sim_donor_identfiers where sim_id=in_iccid or sim_id=in_ban)); 
		
        -- move data into sim map history table
        insert into sim_map_history (sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid)
        select sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid from sim_map where id=@temp_sim_id;
        
        -- update sim map table
		update sim_map
		set wso2_appilication_id=@temp_wso2_appilication_id
		where id=@temp_sim_id ;
		select 'Country and operator is updated.' as msg;
	else
		-- get sim id
		set @temp_sim_id =(SELECT id FROM sim_map where sim_identfier=in_unique_sim_identifier); 
		
        -- move data into sim map history table
		insert into sim_map_history (sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid)
        select sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid from sim_map where id=@temp_sim_id;
       
       -- update sim map table
		update sim_map
		set  wso2_appilication_id=@temp_wso2_appilication_id
		where id=@temp_sim_id ;
		select 'Country and operator is updated.' as msg;
	end if;
	*/
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_file_detail_get_all
DROP PROCEDURE IF EXISTS `goup_router_file_detail_get_all`;
DELIMITER //
CREATE  PROCEDURE `goup_router_file_detail_get_all`(
IN `in_start_date` bigint,
IN `in_end_date` bigint
)
    COMMENT 'This procedure helps to get all details of uploaded files on the basis of given start and end date.'
BEGIN
  /*
  	-----------------------------------------------------------------------------------------------------------------------------------
  	Description	:  This procedure helps to get all details of uploaded files on the basis of given start and end date.
  	Created On	:	19/09/2018
  	Created By	:  Nimisha Mittal
    
    Modified On	:	21 Sep 2018
    Modified By :	Saurabh kumar
    Modification:	Added where condition of uploaded start and end date.
  	-----------------------------------------------------------------------------------------------------------------------------------
  */
	SELECT 
		 file_registration.id, 
       file_registration.file_name, 
       file_registration.file_path, 
       file_registration.uploaded_on, 
       file_registration.uploaded_by, 
       file_registration.description, 
       file_registration.is_fault,
       `status`.message AS Status
	FROM file_registration
	INNER JOIN `status` ON file_registration.is_status=`status`.`status`
    WHERE file_registration.uploaded_on between in_start_date/1000 and in_end_date/1000;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_file_update_status
DROP PROCEDURE IF EXISTS `goup_router_file_update_status`;
DELIMITER //
CREATE  PROCEDURE `goup_router_file_update_status`(
	IN `in_status` INT,
	IN `in_file_id` INT
)
    COMMENT 'This Procedure Helps to Update Bulk Upload File.'
BEGIN
  /*
  	-----------------------------------------------------------------------------------------------------------------------------------
  	Description	:   This Procedure Helps to Update Bulk Upload File Status.
  	Created On	:	19/09/2018
  	Created By	:   Nimisha Mittal
  	----------------------------------------------------------------------------------------------------------------
	Inputs		:   IN `in_status` INT,
					IN `in_file_id` INT
	Output		:	Msg	
		-----------------------------------------------------------------------------------------------------------------
	*/
  -- Check file already exists
	IF((SELECT COUNT(*) FROM file_registration WHERE id=in_file_id)>0 )THEN
		UPDATE file_registration
		SET is_status=in_status 
		WHERE id=in_file_id;
		SELECT 'File Status Updated' As msg;
	ELSE
		SELECT 'File does not exists' As msg;  
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_get_all_country
DROP PROCEDURE IF EXISTS `goup_router_get_all_country`;
DELIMITER //
CREATE  PROCEDURE `goup_router_get_all_country`()
    COMMENT 'This procedure is used to get all country.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to get all country.
		Created On  :  14/09/2018
		Created By	:  Nimisha Mittal
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   
		Output		:	Msg	
		-----------------------------------------------------------------------------------------------------------------
	*/
	select * from country;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_get_all_interfaces
DROP PROCEDURE IF EXISTS `goup_router_get_all_interfaces`;
DELIMITER //
CREATE  PROCEDURE `goup_router_get_all_interfaces`()
    COMMENT 'This procedure is used to get all interfaces.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to get all interfaces.
		Created On  :  27/08/2018
		Created By	:  Nimisha Mittal
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   
		Output		:	Msg	
		-----------------------------------------------------------------------------------------------------------------
	*/
	select * from interfaces;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_get_all_operator
DROP PROCEDURE IF EXISTS `goup_router_get_all_operator`;
DELIMITER //
CREATE  PROCEDURE `goup_router_get_all_operator`()
    COMMENT 'This procedure is used to get all operator.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to get all operator.
		Created On  :  14/09/2018
		Created By	:  Nimisha Mittal
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   
		Output		:	Msg	
		-----------------------------------------------------------------------------------------------------------------
	*/
	select * from operator;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_get_auth_application_key
DROP PROCEDURE IF EXISTS `goup_router_get_auth_application_key`;
DELIMITER //
CREATE  PROCEDURE `goup_router_get_auth_application_key`(
	IN `in_identifier` varchar(256),
	IN `in_identifier_value` varchar(256)
)
    COMMENT 'This procedure is used to get auth application key.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to get auth application key.
		Created On  :  28/08/2018
		Created By	:  Nimisha Mittal
		Modified On :  15/02/2019
		Changes description: changes in data get
		----------------------------------------------------------------------------------------------------------------
		Inputs		:  IN `in_identifier` varchar(256),
							IN `in_identifier_value` varchar(256)
		Output		:		
		-----------------------------------------------------------------------------------------------------------------
	*/
	
		set @temp_unique_identifier:=(select sim_identfier_bin from sim_map where sim_identfier = in_identifier_value);
		set @temp_home_identifiers:=(select sim_identfier_bin from sim_home_identifiers where sim_id=in_identifier_value);
		set @temp_donor_identifiers:=(select sim_identfier_bin from sim_donor_identfiers where sim_id=in_identifier_value);

		set @temp_sim_id_bin:=(select coalesce(@temp_unique_identifier,@temp_home_identifiers,@temp_donor_identifiers)) ;

	    -- Check if all parameters are null
	    if(in_identifier is null and  in_identifier_value is null ) then 
			select auth_app_key as wso2_appilication_auth_app_key from wso2_appilication where id in (select wso2_appilication_id from sim_map where sim_identfier_bin=@temp_sim_id_bin) and false;
	    else
			 select auth_app_key as wso2_appilication_auth_app_key from wso2_appilication where id in (select wso2_appilication_id from sim_map where sim_identfier_bin=@temp_sim_id_bin);
	    end if;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_get_bulk_sim_inventory
DROP PROCEDURE IF EXISTS `goup_router_get_bulk_sim_inventory`;
DELIMITER //
CREATE  PROCEDURE `goup_router_get_bulk_sim_inventory`(In in_file_id int(16) , In in_is_faulty tinyint(4))
    COMMENT 'This Procedure Helps to get sim inventory of bulk upload.'
BEGIN
   /*
    	-----------------------------------------------------------------------------------------------------------------------------------
    	Description	:  This Procedure Helps to get sim inventory of bulk upload .
    	Created On	: 15/03/2019
    	Created By	: Nimisha Mittal
    	-----------------------------------------------------------------------------------------------------------------------------------
    */
	SELECT  wso2_appilication_name as id,sim_uid,bulk_upload_sim_inventory_errors.name,sim_id,type,remark ,wso2_appilication.name as wso2_appilication_name
    FROM bulk_upload_sim_inventory_errors 
    left join wso2_appilication on wso2_appilication.id=wso2_appilication_name WHERE file_id=in_file_id AND is_faulty=in_is_faulty ;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_get_mysql_config_by_interface_id
DROP PROCEDURE IF EXISTS `goup_router_get_mysql_config_by_interface_id`;
DELIMITER //
CREATE  PROCEDURE `goup_router_get_mysql_config_by_interface_id`(
In in_id int(16))
    COMMENT 'This procedure is used to get mysql config for dynamic connection of api for interface.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to get mysql config for dynamic connection of api for interface.
		Created On  :  27/08/2018
		Created By	:  Nimisha Mittal
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   In in_id int(16)
		Output		:	Msg	
		-----------------------------------------------------------------------------------------------------------------
	*/
	select * from interfaces where id=in_id;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_get_mysql_config_by_tracking_message_header
DROP PROCEDURE IF EXISTS `goup_router_get_mysql_config_by_tracking_message_header`;
DELIMITER //
CREATE  PROCEDURE `goup_router_get_mysql_config_by_tracking_message_header`(
	IN `in_tracking_message_header` VARCHAR(256)
)
    COMMENT 'This procedure is used to get mysql config on the basis of tracking message header.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to get mysql config on the basis of tracking message header.
		Created On  :  28/08/2018
		Created By	:  Nimisha Mittal
		Modified On :   16/01/2019
		Changed description : use id of country and operator instead of code 
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   In in_tracking_message_header int(16)
		Output		:	
		-----------------------------------------------------------------------------------------------------------------
	*/
    -- get the logs of reuest id.
    drop temporary table if exists temp_log_audit;
    create temporary table temp_log_audit
	select * from log_audit where tracking_message_header=in_tracking_message_header and country is not null limit 1;
    -- get country id
   set @temp_country_id:=(select country_id from temp_log_audit);
    -- get operator id
   set @temp_operator_id:=(select operator_id from temp_log_audit);

    select 
		`name` ,
		`mysql_host`,
		`mysql_port`,
		`mysql_username`,
		`mysql_password`,
		`mysql_password_salt`,
		`version`,
         database_name
    from interfaces where id in (select interface_id from wso2_appilication where operator=@temp_operator_id and country=@temp_country_id)
    union 
	select 
		`name` ,
		`mysql_host`,
		`mysql_port`,
		`mysql_username`,
		`mysql_password`,
		`mysql_password_salt`,
		`version`,
         thirdparty_database_name as database_name
		from interfaces where id in (select interface_id from wso2_appilication where operator=@temp_operator_id and country=@temp_country_id);

end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_get_operator_interface
DROP PROCEDURE IF EXISTS `goup_router_get_operator_interface`;
DELIMITER //
CREATE  PROCEDURE `goup_router_get_operator_interface`(
	IN `in_identifier` varchar(256),
	IN `in_identifier_value` varchar(256)
)
    COMMENT 'This procedure is used to get all details of sim identifier with operator interface.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to get all details of sim identifier with operator interface.
		Created On  :  15/06/2018
		Created By	:  Nimisha Mittal
		Modify On   :  02/04/2019
		Changed description: Handle identifier
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   IN in_identifier varchar(256),
							IN in_identifier_value varchar(256)
		Output		:		
		-----------------------------------------------------------------------------------------------------------------
	*/
    	-- set the length of group concat
		SET SESSION group_concat_max_len = 1000000;
		set @donor_query_case:=NULL;
		set @donor_query:=NULL;

		set @home_query_case:=NULL;
		set @home_query:=NULL;
		set in_identifier=trim(in_identifier);
        set in_identifier_value=trim(in_identifier_value);
        
		set @temp_unique_identifier:=(select sim_identfier_bin from sim_map where sim_identfier = in_identifier_value);
		set @temp_home_identifiers:=(select sim_identfier_bin from sim_home_identifiers where sim_id=in_identifier_value and name=in_identifier);
		set @temp_donor_identifiers:=(select sim_identfier_bin from sim_donor_identfiers where sim_id=in_identifier_value and name=in_identifier);


		set @temp_sim_id_bin:=(select coalesce(@temp_unique_identifier,@temp_home_identifiers,@temp_donor_identifiers)) ;
    if (@temp_sim_id_bin is null )then 
    select 'Data not available' as msg;
    else
		drop temporary table if exists temp_donor_data;
		drop temporary table if exists temp_home_data;
    
		-- query to create cases
		set @home_query_case:=(
		select 
		group_concat(distinct( concat("max(case when sim_home_identifiers.name='",sim_home_identifiers.name,"'"," then "," sim_home_identifiers.sim_id "," else null end) as `",CONCAT(LCASE(LEFT(sim_home_identifiers.name, 1)), LCASE(SUBSTRING(sim_home_identifiers.name, 2))),"`") ))
		from  
		sim_map
		JOIN wso2_appilication ON sim_map.wso2_appilication_id = wso2_appilication.id
		LEFT JOIN sim_home_identifiers ON sim_map.sim_identfier_bin = sim_home_identifiers.sim_identfier_bin
		JOIN operator ON operator.id = wso2_appilication.operator
		JOIN country ON country.id = wso2_appilication.country
		JOIN interfaces ON interfaces.id = wso2_appilication.interface_id
		where sim_home_identifiers.sim_identfier_bin=@temp_sim_id_bin
		);
		if(@home_query_case is null) then 
		 		 -- query to create cases
				set @donor_query_case:=(
				select 
				group_concat(distinct( concat("max(case when sim_donor_identfiers.name='",sim_donor_identfiers.name,"'"," then "," sim_donor_identfiers.sim_id "," else null end) as `",CONCAT(LCASE(LEFT(sim_donor_identfiers.name, 1)), LCASE(SUBSTRING(sim_donor_identfiers.name, 2))),"`") ))
				from   sim_map
				JOIN wso2_appilication ON sim_map.wso2_appilication_id = wso2_appilication.id
				LEFT JOIN sim_donor_identfiers ON sim_map.sim_identfier_bin = sim_donor_identfiers.sim_identfier_bin
				JOIN operator ON operator.id = wso2_appilication.operator
				JOIN country ON country.id = wso2_appilication.country
				JOIN interfaces ON interfaces.id = wso2_appilication.interface_id
		      where sim_donor_identfiers.sim_identfier_bin=@temp_sim_id_bin
				);		
				
			 	set @donor_query:=(select
					concat(" create temporary table temp_donor_data ","
								select sim_map.id as sim_map_id,
								sim_map.sim_identfier as `sim_identfier`,
								wso2_appilication.host as wso2_appilication_host,
								country.name as `country_name`,
			                    country.code as `country_code`,
								wso2_appilication.country as country_id,
								wso2_appilication.operator as operator_id,
								operator.name as `operator_name`,",
								@donor_query_case,
								" from   sim_map
								JOIN wso2_appilication ON sim_map.wso2_appilication_id = wso2_appilication.id
								LEFT JOIN sim_donor_identfiers ON sim_map.sim_identfier_bin = sim_donor_identfiers.sim_identfier_bin
								JOIN operator ON operator.id = wso2_appilication.operator
								JOIN country ON country.id = wso2_appilication.country
								JOIN interfaces ON interfaces.id = wso2_appilication.interface_id
								where sim_donor_identfiers.sim_identfier_bin='",@temp_sim_id_bin,"'
								group by sim_map.sim_uid",
								" ;"
								) );
			
            
					prepare stmt1 from @donor_query;
					execute stmt1;
					deallocate prepare stmt1;
					select * from temp_donor_data; 
		else
		 			 set @home_query:=(select
							concat(" create temporary table temp_home_data ","
							select sim_map.id as sim_map_id,
							sim_map.sim_identfier as `sim_identfier`,
							wso2_appilication.host as wso2_appilication_host,
							country.name as `country_name`,
		                    country.code as `country_code`,
							wso2_appilication.country as country_id,
							wso2_appilication.operator as operator_id,
							operator.name as `operator_name`,",
							@home_query_case,
							"from  sim_map
							JOIN wso2_appilication ON sim_map.wso2_appilication_id = wso2_appilication.id
							LEFT JOIN sim_home_identifiers ON sim_map.sim_identfier_bin = sim_home_identifiers.sim_identfier_bin
							JOIN operator ON operator.id = wso2_appilication.operator
							JOIN country ON country.id = wso2_appilication.country
							JOIN interfaces ON interfaces.id = wso2_appilication.interface_id
						   where sim_home_identifiers.sim_identfier_bin='",@temp_sim_id_bin,"'
							group by sim_map.sim_uid",
							" ;"
							) );
							
							prepare stmt2 from @home_query;
							execute stmt2;
							deallocate prepare stmt2; 
		
						select * from temp_home_data; 
		end if;
        end if;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_get_operator_interface_core
DROP PROCEDURE IF EXISTS `goup_router_get_operator_interface_core`;
DELIMITER //
CREATE  PROCEDURE `goup_router_get_operator_interface_core`(
	IN `in_identifier` varchar(256),
	IN `in_identifier_value` varchar(256)

)
    COMMENT 'This procedure is used to get all details of sim identifier with operator interface.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to get all details of sim identifier with operator interface.
		Created On  :  15/06/2018
		Created By	:  Nimisha Mittal
        Modify On   :  11/01/2019
        Changed description: get dynamix fields 
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   IN in_unique_sim_identifier varchar(256),
						IN in_ban varchar(256),
						IN in_iccid varchar(256)
		Output		:		
		-----------------------------------------------------------------------------------------------------------------
	*/
	
    	 	-- set the length of group concat
		SET SESSION group_concat_max_len = 1000000;
		set @donor_query_case:=NULL;
		set @donor_query:=NULL;

		set @home_query_case:=NULL;
		set @home_query:=NULL;
		
		set @temp_unique_identifier:=(select sim_identfier_bin from sim_map where sim_identfier = in_identifier_value);
		set @temp_home_identifiers:=(select sim_identfier_bin from sim_home_identifiers where sim_id=in_identifier_value);
		set @temp_donor_identifiers:=(select sim_identfier_bin from sim_donor_identfiers where sim_id=in_identifier_value);


		set @temp_sim_id_bin:=(select coalesce(@temp_unique_identifier,@temp_home_identifiers,@temp_donor_identifiers)) ;


		drop temporary table if exists temp_donor_data;
		drop temporary table if exists temp_home_data;
    
		-- query to create cases
		set @donor_query_case:=(
		select 
		group_concat(distinct( concat("max(case when sim_donor_identfiers.name='",sim_donor_identfiers.name,"'"," then "," sim_donor_identfiers.sim_id "," else null end) as `",CONCAT('Donor ',UCASE(LEFT(sim_donor_identfiers.name, 1)), LCASE(SUBSTRING(sim_donor_identfiers.name, 2))),"`") ))
		from sim_map
		JOIN wso2_appilication ON sim_map.wso2_appilication_id = wso2_appilication.id
		LEFT JOIN sim_donor_identfiers ON sim_map.sim_identfier_bin = sim_donor_identfiers.sim_identfier_bin
		JOIN operator ON operator.id = wso2_appilication.operator
		JOIN country ON country.id = wso2_appilication.country
		JOIN interfaces ON interfaces.id = wso2_appilication.interface_id
		);


		-- query to create cases
		set @home_query_case:=(
		select 
		group_concat(distinct( concat("max(case when sim_home_identifiers.name='",sim_home_identifiers.name,"'"," then "," sim_home_identifiers.sim_id "," else null end) as `",CONCAT('Home ',UCASE(LEFT(sim_home_identifiers.name, 1)), LCASE(SUBSTRING(sim_home_identifiers.name, 2))),"`") ))
		from sim_map
		JOIN wso2_appilication ON sim_map.wso2_appilication_id = wso2_appilication.id
		LEFT JOIN sim_home_identifiers ON sim_map.sim_identfier_bin = sim_home_identifiers.sim_identfier_bin
		JOIN operator ON operator.id = wso2_appilication.operator
		JOIN country ON country.id = wso2_appilication.country
		JOIN interfaces ON interfaces.id = wso2_appilication.interface_id
		);
                      
		if(@donor_query_case is not null and @home_query_case is not null) then
				
				set @home_query:=(select
				concat(" create temporary table temp_home_data ","
				select sim_map.id as sim_map_id,
				sim_map.sim_identfier as `sim_identfier`,
				wso2_appilication.host as wso2_appilication_host,
				country.name as `country_name`,
				country.code as `country_code`,
				wso2_appilication.country as wso2_appilication_country_id,
				wso2_appilication.operator as wso2_appilication_operator_id,
				operator.name as `operator_name`,",@home_query_case,
				" from sim_map
				JOIN wso2_appilication ON sim_map.wso2_appilication_id = wso2_appilication.id
				LEFT JOIN sim_home_identifiers ON sim_map.sim_identfier_bin = sim_home_identifiers.sim_identfier_bin
				JOIN operator ON operator.id = wso2_appilication.operator
				JOIN country ON country.id = wso2_appilication.country
				JOIN interfaces ON interfaces.id = wso2_appilication.interface_id
				where  sim_home_identifiers.sim_identfier_bin='",@temp_sim_id_bin,"'"  ,"
				group by sim_map.sim_uid",
				" ;"
				) );
				
				prepare stmt2 from @home_query;
				execute stmt2;
				deallocate prepare stmt2; 
				
				set @donor_query:=(select
				concat(" create temporary table temp_donor_data ","
				select sim_map.id as sim_map_id1,",
				@donor_query_case,
				" from sim_map
				JOIN wso2_appilication ON sim_map.wso2_appilication_id = wso2_appilication.id
				LEFT JOIN sim_donor_identfiers ON sim_map.sim_identfier_bin = sim_donor_identfiers.sim_identfier_bin
				JOIN operator ON operator.id = wso2_appilication.operator
				JOIN country ON country.id = wso2_appilication.country
				JOIN interfaces ON interfaces.id = wso2_appilication.interface_id
				where sim_donor_identfiers.sim_identfier_bin='",@temp_sim_id_bin,"'
				group by sim_map.sim_uid",
				" ;"
				) );
				
				prepare stmt1 from @donor_query;
				execute stmt1;
				deallocate prepare stmt1;
				
				-- Get the resultant
				select * from temp_home_data left join temp_donor_data on temp_donor_data.sim_map_id1=temp_home_data.sim_map_id ;
		else
				select 'No data available' as msg;
		end if;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_get_sim_inventory_details
DROP PROCEDURE IF EXISTS `goup_router_get_sim_inventory_details`;
DELIMITER //
CREATE  PROCEDURE `goup_router_get_sim_inventory_details`()
    COMMENT 'This procedure helps to get all details of uploaded sim inventory.'
BEGIN
  /*
  	-----------------------------------------------------------------------------------------------------------------------------------
  	Description	:  This procedure helps to get all details of uploaded sim inventory.
  	Created On	:  19/09/2018
    Created By	:	Nimisha Mittal
    Modified On :   1/2/2019
    Changed description : order by the data
  	-----------------------------------------------------------------------------------------------------------------------------------
	Inputs		:   
	Output		:		
	-----------------------------------------------------------------------------------------------------------------
	*/
		-- set the length of group concat
		SET SESSION group_concat_max_len = 1000000;
		set @donor_query_case:=NULL;
		set @donor_query:=NULL;

		set @home_query_case:=NULL;
		set @home_query:=NULL;
		
 	set @temp_donoe:=(select count(sim_donor_identfiers_name) from  vw_wso2_appilication_details);
 	set @temp_home:=(select count(sim_home_identfiers_name) from  vw_wso2_appilication_details);

	drop temporary table if exists temp_donor_data;
 	drop temporary table if exists temp_home_data;
  
		-- query to create cases
		set @donor_query_case:=(
						  select 
							group_concat(distinct( concat("max(case when sim_donor_identfiers_name='",sim_donor_identfiers_name,"'"," then "," sim_donor_identfiers_sim_id "," else null end) as `",CONCAT('Donor ',UCASE(LEFT(sim_donor_identfiers_name, 1)), LCASE(SUBSTRING(sim_donor_identfiers_name, 2))),"`") ))
							from  vw_wso2_appilication_details 
						 );
						 


			    -- query to create cases
				set @home_query_case:=(
								  select 
									group_concat(distinct( concat("max(case when sim_home_identfiers_name='",sim_home_identfiers_name,"'"," then "," sim_home_identfiers_sim_id "," else null end) as `",CONCAT('Home ',UCASE(LEFT(sim_home_identfiers_name, 1)), LCASE(SUBSTRING(sim_home_identfiers_name, 2))),"`") ))
									from  vw_wso2_appilication_details 
								 );
								 

	if(@donor_query_case is not null and @home_query_case is not null) then
		set @home_query:=(select
								concat(" create temporary table temp_home_data ","
								select sim_map_id,wso2_appilication_name as `Application Name`,sim_identfier as `Sim Identifier`,country_name as `Country`,operator_name as `Operator`,",
									@home_query_case,
						"		from vw_wso2_appilication_details  group by sim_map_sim_uid",
						" ;"
						) );
						
				prepare stmt2 from @home_query;
				execute stmt2;
				deallocate prepare stmt2; 

			set @donor_query:=(select
									concat(" create temporary table temp_donor_data ","
									select sim_map_id as sim_map_id1,",
										@donor_query_case,
							"		from vw_wso2_appilication_details  group by sim_map_sim_uid",
							" ;"
							) );
							
					prepare stmt1 from @donor_query;
					execute stmt1;
					deallocate prepare stmt1;
		
				-- Get the resultant
			select * from temp_home_data  left join temp_donor_data on temp_donor_data.sim_map_id1=temp_home_data.sim_map_id order by sim_map_id desc;
	else
		select 'No data available' as msg;

	end if;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_operator_delete
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
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_operator_get_by_id
DROP PROCEDURE IF EXISTS `goup_router_operator_get_by_id`;
DELIMITER //
CREATE  PROCEDURE `goup_router_operator_get_by_id`(
In in_id int(16)
)
    COMMENT 'This Procedure helps to get a particular operator detail'
BEGIN
	/*
	--------------------------------------------------------------------------------------------------------------------------------------
	Description	:  	This Procedure helps to get a particular operator detail
	Created On	:	20/07/2018
	Created By	:	Nimisha Mittal
	--------------------------------------------------------------------------------------------------------------------------------------
	Inputs 		:	In in_id int(16)
	Output		:	This Procedure helps to get a particular operator detail
	---------------------------------------------------------------------------------------------------------------------------------------
	*/
	select * from operator where id=in_id;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_operator_get_by_interface_id
DROP PROCEDURE IF EXISTS `goup_router_operator_get_by_interface_id`;
DELIMITER //
CREATE  PROCEDURE `goup_router_operator_get_by_interface_id`(
In in_interface_id int(16)
)
    COMMENT 'This Procedure helps to get operator detail on the basis of interface'
BEGIN
	/*
	--------------------------------------------------------------------------------------------------------------------------------------
	Description	:  	This Procedure helps to get operator detail on the basis of interface
	Created On	:	29/10/2018
	Created By	:	Nimisha Mittal
	--------------------------------------------------------------------------------------------------------------------------------------
	Inputs 		:	In in_interface_id int(16)
	Output		:	This Procedure helps to get operator detail on the basis of interface
	---------------------------------------------------------------------------------------------------------------------------------------
	*/
	select operator.id as id,operator.name as name,operator.code as code from operator 
    inner join operator_interface on operator.id=operator_id
    where interface_id=in_interface_id;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_operator_insert
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

-- Dumping structure for procedure goup_router.goup_router_operator_update
DROP PROCEDURE IF EXISTS `goup_router_operator_update`;
DELIMITER //
CREATE  PROCEDURE `goup_router_operator_update`(
In in_id int(16),
In in_name varchar(64),
In in_code varchar(64)
)
    COMMENT 'This Procedure helps to update operator'
BEGIN
	/*
	--------------------------------------------------------------------------------------------------------------------------------------
	Description	:  	This Procedure helps to update operator
	Created On	:	20/07/2018
	Created By	:	Nimisha Mittal
	--------------------------------------------------------------------------------------------------------------------------------------
	Inputs 		:	In in_id int(16),
					In in_name varchar(64),
					In in_code varchar(64)
	Output		:	This Procedure helps to update operator
    
    Modified On	:	24 Oct 2018
	Modified By	:	Saurabh kumar
	Modification:	Added logic of localization
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
        
		-- Check if operator already exists.
		if(select count(id) from operator where in_name not in (select name from operator where id!=in_id)) then 
			update operator
			set  
				name=in_name,
				code=in_code
            where id=in_id;
			-- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isOperatorUpdated",1,temp_lang_code));			
			SELECT @msg AS msg;
		else
			-- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isOperatorExists",1,temp_lang_code));			
			SELECT @msg AS msg;
		end if;
END//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_sim_inventory_bulk_insert
DROP PROCEDURE IF EXISTS `goup_router_sim_inventory_bulk_insert`;
DELIMITER //
CREATE  PROCEDURE `goup_router_sim_inventory_bulk_insert`(
	IN `in_user_key` VARCHAR(256),
	IN `in_user_id` VARCHAR(256),
	IN `in_file_id` INT(16)
)
    COMMENT 'This procedure is used to insert bulk data of sim inventory of a single wso2 appilication.'
BEGIN 
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to insert bulk data of sim inventory of a single wso2 appilication.
		Created On  :  30/08/2018
		Created By	:  Nimisha Mittal
        Description	:  insertion of multiple data for a sim
		Modified On  : 05/02/2019
		----------------------------------------------------------------------------------------------------------------
		Inputs		: 	IN `in_user_key ` VARCHAR(256),
						IN `in_user_id` VARCHAR(256),
						IN `in_file_id` INT(16)
		Output		:   Msg	
		-----------------------------------------------------------------------------------------------------------------
	*/

		-- get file id from bulk upload sim inventory
		 set @temp_file_id:=(select file_id from bulk_upload_sim_inventory limit 1);
		
        if(select count(id) from bulk_upload_sim_inventory where file_id=in_file_id)=0 then
			select 'File is empty.' as msg;
        else
        
		-- store data of file into temporary table
		drop temporary table if exists temp_bulk_upload_sim_inventory;
		create temporary table `temp_bulk_upload_sim_inventory` (`id` int(11) NOT NULL AUTO_INCREMENT ,`wso2_appilication_id` int(16) DEFAULT NULL,`sim_uid` text,`name` text ,`sim_id` text ,`type` text ,`file_id` int(16) DEFAULT NULL,PRIMARY KEY (`id`))  ;
		insert into `temp_bulk_upload_sim_inventory`(`wso2_appilication_id`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`)
		select wso2_appilication.id as wso2_appilication_id,trim(`sim_uid`) as sim_uid, 
		trim(bulk_upload_sim_inventory.`name`) as name,
		trim(bulk_upload_sim_inventory.`sim_id`) as sim_id,
		replace(replace(bulk_upload_sim_inventory.`type`, "\n", ""),"\r","") as `type`,
		trim(`file_id`) as file_id
		from bulk_upload_sim_inventory 
		left join wso2_appilication on wso2_appilication.name=bulk_upload_sim_inventory.wso2_appilication_name
		where file_id=in_file_id 
        and bulk_upload_sim_inventory.`sim_id` !='null' ;

		
        -- insert data into bulk upload sim inventory errors
		INSERT INTO `bulk_upload_sim_inventory_errors`
		(`wso2_appilication_name`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,`remark`,is_faulty)
		select wso2_appilication.id,`sim_uid`,bulk_upload_sim_inventory.`name`,`sim_id`,`type`,`file_id`,'sim id is null',1
		from bulk_upload_sim_inventory 
        left join wso2_appilication on wso2_appilication.name=bulk_upload_sim_inventory.wso2_appilication_name
		where file_id=in_file_id and bulk_upload_sim_inventory.`sim_id` ='null' ;


		drop temporary table if exists temp_bulk_upload_sim_inventory_null_values;
		create temporary table temp_bulk_upload_sim_inventory_null_values
		select * from temp_bulk_upload_sim_inventory where wso2_appilication_id is null;
		
		drop temporary table if exists temp_bulk_upload_sim_inventory_nonenull_values;
		create temporary table temp_bulk_upload_sim_inventory_nonenull_values
		select * from temp_bulk_upload_sim_inventory where wso2_appilication_id is not null;
		
		
		-- insert data into bulk upload sim inventory errors
		INSERT INTO `bulk_upload_sim_inventory_errors`
		(`wso2_appilication_name`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,`remark`,is_faulty)
		select `wso2_appilication_id`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,'Wso2 application name is wrong',1
		from temp_bulk_upload_sim_inventory_null_values;

		
		-- ---------------Sim uid Checks---------------------------------
		
		drop temporary table if exists temp_bulk_upload_sim_uid;
		create temporary table temp_bulk_upload_sim_uid
		select 
		temp_bulk_upload_sim_inventory_nonenull_values.wso2_appilication_id as wso2_appilication_id,
		temp_bulk_upload_sim_inventory_nonenull_values.name,
		temp_bulk_upload_sim_inventory_nonenull_values.sim_id,
		temp_bulk_upload_sim_inventory_nonenull_values.type,
		temp_bulk_upload_sim_inventory_nonenull_values.file_id,
		temp_bulk_upload_sim_inventory_nonenull_values.sim_uid,
		sim_map.sim_identfier,sim_map.sim_identfier_bin,sim_map.sim_uid as sim_map_sim_uid
		 from temp_bulk_upload_sim_inventory_nonenull_values 
		left join sim_map on temp_bulk_upload_sim_inventory_nonenull_values.sim_uid=sim_map.sim_uid;
/*
select * from temp_bulk_upload_sim_inventory_nonenull_values;
select * from temp_bulk_upload_sim_uid ;
--  where  temp_bulk_upload_sim_uid.sim_identfier is not null ;

-- insert data into sim home identifiers
insert into sim_home_identifiers (name,sim_identfier_bin,sim_id) 
select name,sim_identfier_bin,sim_id from temp_bulk_upload_sim_uid where `type`='home' or `type`='Home' and temp_bulk_upload_sim_uid.sim_identfier is not null 
group by sim_identfier_bin;

-- insert data into sim donor identifiers
insert into sim_donor_identfiers (name,sim_identfier_bin,sim_id) 
select name,sim_identfier_bin,sim_id from temp_bulk_upload_sim_uid where `type`='donor' or `type`='Donor' and temp_bulk_upload_sim_uid.sim_identfier is not null 
group by sim_identfier_bin;

select *,count(name),group_concat(name),max(id) from sim_home_identifiers group by sim_identfier_bin,name
having count(name)>1;
select *,count(sim_id),group_concat(sim_id),max(id) from sim_home_identifiers group by sim_identfier_bin,sim_id
having count(sim_id)>1;
select *,count(name),group_concat(name),max(id) from sim_donor_identfiers group by sim_identfier_bin,name
having count(name)>1;
select *,count(sim_id),group_concat(sim_id),max(id) from sim_donor_identfiers group by sim_identfier_bin,sim_id
having count(sim_id)>1;


	-- insert data into bulk upload sim inventory errors
		INSERT INTO `bulk_upload_sim_inventory_errors`
		(`wso2_appilication_name`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,`remark`,is_faulty)
		select `wso2_appilication_id`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,'Sim id already exists',1
		from temp_bulk_upload_identifiers_data where hdsim_id is not null ;

*/
     
		
		delete from sim_donor_identfiers where sim_identfier_bin in (select sim_identfier_bin from temp_bulk_upload_sim_uid where sim_map_sim_uid is not null );
		
		delete from sim_home_identifiers where sim_identfier_bin in (select sim_identfier_bin from temp_bulk_upload_sim_uid where sim_map_sim_uid is not null  );
		
		delete from sim_map where sim_identfier_bin in (select sim_identfier_bin from temp_bulk_upload_sim_uid where sim_map_sim_uid is not null  );
		
		-- ----------------------Sim id exists or not -----------------------------------
		
		drop temporary table if exists temp_bulk_upload_home_identifiers;
		create temporary table temp_bulk_upload_home_identifiers
		select temp_bulk_upload_sim_uid.*,sim_home_identifiers.sim_id as hdsim_id from temp_bulk_upload_sim_uid 
		left join sim_home_identifiers on temp_bulk_upload_sim_uid.sim_id=sim_home_identifiers.sim_id
        where temp_bulk_upload_sim_uid.sim_identfier is null;


		drop temporary table if exists temp_bulk_upload_donor_identfiers;
		create temporary table temp_bulk_upload_donor_identfiers
		select temp_bulk_upload_sim_uid.*,sim_donor_identfiers.sim_id as hdsim_id from temp_bulk_upload_sim_uid 
		left join sim_donor_identfiers on temp_bulk_upload_sim_uid.sim_id=sim_donor_identfiers.sim_id
        where temp_bulk_upload_sim_uid.sim_identfier is null;
		

		
		drop temporary table if exists temp_bulk_upload_identifiers_data;
		create temporary table temp_bulk_upload_identifiers_data 
		select * from temp_bulk_upload_home_identifiers
		union
		select * from temp_bulk_upload_donor_identfiers;
		

		
		drop temporary table if exists temp_bulk_upload_data;
		create temporary table temp_bulk_upload_data 
		select * from temp_bulk_upload_identifiers_data where hdsim_id is null ;
		
		-- insert data into bulk upload sim inventory errors
		INSERT INTO `bulk_upload_sim_inventory_errors`
		(`wso2_appilication_name`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,`remark`,is_faulty)
		select `wso2_appilication_id`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,'Sim id already exists',1
		from temp_bulk_upload_identifiers_data where hdsim_id is not null ;



	   SET @rank:=0;
		SET @prev_sim_uid:='';

		-- temporary table to generate group id for each sim
		drop temporary table if exists temp_data1;
		create temporary table temp_data1
		select * ,
		case when  @prev_sim_uid='' OR @prev_sim_uid!=sim_uid
		THEN (SELECT @rank:=@rank+1) ELSE @rank END AS group_rank,
		@prev_sim_uid:=sim_uid as prev_sim_uid
		from temp_bulk_upload_data ;
		


		SET @prev_rank_group:='';
		SET @temp_uuid:=(select uuid());

		-- temporary table to store generation of unique identifiers for each sim
		drop temporary table if exists temp_generation_uique_identifier;
		create temporary table temp_generation_uique_identifier
		select * ,
		case when  @prev_rank_group='' OR @prev_rank_group!=group_rank THEN (SELECT @temp_uuid:= uuid()) ELSE @temp_uuid END AS `uique_identifier`,
		@prev_rank_group:=group_rank as prev_sim_uid_prev_sim_uid
		from temp_data1 order by group_rank;



		-- get final data with binary conversion.
		drop temporary table if exists temp_final_generted_data;
		create temporary table temp_final_generted_data
		select *,goup_utility_ordered_uuid(uique_identifier) as `binlog` from temp_generation_uique_identifier;
	
		-- insert data into sim map
		insert into sim_map (sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid,file_id) 
		select uique_identifier,`binlog`,wso2_appilication_id,sim_uid,in_file_id from temp_final_generted_data group by sim_uid;

		-- insert data into sim home identifiers
		insert into sim_home_identifiers (name,sim_identfier_bin,sim_id) 
		select name,`binlog`,sim_id from temp_final_generted_data where `type`='home' or `type`='Home' group by sim_uid,lcase(`name`) ;
		
		-- insert data into sim donor identifiers
		insert into sim_donor_identfiers (name,sim_identfier_bin,sim_id) 
		select name,`binlog`,sim_id from temp_final_generted_data where `type`='donor' or `type`='Donor' group by sim_uid,lcase(`name`) ;

		set @wso2_app_count:=(select count(wso2_appilication_id) from temp_final_generted_data);
		set @temp_data:=(select count(id) from bulk_upload_sim_inventory where file_id=in_file_id);

			if(@wso2_app_count=@temp_data) then 
				 SELECT status,message FROM status WHERE status=2;
			elseif(@wso2_app_count=0) then
			 SELECT status,message FROM status WHERE status=4;
			else
			SELECT status,message FROM status WHERE status=3;
			end if;
              
	end if;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_sim_inventory_delete
DROP PROCEDURE IF EXISTS `goup_router_sim_inventory_delete`;
DELIMITER //
CREATE  PROCEDURE `goup_router_sim_inventory_delete`(
	IN `in_sim_map_id` int(16)

)
    COMMENT 'This procedure is used to delete sim inventory.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to delete sim inventory.
		Created On  :  25/09/2018
		Created By	:  Nimisha Mittal
		----------------------------------------------------------------------------------------------------------------
		Inputs		: IN in_sim_map_id int(16)
		Output		: Msg	
        
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
        
		-- get the sim identfier binary of sim
		set @temp_sim_identfier_bin:=(select sim_identfier_bin from sim_map where id=in_sim_map_id);
        
        -- delete data from sim home identifiers
        delete from sim_home_identifiers where sim_identfier_bin=@temp_sim_identfier_bin;
        
        -- delete data from sim donor identifiers
        delete from sim_donor_identfiers where sim_identfier_bin=@temp_sim_identfier_bin;
        
        -- delete data from sim map
        delete from sim_map where id=in_sim_map_id;
        -- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isSimInventoryDeleted",1,temp_lang_code));			
		SELECT @msg AS msg;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_sim_inventory_insert
DROP PROCEDURE IF EXISTS `goup_router_sim_inventory_insert`;
DELIMITER //
CREATE  PROCEDURE `goup_router_sim_inventory_insert`(
In in_wso2_appilication_id int(16) ,
In in_sim_uid varchar(64),
In in_name text,
In in_sim_id text,
In in_type varchar(32)
)
    COMMENT 'This procedure is used to insert sim inventory.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to insert sim inventory.
		Created On  :  28/08/2018
		Created By	:  Nimisha Mittal
		----------------------------------------------------------------------------------------------------------------
		Inputs		: In in_wso2_appilication_id int(16) ,
					  In in_sim_uid varchar(64),
					  In in_name varchar(10),
					  In in_sim_id varchar(45),
					  In in_type varchar(32)
		Output		: Msg	
        
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
        
    -- get unique indentifier
    set @temp_sim_identfier:=(select uuid());
    -- generate binary format unique indentifier
    set @temp_sim_identifier_bin:=(select goup_utility_ordered_uuid(@temp_sim_identfier));
    
    -- insert data into  sim map
	insert into sim_map (sim_identfier,sim_identfier_bin,wso2_appilication_id,sim_uid) 
    values(@temp_sim_identfier,@temp_sim_identifier_bin,in_wso2_appilication_id,in_sim_uid);
    
    -- split multiple values of sim unique id and convert to multiple rows
    drop temporary table if exists temp_sim_unique_id;
    call goup_router_utility_string_split(in_name);
    create temporary table  temp_sim_unique_id(`id` int(11) NOT NULL AUTO_INCREMENT ,`name` varchar(64) ,PRIMARY KEY (`id`));
    insert into temp_sim_unique_id(name)(SELECT trim(split_data) FROM temp_convert);
    
    -- split multiple values of sim unique value and convert to multiple rows
	drop temporary table if exists temp_sim_unique_value;
    call goup_router_utility_string_split(in_sim_id);
    create temporary table  temp_sim_unique_value(`id` int(11) NOT NULL AUTO_INCREMENT ,`name` varchar(64) ,PRIMARY KEY (`id`));
    insert into temp_sim_unique_value(name)(SELECT trim(split_data) FROM temp_convert);
    
	-- combine sim unique id and value 
    drop temporary table if exists temp_sim_unique_id_value;
    create temporary table temp_sim_unique_id_value
    select temp_sim_unique_id.name as name,temp_sim_unique_value.name as sim_id
    from temp_sim_unique_id inner join temp_sim_unique_value on temp_sim_unique_id.id=temp_sim_unique_value.id ;
        
    -- Check if type of sim's values are of home type.
    if(type='Home') then 
		insert into sim_home_identifiers (name,sim_identfier_bin,sim_id) 
		select name,@temp_sim_identifier_bin,sim_id from temp_sim_unique_id_value ;
    else
		insert into sim_donor_identfiers (name,sim_identfier_bin,sim_id) 
		select name,@temp_sim_identifier_bin,sim_id from temp_sim_unique_id_value ;
    end if;
     -- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isSimInventoryInserted",1,temp_lang_code));			
		SELECT @msg AS msg;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_utility_string_split
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

-- Dumping structure for procedure goup_router.goup_router_wso2_appilication_delete
DROP PROCEDURE IF EXISTS `goup_router_wso2_appilication_delete`;
DELIMITER //
CREATE  PROCEDURE `goup_router_wso2_appilication_delete`(
In in_id int(16)
)
    COMMENT 'This procedure is used to delete wso2 appilication.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to delete wso2 appilication.
		Created On  :  27/08/2018
		Created By	:  Nimisha Mittal
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   In in_id int(16)
		Output		:	Msg	
        
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
        
	-- get sim identifier bin
	set @temp_sim_indentifier_bin:=(select sim_identfier_bin from sim_map where wso2_appilication_id=in_id);
	-- delete data mapping of wso2 application from sim home identifiers
	delete from sim_home_identifiers where sim_identfier_bin=@temp_sim_indentifier_bin;
	-- delete data mapping of wso2 application from sim donor identifiers
	delete from sim_donor_identfiers where sim_identfier_bin=@temp_sim_indentifier_bin;
	-- delete data mapping of wso2 application from sim map
	delete from sim_map where wso2_appilication_id=in_id;
	-- delete data mapping of wso2 application from sim map hsitory
	delete from sim_map_history where wso2_appilication_id=in_id;
	--  delete data from wso2 application
	delete from wso2_appilication where id=in_id;
    -- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isWso2AppilicationDeleted",1,temp_lang_code));			
		SELECT @msg AS msg;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_wso2_appilication_get_all
DROP PROCEDURE IF EXISTS `goup_router_wso2_appilication_get_all`;
DELIMITER //
CREATE  PROCEDURE `goup_router_wso2_appilication_get_all`()
    COMMENT 'This procedure is used to get all wso2 appilication details.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to get all wso2 appilication details.
		Created On  :  27/08/2018
		Created By	:  Nimisha Mittal
		Modified On :  06/09/2018
		Changed Description: Return country and operator name
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   In in_id int(16)
		Output		:	Msg	
		-----------------------------------------------------------------------------------------------------------------
	*/
		select 
		wso2_appilication.id ,
		wso2_appilication.name ,
		operator , 
		country ,
		interface_id ,
		host ,
		port ,
		version ,
		auth_app_key ,
		country.name as country_name,
		country.code as country_code,
		operator.name as operator_name
	from wso2_appilication
	left join country on country.id=wso2_appilication.country
	left join operator on operator.id=wso2_appilication.operator;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_wso2_appilication_get_by_id
DROP PROCEDURE IF EXISTS `goup_router_wso2_appilication_get_by_id`;
DELIMITER //
CREATE  PROCEDURE `goup_router_wso2_appilication_get_by_id`(
In in_id int(16)
)
    COMMENT 'This procedure is used to get a particular wso2 appilication details.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to get a particular wso2 appilication details.
		Created On  :  27/08/2018
		Created By	:  Nimisha Mittal
		Modified On :  06/09/2018
		Changed Description: Return country and operator name
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   In in_id int(16)
		Output		:	Msg	
		-----------------------------------------------------------------------------------------------------------------
	*/
		select 
    	wso2_appilication.id ,
		wso2_appilication.name ,
		operator , 
		country ,
		interface_id ,
		host ,
		port ,
		version ,
		auth_app_key ,
		country.name as country_name,
		country.code as country_code,
		operator.name as operator_name
    from wso2_appilication
    inner join country on country.id=wso2_appilication.country
	inner join operator on operator.id=wso2_appilication.operator where id=in_id;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_wso2_appilication_get_by_interface_id
DROP PROCEDURE IF EXISTS `goup_router_wso2_appilication_get_by_interface_id`;
DELIMITER //
CREATE  PROCEDURE `goup_router_wso2_appilication_get_by_interface_id`(
In in_interface_id int(16)
)
    COMMENT 'This procedure is used to get all wso2 appilication details on the basis of interface.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to get all wso2 appilication details on the basis of interface.
		Created On  :  27/08/2018
		Created By	:  Nimisha Mittal
		Modified On :  06/09/2018
		Changed Description: Return country and operator name
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   In in_interface_id int(16)
		Output		:	Msg	
		-----------------------------------------------------------------------------------------------------------------
	*/
	select 
		wso2_appilication.id ,
		wso2_appilication.name ,
		operator , 
		country ,
		interface_id ,
		host ,
		port ,
		version ,
		auth_app_key ,
		country.name as country_name,
		country.code as country_code,
		operator.name as operator_name
    from wso2_appilication
    inner join country on country.id=wso2_appilication.country
	inner join operator on operator.id=wso2_appilication.operator
    where interface_id=in_interface_id;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_wso2_appilication_insert
DROP PROCEDURE IF EXISTS `goup_router_wso2_appilication_insert`;
DELIMITER //
CREATE  PROCEDURE `goup_router_wso2_appilication_insert`(
In in_name varchar(64) ,
In in_operator int(11) ,
In in_country int(11) ,
In in_interface_id int(16) ,
In in_host varchar(45) ,
In in_port varchar(45) ,
In in_version varchar(45),
IN in_auth_app_key varchar(64)
)
    COMMENT 'This procedure is used to insert wso2 appilication.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to insert wso2 appilication.
		Created On  :  27/08/2018
		Created By	:  Nimisha Mittal
		Modified On :  26/09/2018
		Changed Description: Check for wso2 application already exists or not
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   In in_name varchar(64) ,
						In in_operator int(11) ,
						In in_country int(11) ,
						In in_interface_id int(16) ,
						In in_host varchar(45) ,
						In in_port varchar(45) ,
						In in_version varchar(45),
						IN in_auth_app_key varchar(64)
		Output		:	Msg	
        
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
	-- get wso2 applications on the basis of country and operator
    drop temporary table if exists temp_wso2_appilication;
    create temporary table temp_wso2_appilication
    select * from wso2_appilication where operator=in_operator and country=in_country ;
    
   -- get wso2 applications on the basis of name and host address of wso2 application.
    drop temporary table if exists temp_wso2_appilication_name;
    create temporary table temp_wso2_appilication_name
    select * from temp_wso2_appilication where name=in_name or host=in_host ;
    
    -- Check if wso2 application already exists.
    if (select count(id) from temp_wso2_appilication_name)=0 then 
		insert into wso2_appilication
		(
		name,
		operator,
		country,
		interface_id,
		host,
		port,
		version,
		auth_app_key
		)
		VALUES
		(
		in_name  ,
		in_operator  ,
		in_country ,
		in_interface_id ,
		in_host  ,
		in_port  ,
		in_version ,
		in_auth_app_key
		);
        -- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isWso2AppilicationInserted",1,temp_lang_code));			
		SELECT @msg AS msg;
	else
		-- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isWso2AppilicationExists",1,temp_lang_code));			
		SELECT @msg AS msg;
    end if;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_router_wso2_appilication_update
DROP PROCEDURE IF EXISTS `goup_router_wso2_appilication_update`;
DELIMITER //
CREATE  PROCEDURE `goup_router_wso2_appilication_update`(
In in_id int(16),
In in_name varchar(64) ,
In in_operator int(11) ,
In in_country int(11) ,
In in_interface_id int(16) ,
In in_host varchar(45) ,
In in_port varchar(45) ,
In in_version varchar(45),
IN in_auth_app_key varchar(64)
)
    COMMENT 'This procedure is used to update wso2 appilication.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to update wso2 appilication.
		Created On  :  27/08/2018
		Created By	:  Nimisha Mittal
        Modified On :   26/09/2018
	    Changed description : Check for wso2 application already exists or not
		----------------------------------------------------------------------------------------------------------------
		Inputs		:   In in_id int(16),
						In in_name varchar(64) ,
						In in_operator int(11) ,
						In in_country int(11) ,
						In in_interface_id int(16) ,
						In in_host varchar(45) ,
						In in_port varchar(45) ,
						In in_version varchar(45)
		Output		:	Msg	
        
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
        
	 -- get wso2 applications on the basis of name and host address
    drop temporary table if exists temp_wso2_appilication;
    create temporary table temp_wso2_appilication
    select * from wso2_appilication where name=in_name or host=in_host;
    
    -- Check if wso2 application already exists.
    if (select count(id) from temp_wso2_appilication where id!=in_id)=0 then 
		update wso2_appilication
		set
			name=in_name,
			operator=in_operator,
			country=in_country,
			interface_id=in_interface_id,
			host=in_host,
			port=in_port,
			version=in_version,
			auth_app_key=in_auth_app_key
		where id=in_id;
        -- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isWso2AppilicationUpdated",1,temp_lang_code));			
		SELECT @msg AS msg;
	else
		-- Get Message From messages table
		SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isWso2AppilicationExists",1,temp_lang_code));			
		SELECT @msg AS msg;
	end if;
end//
DELIMITER ;

-- Dumping structure for procedure goup_router.goup_tracking_message_header_insert
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

-- Dumping structure for function goup_router.goup_utility_ordered_uuid
DROP FUNCTION IF EXISTS `goup_utility_ordered_uuid`;
DELIMITER //
CREATE  FUNCTION `goup_utility_ordered_uuid`(`uuid` BINARY(36)) RETURNS binary(16)
    DETERMINISTIC
    COMMENT 'Converts uuid into binary format'
RETURN UNHEX(CONCAT(SUBSTR(uuid, 15, 4),SUBSTR(uuid, 10, 4),SUBSTR(uuid, 1, 8),SUBSTR(uuid, 20, 4),SUBSTR(uuid, 25)))//
DELIMITER ;

-- Dumping structure for table goup_router.interfaces
DROP TABLE IF EXISTS `interfaces`;
CREATE TABLE IF NOT EXISTS `interfaces` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `name` varchar(256) DEFAULT NULL COMMENT 'name of application (interfaces)',
  `mysql_host` varchar(64) DEFAULT NULL COMMENT 'host address of db ',
  `mysql_port` varchar(64) DEFAULT NULL COMMENT 'port of db server',
  `mysql_username` varchar(64) DEFAULT NULL COMMENT 'username  of db ',
  `mysql_password` varchar(64) DEFAULT NULL COMMENT 'password of db',
  `mysql_password_salt` varchar(64) DEFAULT NULL COMMENT 'salt of password',
  `version` varchar(45) DEFAULT NULL COMMENT 'version of interfaces',
  `database_name` varchar(256) DEFAULT NULL COMMENT 'name of database',
  `thirdparty_database_name` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This table is used to store details of application and mysql connection string';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.language
DROP TABLE IF EXISTS `language`;
CREATE TABLE IF NOT EXISTS `language` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(20) NOT NULL,
  `description` varchar(20) DEFAULT NULL,
  `is_default` tinyint(4) NOT NULL,
  `code` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.
-- Dumping structure for table goup_router.log_audit
DROP TABLE IF EXISTS `log_audit`;
CREATE TABLE IF NOT EXISTS `log_audit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto-Incremented ID',
  `tracking_message_header` varchar(256) DEFAULT NULL COMMENT 'request id',
  `input_parameters` text COMMENT 'Input in the api',
  `ip_address` varchar(45) DEFAULT NULL COMMENT 'Ip address of the device',
  `start_time` int(16) DEFAULT NULL COMMENT 'Time at which api was called',
  `url_accessed` varchar(256) DEFAULT NULL COMMENT 'Url api accesed',
  `api_name` varchar(256) DEFAULT NULL COMMENT 'name of api',
  `api_type` varchar(64) DEFAULT NULL COMMENT 'type of api called',
  `is_header` text COMMENT '1 if parameter is header else 0',
  `message` text COMMENT 'message ',
  `is_successful` tinyint(16) DEFAULT NULL COMMENT 'call is successfull or not',
  `api_response` text COMMENT 'response of api',
  `target_api_name` varchar(256) CHARACTER SET latin7 COLLATE latin7_estonian_cs DEFAULT NULL COMMENT 'target api name',
  `end_time` int(16) DEFAULT NULL COMMENT 'time at which api call finished',
  `logtype` varchar(45) DEFAULT NULL COMMENT 'error/exception',
  `country` varchar(45) DEFAULT NULL,
  `operator` varchar(45) DEFAULT NULL,
  `country_id` int(16) DEFAULT NULL,
  `operator_id` int(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This table will contain the audit_log of the api''s called and views accessed';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.messages
DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter` varchar(256) DEFAULT NULL,
  `value` tinyint(4) DEFAULT NULL,
  `code` int(11) DEFAULT NULL,
  `message` varchar(256) DEFAULT NULL,
  `language_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Contains the messages and code for the various operations.\n';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.operator
DROP TABLE IF EXISTS `operator`;
CREATE TABLE IF NOT EXISTS `operator` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `name` varchar(45) DEFAULT NULL COMMENT 'name of operator',
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This table is used to store details of operator/mno';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.operator_interface
DROP TABLE IF EXISTS `operator_interface`;
CREATE TABLE IF NOT EXISTS `operator_interface` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `operator_id` int(16) DEFAULT NULL COMMENT 'belongs to which operator',
  `interface_id` int(16) DEFAULT NULL COMMENT 'belongs to which interface',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This table is used to store mapping of operator and  interface';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.report_header_mapping
DROP TABLE IF EXISTS `report_header_mapping`;
CREATE TABLE IF NOT EXISTS `report_header_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremeneted id',
  `column_names` text COMMENT 'name of column',
  `report_api_url` text COMMENT 'report api url',
  `column_type` text COMMENT 'type of column',
  `column_alias` text COMMENT 'alias of column',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='this table is used to store details of report header';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.sim_donor_identfiers
DROP TABLE IF EXISTS `sim_donor_identfiers`;
CREATE TABLE IF NOT EXISTS `sim_donor_identfiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `name` varchar(256) DEFAULT NULL COMMENT 'name if unique sim id Such as iccid,ban,imsi etc',
  `sim_identfier_bin` binary(16) DEFAULT NULL COMMENT 'belongs to which unique identifier',
  `sim_id` varchar(256) DEFAULT NULL COMMENT 'value of sim identifier',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This is OEM ''s unique mapping of unique sime identifier with  sim id ';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.sim_home_identifiers
DROP TABLE IF EXISTS `sim_home_identifiers`;
CREATE TABLE IF NOT EXISTS `sim_home_identifiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `name` varchar(256) DEFAULT NULL COMMENT 'name if unique sim id Such as iccid,ban,imsi etc',
  `sim_identfier_bin` binary(16) DEFAULT NULL COMMENT 'belongs to which unique identifier',
  `sim_id` varchar(256) DEFAULT NULL COMMENT 'value of sim identifier',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This is  unique mapping of unique sime identifier with  sim id  bss';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.sim_map
DROP TABLE IF EXISTS `sim_map`;
CREATE TABLE IF NOT EXISTS `sim_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `sim_identfier` varchar(50) DEFAULT NULL COMMENT 'standard unique identifier',
  `sim_identfier_bin` binary(16) DEFAULT NULL COMMENT 'binary format of standard unique identifier',
  `wso2_appilication_id` int(16) DEFAULT NULL,
  `sim_uid` varchar(64) DEFAULT NULL COMMENT 'used to store unique sim id ',
  `file_id` int(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wso2_appilication_id_20180821_idx` (`wso2_appilication_id`),
  CONSTRAINT `fk_wso2_appilication_id_20180821` FOREIGN KEY (`wso2_appilication_id`) REFERENCES `wso2_appilication` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This table is used to create unique identifier .';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.sim_map_history
DROP TABLE IF EXISTS `sim_map_history`;
CREATE TABLE IF NOT EXISTS `sim_map_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `sim_identfier` varchar(20) DEFAULT NULL COMMENT 'standard unique identifier',
  `sim_identfier_bin` binary(16) DEFAULT NULL COMMENT 'binary format of standard unique identifier',
  `wso2_appilication_id` int(16) DEFAULT NULL,
  `sim_uid` varchar(64) DEFAULT NULL COMMENT 'used to store unique sim id ',
  `file_id` int(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wso2_appilication_id_201808211130_idx` (`wso2_appilication_id`),
  CONSTRAINT `fk_wso2_appilication_id_201808211130` FOREIGN KEY (`wso2_appilication_id`) REFERENCES `wso2_appilication` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This table is used to create history of unique identifier .';

-- Data exporting was unselected.
-- Dumping structure for table goup_router.status
DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL,
  `message` varchar(255) CHARACTER SET utf16 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.
-- Dumping structure for table goup_router.tracking_message_header
DROP TABLE IF EXISTS `tracking_message_header`;
CREATE TABLE IF NOT EXISTS `tracking_message_header` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tracking_message_header` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tracking_msg_header` (`tracking_message_header`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This table is used to store tracking message header';


-- Dumping structure for table goup_router.wso2_appilication
DROP TABLE IF EXISTS `wso2_appilication`;
CREATE TABLE IF NOT EXISTS `wso2_appilication` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented id',
  `name` varchar(64) DEFAULT NULL COMMENT 'name of interface',
  `operator` int(11) DEFAULT NULL COMMENT 'interface belongs to which operator',
  `country` int(11) DEFAULT NULL COMMENT 'interface belongs to which country',
  `interface_id` int(16) DEFAULT NULL COMMENT 'interface belongs to which application',
  `host` varchar(45) DEFAULT NULL COMMENT 'host address of wso2 ',
  `port` varchar(45) DEFAULT NULL COMMENT 'port',
  `version` varchar(45) DEFAULT NULL COMMENT 'version of platform',
  `auth_app_key` varchar(64) DEFAULT NULL COMMENT 'auth application key',
  PRIMARY KEY (`id`),
  KEY `fk_country_idx` (`country`),
  KEY `fk_operator_idx` (`operator`),
  KEY `fk_interface_id201808211120_idx` (`interface_id`),
  CONSTRAINT `fk_country` FOREIGN KEY (`country`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_interface_id201808211120` FOREIGN KEY (`interface_id`) REFERENCES `interfaces` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_operator` FOREIGN KEY (`operator`) REFERENCES `operator` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='This table is used to store details of operator interface  on the basis of country and operator';

-- Data exporting was unselected.
-- Dumping structure for view goup_router.vw_wso2_appilication_details
DROP VIEW IF EXISTS `vw_wso2_appilication_details`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_wso2_appilication_details`;
CREATE VIEW `vw_wso2_appilication_details` AS select `sim_map`.`id` AS `sim_map_id`,`sim_map`.`sim_identfier` AS `sim_identfier`,`sim_map`.`sim_identfier_bin` AS `sim_identfier_bin`,`sim_map`.`wso2_appilication_id` AS `sim_map_wso2_appilication_id`,`sim_map`.`sim_uid` AS `sim_map_sim_uid`,`wso2_appilication`.`id` AS `wso2_appilication_id`,`wso2_appilication`.`name` AS `wso2_appilication_name`,`wso2_appilication`.`operator` AS `wso2_appilication_operator_id`,`wso2_appilication`.`country` AS `wso2_appilication_country_id`,`wso2_appilication`.`host` AS `wso2_appilication_host`,`wso2_appilication`.`version` AS `wso2_appilication_version`,`wso2_appilication`.`port` AS `wso2_appilication_port`,`wso2_appilication`.`auth_app_key` AS `wso2_appilication_auth_app_key`,`sim_donor_identfiers`.`id` AS `sim_donor_identfiers_id`,`sim_donor_identfiers`.`name` AS `sim_donor_identfiers_name`,`sim_donor_identfiers`.`sim_identfier_bin` AS `sim_donor_identfiers_sim_identfier_bin`,`sim_donor_identfiers`.`sim_id` AS `sim_donor_identfiers_sim_id`,`sim_home_identifiers`.`id` AS `sim_home_identfiers_id`,`sim_home_identifiers`.`name` AS `sim_home_identfiers_name`,`sim_home_identifiers`.`sim_identfier_bin` AS `sim_home_identfiers_sim_identfier_bin`,`sim_home_identifiers`.`sim_id` AS `sim_home_identfiers_sim_id`,`country`.`name` AS `country_name`,`country`.`code` AS `country_code`,`operator`.`name` AS `operator_name`,`interfaces`.`id` AS `interfaces_id`,`interfaces`.`name` AS `interfaces_name`,`interfaces`.`mysql_host` AS `mysql_host`,`interfaces`.`mysql_port` AS `mysql_port`,`interfaces`.`mysql_username` AS `mysql_username`,`interfaces`.`mysql_password` AS `mysql_password`,`interfaces`.`mysql_password_salt` AS `mysql_password_salt`,`interfaces`.`version` AS `interfaces_version`,`interfaces`.`database_name` AS `database_name` from ((((((`sim_map` join `wso2_appilication` on((`sim_map`.`wso2_appilication_id` = `wso2_appilication`.`id`))) left join `sim_home_identifiers` on((`sim_map`.`sim_identfier_bin` = `sim_home_identifiers`.`sim_identfier_bin`))) left join `sim_donor_identfiers` on((`sim_map`.`sim_identfier_bin` = `sim_donor_identfiers`.`sim_identfier_bin`))) join `operator` on((`operator`.`id` = `wso2_appilication`.`operator`))) join `country` on((`country`.`id` = `wso2_appilication`.`country`))) join `interfaces` on((`interfaces`.`id` = `wso2_appilication`.`interface_id`)));

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
