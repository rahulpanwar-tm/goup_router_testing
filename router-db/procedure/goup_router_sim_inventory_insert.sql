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

-- Dumping structure for procedure development_goup_router.goup_router_sim_inventory_insert
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

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
