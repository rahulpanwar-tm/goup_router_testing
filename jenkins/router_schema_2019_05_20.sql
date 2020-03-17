USE goup_router;

drop procedure if exists goup_router_sim_inventory_bulk_insert;
delimiter &&
CREATE PROCEDURE `goup_router_sim_inventory_bulk_insert`(
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
        Description	:  inserted data into error table
		Modified On  : 20/05/2019
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


	-- insert data into bulk upload sim inventory errors
		INSERT INTO `bulk_upload_sim_inventory_errors`
		(`wso2_appilication_name`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,`remark`,is_faulty)
		select `wso2_appilication_id`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,'Inserted data',0
		from temp_bulk_upload_identifiers_data where hdsim_id is null ;
        
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

		-- insert data into bulk upload sim inventory errors
		INSERT INTO `bulk_upload_sim_inventory_errors`
		(`wso2_appilication_name`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,`remark`,is_faulty)
		select wso2_appilication_id,sim_uid,name,sim_id,type,file_id,'Already exists',1
		from temp_final_generted_data where sim_uid not in (select file_id from temp_bulk_upload_sim_inventory);
        

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
end &&
delimiter ;


USE goup_router;
DROP procedure IF EXISTS `goup_router_operator_delete`;
DELIMITER $$
CREATE PROCEDURE `goup_router_operator_delete`(
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
        
        if(in_id=(select operator from wso2_appilication where interface_id=in_interface_id and operator=in_id)) then 
			-- select 'Operator is linked with application.First delete that.' as msg;
            SET @catchArbitrary=(SELECT goup_message_by_parameter_and_langauge_code("isWso2OperatorLinked",1,temp_lang_code));			
			SELECT @msg AS msg ;
		else
        
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
	end if;
END$$

DELIMITER ;

INSERT INTO `messages` (`parameter`, `value`, `code`, `message`, `language_id`) VALUES ('isWso2OperatorLinked', '1', '70', 'Operator is linked with application.First delete that.', '1');
INSERT INTO `messages` (`parameter`, `value`, `code`, `message`, `language_id`) VALUES ('isWso2OperatorLinked', '1', '70', '运算符与application.First删除。', '2');
