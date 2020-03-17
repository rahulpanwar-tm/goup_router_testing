USE goup_router;

DROP PROCEDURE IF EXISTS goup_router_sim_identifier_insert;

DELIMITER $$
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
        Modified On	:	27 Dec 2019
        Modifid by	:	Saurabh kumar
        Modification :	Removed the harcoded value of userIdentifier and replaced it with in_identifier_name
        ---------------------------------------------------------------------------------------------------------------
        Modified On	:	26 Feb 2020
        Modified By	:	Saurabh kumar
        Modification :	If user identifier is already present , then no need of insertion
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
        IF(select count(*) from sim_home_identifiers where `name`= in_identifier_name and sim_identfier_bin = temp_sim_identfier_bin) < 1 THEN
			
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
                in_identifier_name,
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
end$$
DELIMITER ;
