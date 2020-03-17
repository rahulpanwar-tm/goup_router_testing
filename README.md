# goup-db-mysql

This repository  contains database schemas of the goup(MySQL 5.7) and installation documents. 


# Importing database to local server 

1. Download the SQL Scripts from repository.

2. Create databases for importing SQL Scripts
		
# Run command to load 

	mysql -u root -p goup_router_development < goup_router_development.sql
	mysql -u root -p goup_interface < `goup_interface`.sql

# Procedures and Tables
	+------------------------------------------------+---------------------------------------------------------------------------------------------------------+
	| TABLE_NAME               			 | TABLE_COMMENT                                                            
	+------------------------------------------------+---------------------------------------------------------------------------------------------------------+
	| api                     			 | this table is used to store data of api and token api                                                                        
	| api_group              			 | this table is used to store data of api groups                                                                               
	| api_input_parameters    			 | this table is used to store data of input parametes and their datatype and validation of that datatype  of an api            
	| api_response_parameters  			 | this table is used to store api's responce parameters                                                                        
	| api_template            			 | this table is used to perform transformation                                                                                 
	| audit_log               			 | this table is used to store data about audit log for each step weather that step is successful or not if not then why as msg 
	| audit_log_details       			 | this table is used to store data about audit log details for each step                                                       
	| country                 			 | List of countries                                                                                                            
	| error_codes             			 | this table is used to store error code                                                                                       
	| log_audit                			 | This table will contain the audit_log of the api's called and views accessed                       	                          
	| log_exception            			 | Contains exception logs                                                                                                      
	| node_address            			 | this table is used to store node address                                                                                     
	| nodes                   			 | This table is used to store end nodes                                                                                        
	| notification            			 | this table is used store data for notification to be generated for api in the sequence                                       
	| notification_template    			 | this table is used to store notification template records                                                                    
	| state                    			 | this table is used to store the data at each step's state as transformation,validation,notification                          
	| sys_config_kafka         			 | This table is used to store kafka configurations details                                                                       
	| sys_config_spark         			 | This table is use to store spark configuration details                                                                 
	| sys_config_topic         			 | This table is used to store topic details .                                                                            
	| sys_config_zookeeper     			 | This table is used to store zookeeper configuration details .                                                                   
	| token_management         			 | this table is used to store data of token of api                                                                             
	| users                    			 | store the details of Orchestration layer                                               
	+------------------------------------------------+----------------------------------------------------------------------------------------------------------+
	| VIEW_NAME                                  	 | VIEW_COMMENT                                                    
	+------------------------------------------------+------------------------------------------------------------------------
	| vw_api_details           		     	 | This is used to get all the api details with input parameter and response parameter.                                                                                                                        						 
	| vw_notification_template 		     	 | this is used to get all the notification and notification template                                                                                                                       							 
	| vw_system_config         		     	 | this is used to get all the system config details                                         
  	+------------------------------------------------+-------------------------------------------------------------------------------------------------------------
	| ROUTINE_NAME                               	 | ROUTINE_COMMENT                                                      
	+------------------------------------------------+------------------------------------------------------------------------------------------------------------
	| gmonstar_api_get_by_api_group_id               | This procedure is used to get all the api and their details on the basis of api_group_id                     
	| gmonstar_audit_log_get_by_tracking_message     | This procedure is used to get audit log and audit log details of by tracking_message_header.                 
	| gmonstar_audit_log_get_by_token                | This procedure is used to get audit log and audit log details on the basis of token.                         
	| gmonstar_audit_log_get_by_username             | This procedure is used to get audit log and audit log details on the basis of username.                      
	| gmonstar_audit_log_insert                      | This procedure is used to insert audit log and audit log details of api.                                     
	| gmonstar_is_user_valid                         | This procedure is used to check weather user is valid or not on the basis of username and password.          
	| gmonstar_notification_template_get             | This procedure is used to get notification template on the basis of api_group_id , api_id and response_code. 
	| gmonstar_system_config_get                     | This procedure is used to get all the system config details on the basis of topic type.                      
	| gmonstar_token_get                             | This procedure is used to get token by api_group_id and api_id and node_address_id                           
	| gmonstar_token_insert                          | This procedure is used to insert token for the api.                                                          
	| gmonstar_token_update                          | This procedure is used to update token details on the basis of api_group_id and api_id.                      
	| gmonstar_utility_string_split                  | A  Utility procedure. It helps to convert a C.S.V. into a single column table       
	| gmonstar_error_code_get_by_api_group_id        | This procedure is used to get all details of all error codes on the basis of api_group_id. 
	| gmonstar_notification_template_for_sync_api_get| This procedure is used to get notification template on the basis of api group id and api group type.
	+------------------------------------------------+-----------------------------------------------------------------------------------------------------+
	# Router DB Procedures and Tables
	+------------------------------------------------+----------------------------------------------------------------------------------------------------------+
	| TABLE_NAME               			 | TABLE_COMMENT                                                            
	+------------------------------------------------+-----------------------------------------------------------------------------------------------------------+
	| application                     		 | This table is used to store details of application and mysql connection string                                                                       
	| country              				 | This table is used to store country                                                                               
	| log_audit    					 | This table will contain the audit_log of the api's called and views accessed            
	| operator  			 		 | This table is used to store details of operator/mno                                                                        
	| operator_interface            		 | This table is used to store details of operator interface                                                                                  
	| sim_donor_identfiers             		 | This is OEM 's unique mapping of unique sime identifier with  sim id  
	| sim_home_identfiers       			 | This is  unique mapping of unique sime identifier with  sim id                                                       
	| sim_map                 			 | This table is used to create unique identifier .                                                     
	| sim_map_history             			 | This table is used to create history of unique identifier .                                                                                                                                                          
  	+-----------------------------------------------+--------------------------------------------------------------------------------------------------------------
	| ROUTINE_NAME                          	 | ROUTINE_COMMENT                                                      
	+-----------------------------------------------+---------------------------------------------------------------------------------------------------------------
	| goup_audit_log_get_by_request_id       	 | This procedure is used to get logs by request id.                    
	| goup_audit_log_insert    		 	 | This procedure is for creating Logs.              
	| goup_router_country_operator_update    	 | This procedure is used to update country and operator in profile switch condition.  
	| goup_router_get_operator_interface     	 | This procedure is used to get all details of sim identifier with operator interface.                                                                 
	+------------------------------------------------+-------------------------------------------------------------------------+
	| FUNCTION_NAME                          	 | FUNCTION_COMMENT                                                    
	+------------------------------------------------+------------------------------------------------------------------------
	| goup_utility_ordered_uuid		 	 | This function converts uuid into binary format
	+------------------------------------------------+----------------------------------------------------------------------
	|# Interface-third Party DB Procedures and Tables
	+------------------------------------------------+----------------------------------------------------------------------------------------------------------+
	| TABLE_NAME               			 | TABLE_COMMENT                                                            
	+------------------------------------------------+-----------------------------------------------------------------------------------------------------------+
	| goup_notification_url                     	 | This table is used to store details of request id along with return url                                                                                                                                     
	+------------------------------------------------+-------------------------------------------------------------------------------------------------------------
	| ROUTINE_NAME                               	 | ROUTINE_COMMENT                                                      
	+------------------------------------------------+------------------------------------------------------------------------------------------------------------
	| goup_delete_notification_url			|This procedure is used to delete notification url on the basis of request id or icci id or ban or unique sim identifier and api group name
	| goup_get_notification_url			|This procedure is used to get notification url on the basis of request id or icci id or ban or unique sim identifier and api group name
	| goup_insert_notification_url			|This procedure is used to insert notification url on the basis of request id or icci id or ban or unique sim identifier and api group name
