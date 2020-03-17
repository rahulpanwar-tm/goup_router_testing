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

-- Dumping structure for procedure development_goup_router.goup_router_get_operator_interface_core
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

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
