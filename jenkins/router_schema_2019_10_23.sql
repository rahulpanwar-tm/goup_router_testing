USE goup_router;

INSERT INTO `messages` (`parameter`, `value`, `message`, `language_id`) VALUES ( 'isSimUserIdentifierDeleted', '0', 'Sim user identifier is not deleted', '1');
INSERT INTO `messages` (`parameter`, `value`, `message`, `language_id`) VALUES ( 'isSimUserIdentifierDeleted', '1', 'Sim user identifier is deleted', '1');
INSERT INTO `messages` (`parameter`, `value`, `message`, `language_id`) VALUES ( 'isSimUserIdentifierInserted', '1', 'Sim user identifier is inserted', '1');
INSERT INTO `messages` (`parameter`, `value`, `message`, `language_id`) VALUES ( 'isSimUserIdentifierInserted', '0', 'Sim user identifier is not inserted', '1');


-- Dumping structure for procedure development_goup_router.goup_router_sim_identifier_insert
DROP PROCEDURE IF EXISTS `goup_router_sim_identifier_insert`;
DELIMITER //
CREATE  PROCEDURE `goup_router_sim_identifier_insert`(
	IN `in_name` varchar(30),
    IN `in_sim_id` varchar(256),
	IN `in_identifier_name` varchar(30),
    IN `in_identifier_value` varchar(256)

)
    COMMENT 'This procedure is used to insert sim identifier details.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to insert sim user identifier details.
		Created On  :  22 Oct 2019
		Created By	:  Saurabh kumar
		----------------------------------------------------------------------------------------------------------------
		Inputs		: IN in_identifier_name
					: IN in_identifier_value
		----------------------------------------------------------------------------------------------------------------
        Output		:	Message of successfull insertion
        ----------------------------------------------------------------------------------------------------------------
	*/
		-- temporary variable for localization concept
        DECLARE catchAribitrary BOOLEAN; 
		DECLARE in_lang_code INT ;
		DECLARE temp_default_lang_code INT;
		DECLARE temp_lang_code INT ;
        DECLARE temp_sim_identfier_bin binary(16);

		SET in_lang_code=null;
        SET temp_default_lang_code=(SELECT code FROM language WHERE is_default=1);
        SET temp_lang_code=(SELECT COALESCE(in_lang_code , temp_default_lang_code));
        
        SET temp_sim_identfier_bin = (select sim_identfier_bin from sim_home_identifiers where `name`= in_name and sim_id = in_sim_id LIMIT 1);
        
        -- checking the presence of user identifier for given imsi/iccid
        IF(select count(*) from sim_home_identifiers where `name`= in_identifier_name and sim_id = in_identifier_value) < 1 THEN
			
			-- insert data into sim home identifiers
			INSERT INTO sim_home_identifiers
				(
				`name`,
				`sim_identfier_bin`,
				`sim_id`
                )
                values
                (
                in_identifier_name,
                temp_sim_identfier_bin,
                in_identifier_value
                );
                
			
			-- insert data into sim donor identifiers
				INSERT INTO sim_donor_identfiers
				(
				`name`,
				`sim_identfier_bin`,
				`sim_id`
                )
                values
                (
                'userIdentifier',
                temp_sim_identfier_bin,
                in_identifier_value
                );
			
			-- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isSimUserIdentifierInserted",1,temp_lang_code));			
			SELECT @msg AS description,200 as response_code;
        
		ELSE
			-- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isSimUserIdentifierInserted",0,temp_lang_code));			
			SELECT @msg AS description,500 as response_code;
		END IF;
end//
DELIMITER ;


-- Dumping structure for procedure development_goup_router.goup_router_sim_user_identifier_delete
DROP PROCEDURE IF EXISTS `goup_router_sim_user_identifier_delete`;
DELIMITER //
CREATE  PROCEDURE `goup_router_sim_user_identifier_delete`(
	IN `in_identifier_name` varchar(30),
    IN `in_identifier_value` varchar(256)

)
    COMMENT 'This procedure is used to delete sim identifier details.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to delete sim user identifier details.
		Created On  :  21 Oct 2019
		Created By	:  Saurabh kumar
		----------------------------------------------------------------------------------------------------------------
		Inputs		: IN in_identifier_name
					: IN in_identifier_value
		----------------------------------------------------------------------------------------------------------------
        Output		:	Message of successfull deletion
        ----------------------------------------------------------------------------------------------------------------
	*/
		-- temporary variable for localization concept
        DECLARE catchAribitrary BOOLEAN; 
		DECLARE in_lang_code INT ;
		DECLARE temp_default_lang_code INT;
		DECLARE temp_lang_code INT ;
        DECLARE temp_sim_identfier_bin binary(16);

		SET in_lang_code=null;
        SET temp_default_lang_code=(SELECT code FROM language WHERE is_default=1);
        SET temp_lang_code=(SELECT COALESCE(in_lang_code , temp_default_lang_code));
        
        SET temp_sim_identfier_bin = (select sim_identfier_bin from sim_home_identifiers where `name`= in_identifier_name and sim_id = in_identifier_value LIMIT 1);
        
        -- checking the presence of user identifier for given imsi/iccid
        IF(select count(*) from sim_home_identifiers where `name`= 'userIdentifier' and temp_sim_identfier_bin = sim_identfier_bin) > 0 THEN
			
			-- delete data from sim home identifiers
			delete from sim_home_identifiers where `name`= 'userIdentifier' and sim_identfier_bin = temp_sim_identfier_bin;
			
			-- delete data from sim donor identifiers
			delete from sim_donor_identfiers where  `name`= 'userIdentifier' and sim_identfier_bin = temp_sim_identfier_bin;
			
			-- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isSimUserIdentifierDeleted",1,temp_lang_code));			
			SELECT @msg AS description,200 as response_code;
        
		ELSE
			-- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isSimUserIdentifierDeleted",0,temp_lang_code));			
			SELECT @msg AS description,500 as response_code;
		END IF;
end//
DELIMITER ;




