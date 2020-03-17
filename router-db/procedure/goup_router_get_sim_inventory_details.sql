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

-- Dumping structure for procedure development_goup_router.goup_router_get_sim_inventory_details
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

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
