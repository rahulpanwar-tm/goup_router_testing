USE goup_router;

update wso2_appilication set name = 'GT-UAE'
where name = 'GT-AU';

DELETE FROM bulk_upload_sim_inventory where file_id IN(50,51,52,53,54,55,56,57,58,59,60,61,62,63);

DELETE FROM sim_home_identifiers where id IN 
(101,102,103,104,105,110,111,113,114,115,116,117,118,119,122,123,124,125,
126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,
144,145,146,147,148,149);

DELETE FROM sim_donor_identfiers where id IN 
(85,86,87,88,89,94,95,97,98,99,100,101,102,103,104,105,106,107,108,109,
110,111,112,113,114,115,116,117,127,128,129,130,131,132,133,134,135,136,
137,138,139,140,141,142,144);

DELETE FROM sim_map where id IN 
(267,268,269,274,275,276,277,278,279,280,281,288,290,291,292,293,294);

update wso2_appilication
set country = 229
where name = 'GT-UAE';

update interfaces set name = 'GConnect-UAE' where name = 'GConnect-AU';