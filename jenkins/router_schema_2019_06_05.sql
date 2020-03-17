USE goup_router; 
INSERT INTO `sim_donor_identfiers` (`name`, `sim_id`) VALUES ('iccid', '894627004440016582');
INSERT INTO `sim_donor_identfiers` (`name`, `sim_id`) VALUES ('imsi', '530054444981132');


INSERT INTO `sim_home_identifiers` (`name`, `sim_id`) VALUES ('iccid', '894627004440016582');
INSERT INTO `sim_home_identifiers` (`name`, `sim_id`) VALUES ('imsi', '530054444981132');
INSERT INTO `sim_map` (`sim_identfier`, `wso2_appilication_id`, `sim_uid`) VALUES ('a2ea353a-86cd-11e9-ae85-aaad5efe4dc2', '21', '53');


update sim_home_identifiers set sim_identfier_bin=(select goup_utility_ordered_uuid('a2ea353a-86cd-11e9-ae85-aaad5efe4dc2')) 
where  id IN (148,149);

update sim_donor_identfiers set sim_identfier_bin=(select goup_utility_ordered_uuid('a2ea353a-86cd-11e9-ae85-aaad5efe4dc2')) 
where  id IN (148,149);


update sim_map set sim_identfier_bin=(select goup_utility_ordered_uuid('a2ea353a-86cd-11e9-ae85-aaad5efe4dc2')) 
where  sim_identfier='a2ea353a-86cd-11e9-ae85-aaad5efe4dc2';


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
        Description	:  handle duplicate data
		Modified On  : 31/05/2019
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
        
      if(SELECT count(sim_id) FROM bulk_upload_sim_inventory where file_id=in_file_id group by sim_id,type,sim_uid having count(sim_id) >1 limit 1 ) >0
        then 
        SELECT status,message FROM status WHERE status=6;
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
		

		drop temporary table if exists temp_bulk_upload_home_identifiers_existance;
		create temporary table temp_bulk_upload_home_identifiers_existance
		select temp_bulk_upload_sim_uid.*,sim_home_identifiers.sim_id as hdsim_id from temp_bulk_upload_sim_uid 
		left join sim_home_identifiers on temp_bulk_upload_sim_uid.sim_id=sim_home_identifiers.sim_id
        and temp_bulk_upload_sim_uid.name= `sim_home_identifiers`.`name`
        where temp_bulk_upload_sim_uid.sim_identfier is not null;


		drop temporary table if exists temp_bulk_upload_donor_identfiers_existance;
		create temporary table temp_bulk_upload_donor_identfiers_existance
		select temp_bulk_upload_sim_uid.*,sim_donor_identfiers.sim_id as hdsim_id from temp_bulk_upload_sim_uid 
		left join sim_donor_identfiers on temp_bulk_upload_sim_uid.sim_id=sim_donor_identfiers.sim_id
        and temp_bulk_upload_sim_uid.name=`sim_donor_identfiers`.`name`
        where temp_bulk_upload_sim_uid.sim_identfier is not null;

		drop temporary table if exists temp_bulk_upload_identifiers_data_existance;
		create temporary table temp_bulk_upload_identifiers_data_existance 
		select * from temp_bulk_upload_home_identifiers_existance
		union
		select * from temp_bulk_upload_donor_identfiers_existance;


		-- insert data into bulk upload sim inventory errors
		INSERT INTO `bulk_upload_sim_inventory_errors`
		(`wso2_appilication_name`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,`remark`,is_faulty)
		select `wso2_appilication_id`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,'Name or sim id already exists',1
		from temp_bulk_upload_identifiers_data_existance where hdsim_id is null ;

		-- insert data into bulk upload sim inventory errors
		INSERT INTO `bulk_upload_sim_inventory_errors`
		(`wso2_appilication_name`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,`remark`,is_faulty)
		select `wso2_appilication_id`,`sim_uid`,`name`,`sim_id`,`type`,`file_id`,'Name or sim id already exists',1
		from temp_bulk_upload_identifiers_data_existance where hdsim_id is not  null ;

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
		select name,`binlog`,sim_id from temp_final_generted_data where `type`='home' or `type`='Home' group by sim_uid,lcase(`name`),sim_id ;
		
		-- insert data into sim donor identifiers
		insert into sim_donor_identfiers (name,sim_identfier_bin,sim_id) 
		select name,`binlog`,sim_id from temp_final_generted_data where `type`='donor' or `type`='Donor' group by sim_uid,lcase(`name`),sim_id ;


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
end if;
end &&
delimiter ;