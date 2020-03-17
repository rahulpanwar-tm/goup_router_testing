USE goup_router;
--
-- Inserting data into table messages
--
INSERT INTO messages(id, parameter, value, code, message, language_id) VALUES
(79, 'isSimUserIdentifierInserted', 1, NULL, 'Sim user identifier is inserted', 1),
(80, 'isSimUserIdentifierInserted', 0, NULL, 'Sim user identifier is not inserted', 1),
(84, 'isIdentifierSwapped', 1, 71, 'Identifier successfully swapped', 1),
(85, 'isIdentifierSwapped', 0, 71, 'Identifier already exists', 1),
(86, 'isPreviousImsiExists', 0, 72, 'Previous Imsi does not exists', 1),
(87, 'isCurrentImsiExists', 0, 72, 'Current Imsi does not exists', 1),
(88, 'isPreviousImsiExists', 0, 72, '以前的Imsi不存在', 2),
(89, 'isCurrentImsiExists', 0, 72, '当前的Imsi不存在', 2),
(90, 'isIdentifierSwapped', 1, 71, '标识符已成功交换', 2),
(91, 'isIdentifierSwapped', 0, 71, '标识符已存在', 2),
(92, 'isPreviousUserIdentifierExists', 0, 73, 'Previous user identifier does not exists', 1),
(93, 'isPreviousUserIdentifierExists', 0, 73, '先前的使用者识别码不存在', 2),
(94, 'isCurrentUserIdentifierExists', 1, 74, 'Current user identifier already exists', 1),
(95, 'isCurrentUserIdentifierExists', 1, 74, '当前用户标识符已经存在', 2);




-- Dumping structure for procedure development_goup_router.goup_router_sim_identifier_swap_by_imsi
DROP PROCEDURE IF EXISTS `goup_router_sim_identifier_swap_by_imsi`;
DELIMITER //
CREATE PROCEDURE `goup_router_sim_identifier_swap_by_imsi`(
	IN `in_previous_imsi` varchar(256),
    IN `in_current_imsi` varchar(256)
)
    COMMENT 'This procedure is used to swap user identifier detials.'
BEGIN
	/*
		----------------------------------------------------------------------------------------------------------------
		Description	:  This procedure is used to insert sim user identifier details into new imsi and delete the identifier
						details from previous imsi.
		Created On  :  20 Feb 2020
		Created By	:  Saurabh kumar
		----------------------------------------------------------------------------------------------------------------
		Inputs		: IN in_previous_imsi
					: IN in_current_imsi
		----------------------------------------------------------------------------------------------------------------
        Output		:	Message of successfull insertion
        ----------------------------------------------------------------------------------------------------------------
	*/
		-- temporary variable for localization concept
        DECLARE catchAribitrary BOOLEAN; 
		DECLARE in_lang_code INT ;
		DECLARE temp_default_lang_code INT;
		DECLARE temp_lang_code INT ;
        
        -- temporary variables to store the previous and current identifier bin
        DECLARE previous_temp_sim_identifier_bin binary(16);
        DECLARE current_temp_sim_identifier_bin binary(16);
		DECLARE previous_temp_identifier_value varchar(256);
		SET in_lang_code=null;
        SET temp_default_lang_code=(SELECT code FROM language WHERE is_default=1);
        SET temp_lang_code=(SELECT COALESCE(in_lang_code , temp_default_lang_code));
        
        -- temporary variables to store the identifier bin for previous and new 
        SET previous_temp_sim_identifier_bin = (select sim_identfier_bin from sim_home_identifiers where `name`= 'imsi' and sim_id = in_previous_imsi LIMIT 1);
        SET current_temp_sim_identifier_bin = (select sim_identfier_bin from sim_home_identifiers where `name`= 'imsi' and sim_id = in_current_imsi LIMIT 1);
        SET previous_temp_identifier_value = (select sim_id from sim_home_identifiers where `name`= 'useridentifier' and sim_identfier_bin = previous_temp_sim_identifier_bin LIMIT 1);
        
        -- checking the presence of previous imsi
        IF(select count(*) from sim_home_identifiers where `name`= 'imsi' and sim_identfier_bin = previous_temp_sim_identifier_bin) < 1 THEN	
			
            -- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isPreviousImsiExists",0,temp_lang_code));			
			SELECT @msg AS description,-1 as response_code;
            
		-- checking the presence of current imsi
        ELSEIF(select count(*) from sim_home_identifiers where `name`= 'imsi' and sim_identfier_bin = current_temp_sim_identifier_bin) < 1 THEN

			-- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isCurrentImsiExists",0,temp_lang_code));			
			SELECT @msg AS description,-1 as response_code;
            
		-- checking the presence of user identifier in previous imsi
        ELSEIF(select count(*) from sim_home_identifiers where `name`= 'useridentifier' and sim_identfier_bin = previous_temp_sim_identifier_bin) < 1 THEN	
			
            -- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isPreviousUserIdentifierExists",0,temp_lang_code));			
			SELECT @msg AS description,-1 as response_code;
            
        -- checking the presence of user identifier in current imsi    
		 ELSEIF(select count(*) from sim_home_identifiers where `name`= 'useridentifier' and sim_identfier_bin = current_temp_sim_identifier_bin) < 1 THEN	
	         
             -- insert data into sim home identifiers
			INSERT INTO sim_home_identifiers
				(
				`name`,
				`sim_identfier_bin`,
				`sim_id`
                )
                values
                (
                'useridentifier',
                current_temp_sim_identifier_bin,
                previous_temp_identifier_value
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
                'useridentifier',
                current_temp_sim_identifier_bin,
                previous_temp_identifier_value
                );
               
			-- delete identifer from sim home identifiers for previous imsi
				DELETE FROM sim_home_identifiers WHERE `name` = 'useridentifier' and sim_identfier_bin = previous_temp_sim_identifier_bin;
                
			-- delete identifer from sim home identifiers for previous imsi
				DELETE FROM sim_donor_identfiers WHERE `name` = 'useridentifier' and sim_identfier_bin = previous_temp_sim_identifier_bin;
              
            -- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isIdentifierSwapped",1,temp_lang_code));			
			SELECT @msg AS description,1 as response_code;
        
        
		ELSE
			-- Get Message From messages table
			SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isIdentifierSwapped",0,temp_lang_code));			
			SELECT @msg AS description,500 as response_code;
		END IF;
end//
DELIMITER ;

