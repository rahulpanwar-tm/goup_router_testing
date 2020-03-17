USE goup_router;
-- Dumping structure for procedure development_goup_router.goup_router_get_auth_application_key
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
        Modified On	:	7 Aug 2019
        Modified By	:	Saurabh kumar
        Modification:	Combination of in_identifier and in_identifier_value to be check for ICCID and IMSI and its sim_id
						to be checked
        ----------------------------------------------------------------------------------------------------------------
	*/
	
		set @temp_unique_identifier:=(select sim_identfier_bin from sim_map where sim_identfier = in_identifier_value);
		set @temp_home_identifiers:=(select sim_identfier_bin from sim_home_identifiers where upper(in_identifier) = UPPER(name) and sim_id=in_identifier_value );
		set @temp_donor_identifiers:=(select sim_identfier_bin from sim_donor_identfiers where upper(in_identifier) = UPPER(name) and sim_id=in_identifier_value);

		set @temp_sim_id_bin:=(select coalesce(@temp_unique_identifier,@temp_home_identifiers,@temp_donor_identifiers)) ;

	    -- Check if all parameters are null
	    if(in_identifier is null and  in_identifier_value is null ) then 
			select auth_app_key as wso2_appilication_auth_app_key from wso2_appilication where id in (select wso2_appilication_id from sim_map where sim_identfier_bin=@temp_sim_id_bin) and false;
	    else
			 select auth_app_key as wso2_appilication_auth_app_key from wso2_appilication where id in (select wso2_appilication_id from sim_map where sim_identfier_bin=@temp_sim_id_bin);
	    end if;
end//
DELIMITER ;