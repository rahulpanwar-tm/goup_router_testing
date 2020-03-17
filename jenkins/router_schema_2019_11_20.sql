USE goup_router;
-- Insertion of rows for vodafone into interface db
INSERT INTO `interfaces` (`id`, `name`, `mysql_host`, `mysql_port`, `mysql_username`, `mysql_password`, `database_name`, `thirdparty_database_name`) VALUES ('30', 'Vodafone', '192.168.1.34', '3306', 'root', 'Ttpl@123', 'vodafone_testing_goup_interface', 'vodafone_testing_goup_interface_thirdparty');

-- Insertion of rows into operator table
INSERT INTO `operator` (`id`, `name`, `code`) VALUES ('13', 'Vodafone', 'Vodafone');

-- Insertion of mapping for vodafone
INSERT INTO `operator_interface` (`id`, `operator_id`, `interface_id`) VALUES ('41', '13', '30');

-- Insertion of rows into wso2 application
INSERT INTO `wso2_appilication` (`id`, `name`, `operator`, `country`, `interface_id`, `host`, `version`, `auth_app_key`) VALUES ('24', 'Vodafone-IN', '13', '101', '30', 'http://192.168.1.241:8280/Vodafone-IN/v1', 'v1', '883edc1a-0cf4-11e9-9b0d-fe984cc15272');


