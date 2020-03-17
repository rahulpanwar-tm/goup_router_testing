USE goup_router; 
INSERT INTO `sim_donor_identfiers` (`name`, `sim_id`) VALUES ('iccid', '894420001278960006');
INSERT INTO `sim_donor_identfiers` (`name`, `sim_id`) VALUES ('imsi', '234206210060006');


INSERT INTO `sim_home_identifiers` (`name`, `sim_id`) VALUES ('iccid', '894420001278960006');
INSERT INTO `sim_home_identifiers` (`name`, `sim_id`) VALUES ('imsi', '234206210060006');
INSERT INTO `sim_map` (`sim_identfier`, `wso2_appilication_id`, `sim_uid`) VALUES ('92a688c1-8146-11e9-86e5-aaad5efe4dc2', '21', '53');


update sim_home_identifiers set sim_identfier_bin=(select goup_utility_ordered_uuid('92a688c1-8146-11e9-86e5-aaad5efe4dc2')) 
where  id IN (146,147);

update sim_donor_identfiers set sim_identfier_bin=(select goup_utility_ordered_uuid('92a688c1-8146-11e9-86e5-aaad5efe4dc2')) 
where  id IN (146,147);


update sim_map set sim_identfier_bin=(select goup_utility_ordered_uuid('92a688c1-8146-11e9-86e5-aaad5efe4dc2')) 
where  sim_identfier='92a688c1-8146-11e9-86e5-aaad5efe4dc2';