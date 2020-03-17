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

USE goup_router;
-- Dumping data for table testing_goup_router_v1.bulk_upload_sim_inventory: ~38 rows (approximately)
DELETE FROM `bulk_upload_sim_inventory`;
/*!40000 ALTER TABLE `bulk_upload_sim_inventory` DISABLE KEYS */;
INSERT INTO `bulk_upload_sim_inventory` (`id`, `wso2_appilication_name`, `sim_uid`, `name`, `sim_id`, `type`, `file_id`) VALUES
	(1, 'STC-IN', '1', 'iccid', '899660110001013351', 'donor\r', 50),
	(2, 'STC-IN', '2', 'imsi', '852369741', 'home\r', 50),
	(3, 'STC-IN', '3', 'iccid', '58269', 'donor\r', 50),
	(4, 'STC-IN', '4', 'iccid', '75824', 'home\r', 50),
	(5, 'BSS-AU', '1234', 'iccid', '8944200012781000090', 'donor', 51),
	(6, 'BSS-AU', '1234', 'iccid', '8944200012781000090', 'home', 51),
	(7, 'STC-IN', '1', 'iccid', '5.45E+22', 'donor\r', 52),
	(8, 'STC-IN', '2', 'imsi', '5.45E+22', 'home\r', 52),
	(10, 'STC-IN', '1', 'iccid', '5.45E+22', 'donor\r', 53),
	(11, 'STC-IN', '2', 'imsi', '5.45E+22', 'home\r', 53),
	(13, 'STC-IN', '1', 'iccid', '5.45E+22', 'donor\r', 54),
	(14, 'STC-IN', '2', 'imsi', '5.45E+22', 'home\r', 54),
	(16, 'STC-IN', '10', 'iccid', '54500000000000000000000', 'donor', 55),
	(17, 'STC-IN', '11', 'imsi', '54500000000000000000000', 'home', 55),
	(19, 'GT-AU', '31', 'iccid', '8944200012781110000', 'donor\r', 56),
	(20, 'GT-AU', '32', 'imsi', '894421111', 'home\r', 56),
	(21, 'Jasper-ATT', '23', 'iccid', '8944200012781120000', 'donor\r', 56),
	(22, 'Jasper-ATT', '33', 'imsi', '894421112', 'home\r', 56),
	(26, 'GT-AU', '33', 'iccid', '8944200012781130000', 'donor\r', 57),
	(27, 'GT-AU', '33', 'imsi', '894421113', 'home\r', 57),
	(28, 'Jasper-ATT', '44', 'iccid', '8944200012781140000', 'donor\r', 57),
	(29, 'Jasper-ATT', '44', 'imsi', '894421114', 'home\r', 57),
	(33, 'GT-AU', '34', 'iccid', '8944200012781150000', 'donor\r', 58),
	(34, 'GT-AU', '34', 'imsi', '894421115', 'home\r', 58),
	(35, 'Jasper-ATT', '45', 'iccid', '8944200012781160000', 'donor\r', 58),
	(36, 'Jasper-ATT', '45', 'imsi', '894421116', 'home\r', 58),
	(40, 'STC-IN', '1', 'iccid', '5.45E+22', 'donor\r', 59),
	(41, 'STC-IN', '2', 'imsi', '5.45E+22', 'home\r', 59),
	(43, 'STC-IN', '20', 'iccid', '5678965423567', 'donor', 60),
	(44, 'STC-IN', '21', 'imsi', '78675786678', 'home', 60),
	(46, 'GT-AU', '4444', 'iccid', '4343444444', 'donor\r', 61),
	(47, 'GT-AU', '3444', 'imsi', '4444444', 'home\r', 61),
	(49, 'STC-IN', '1', 'iccid', '4323432434324320000', 'donor\r', 62),
	(50, 'STC-IN', '2', 'imsi', '34324324324324300', 'home\r', 62),
	(52, 'GT-AU', '1234', 'imsi', '240276440016575', 'donor\r', 63),
	(53, 'GT-AU', '1234', 'imsi', '240276440016575', 'home\r', 63),
	(54, 'GT-AU', '1234', 'iccid', '8944200012781000000', 'donor\r', 63),
	(55, 'GT-AU', '1234', 'iccid', '8944200012781000000', 'home\r', 63);
/*!40000 ALTER TABLE `bulk_upload_sim_inventory` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.bulk_upload_sim_inventory_errors: ~0 rows (approximately)
DELETE FROM `bulk_upload_sim_inventory_errors`;
/*!40000 ALTER TABLE `bulk_upload_sim_inventory_errors` DISABLE KEYS */;
/*!40000 ALTER TABLE `bulk_upload_sim_inventory_errors` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.country: ~252 rows (approximately)
DELETE FROM `country`;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` (`id`, `name`, `code`) VALUES
	(1, 'Afghanistan', 'AF'),
	(2, 'Albania', 'AL'),
	(3, 'Algeria', 'DZ'),
	(4, 'American Samoa', 'AS'),
	(5, 'Andorra', 'AD'),
	(6, 'Angola', 'AO'),
	(7, 'Anguilla', 'Al'),
	(8, 'Antarctica', 'AQ'),
	(9, 'Antigua And Barbuda', 'AG'),
	(10, 'Argentina', 'AR'),
	(11, 'Armenia', 'AM'),
	(12, 'Aruba', 'AW'),
	(13, 'Australia', 'AU'),
	(14, 'Austria', 'AT'),
	(15, 'Azerbaijan', 'AZ'),
	(16, 'Bahamas The', 'BS'),
	(17, 'Bahrain', 'BH'),
	(18, 'Bangladesh', 'BD'),
	(19, 'Barbados', 'BB'),
	(20, 'Belarus', 'BY'),
	(21, 'Belgium', 'BE'),
	(22, 'Belize', 'BZ'),
	(23, 'Benin', 'BJ'),
	(24, 'Bermuda', 'BM'),
	(25, 'Bhutan', 'BT'),
	(26, 'Bolivia', 'BO'),
	(27, 'Bosnia and Herzegovina', 'BA'),
	(28, 'Botswana', 'BW'),
	(29, 'Bouvet Island', 'BV'),
	(30, 'Brazil', 'BR'),
	(31, 'British Indian Ocean Territory', 'BV'),
	(32, 'Brunei', 'BN'),
	(33, 'Bulgaria', 'BG'),
	(34, 'Burkina Faso', 'BF'),
	(35, 'Burundi', 'BI'),
	(36, 'Cambodia', 'KH'),
	(37, 'Cameroon', 'CM'),
	(38, 'Canada', 'CA'),
	(39, 'Cape Verde', 'CV'),
	(40, 'Cayman Islands', 'KY'),
	(41, 'Central African Republic', 'CF'),
	(42, 'Chad', 'TD'),
	(43, 'Chile', 'CL'),
	(44, 'China', 'CN'),
	(45, 'Christmas Island', 'CX'),
	(46, 'Cocos (Keeling) Islands', 'CC'),
	(47, 'Colombia', 'CO'),
	(48, 'Comoros', 'KM'),
	(49, 'Congo', 'CD'),
	(50, 'Congo The Democratic Republic Of The', 'CD'),
	(51, 'Cook Islands', 'CK'),
	(52, 'Costa Rica', 'CR'),
	(53, 'Cote D\'Ivoire (Ivory Coast)', 'CI'),
	(54, 'Croatia (Hrvatska)', 'HR'),
	(55, 'Cuba', 'CU'),
	(56, 'Cyprus', 'CY'),
	(57, 'Czech Republic', 'CZ'),
	(58, 'Denmark', 'DK'),
	(59, 'Djibouti', 'DJ'),
	(60, 'Dominica', 'DM'),
	(61, 'Dominican Republic', 'DO'),
	(62, 'East Timor', 'TL'),
	(63, 'Ecuador', 'EC'),
	(64, 'Egypt', 'EG'),
	(65, 'El Salvador', 'SV'),
	(66, 'Equatorial Guinea', 'GQ'),
	(67, 'Eritrea', 'ER'),
	(68, 'Estonia', 'EE'),
	(69, 'Ethiopia', 'ET'),
	(70, 'External Territories of Australia', 'EAU'),
	(71, 'Falkland Islands', 'FK'),
	(72, 'Faroe Islands', 'FO'),
	(73, 'Fiji Islands', 'FJ'),
	(74, 'Finland', 'FI'),
	(75, 'France', 'FR'),
	(76, 'French Guiana', 'GF'),
	(77, 'French Polynesia', 'PF'),
	(78, 'French Southern Territories', 'TF'),
	(79, 'Gabon', 'GA'),
	(80, 'Gambia The', 'GM'),
	(81, 'Georgia', 'GE'),
	(82, 'Germany', 'DE'),
	(83, 'Ghana', 'GH'),
	(84, 'Gibraltar', 'GI'),
	(85, 'Greece', 'GR'),
	(86, 'Greenland', 'GL'),
	(87, 'Grenada', 'GD'),
	(88, 'Guadeloupe', 'GP'),
	(89, 'Guam', 'GU'),
	(90, 'Guatemala', 'GT'),
	(91, 'Guernsey and Alderney', NULL),
	(92, 'Guinea', 'GN'),
	(93, 'Guinea-Bissau', 'GW'),
	(94, 'Guyana', 'GY'),
	(95, 'Haiti', 'HT'),
	(96, 'Heard and McDonald Islands', 'HM'),
	(97, 'Honduras', 'HN'),
	(98, 'Hong Kong S.A.R.', 'HK'),
	(99, 'Hungary', 'HU'),
	(100, 'Iceland', 'IS'),
	(101, 'India', 'IN'),
	(102, 'Indonesia', 'ID'),
	(103, 'Iran', 'IR'),
	(104, 'Iraq', 'IQ'),
	(105, 'Ireland', 'IE'),
	(106, 'Israel', 'IE'),
	(107, 'Italy', 'IT'),
	(108, 'Jamaica', 'JM'),
	(109, 'Japan', 'JP'),
	(110, 'Jersey', 'JE'),
	(111, 'Jordan', 'JO'),
	(112, 'Kazakhstan', 'KZ'),
	(113, 'Kenya', 'KE'),
	(114, 'Kiribati', 'KI'),
	(115, 'Korea North', 'KR'),
	(116, 'Korea South', 'KP'),
	(117, 'Kuwait', 'KW'),
	(118, 'Kyrgyzstan', 'KZ'),
	(119, 'Laos', 'LA'),
	(120, 'Latvia', 'LV'),
	(121, 'Lebanon', 'LB'),
	(122, 'Lesotho', 'LS'),
	(123, 'Liberia', 'LR'),
	(124, 'Libya', 'LY'),
	(125, 'Liechtenstein', 'LI'),
	(126, 'Lithuania', 'LT'),
	(127, 'Luxembourg', 'LU'),
	(128, 'Macau S.A.R.', 'MO'),
	(129, 'Macedonia', 'MK'),
	(130, 'Madagascar', 'MG'),
	(131, 'Malawi', 'MW'),
	(132, 'Malaysia', 'MY'),
	(133, 'Maldives', 'MV'),
	(134, 'Mali', 'ML'),
	(135, 'Malta', 'MT'),
	(136, 'Man (Isle of)', 'IM'),
	(137, 'Marshall Islands', 'MH'),
	(138, 'Martinique', 'MQ'),
	(139, 'Mauritania', 'MR'),
	(140, 'Mauritius', 'MU'),
	(141, 'Mayotte', 'YT'),
	(142, 'Mexico', 'MX'),
	(143, 'Micronesia', 'FM'),
	(144, 'Moldova', 'MD'),
	(145, 'Monaco', 'MC'),
	(146, 'Mongolia', 'MN'),
	(147, 'Montserrat', 'MS'),
	(148, 'Morocco', 'MA'),
	(149, 'Mozambique', 'MZ'),
	(150, 'Myanmar', 'MN'),
	(151, 'Namibia', 'NA'),
	(152, 'Nauru', 'NR'),
	(153, 'Nepal', 'NP'),
	(154, 'Netherlands Antilles', 'AN'),
	(155, 'Netherlands The', 'NL'),
	(156, 'New Caledonia', 'NC'),
	(157, 'New Zealand', 'NZ'),
	(158, 'Nicaragua', 'NI'),
	(159, 'Niger', 'NE'),
	(160, 'Nigeria', 'NG'),
	(161, 'Niue', 'NU'),
	(162, 'Norfolk Island', 'NF'),
	(163, 'Northern Mariana Islands', 'MP'),
	(164, 'Norway', 'NO'),
	(165, 'Oman', 'OM'),
	(166, 'Pakistan', 'PK'),
	(167, 'Palau', 'PW'),
	(168, 'Palestinian Territory Occupied', 'PS'),
	(169, 'Panama', 'PA'),
	(170, 'Papua new Guinea', 'PG'),
	(171, 'Paraguay', 'PY'),
	(172, 'Peru', 'PE'),
	(173, 'Philippines', 'PH'),
	(174, 'Pitcairn Island', 'PN'),
	(175, 'Poland', 'PL'),
	(176, 'Portugal', 'PT'),
	(177, 'Puerto Rico', 'PR'),
	(178, 'Qatar', 'QA'),
	(179, 'Reunion', 'RE'),
	(180, 'Romania', 'RO'),
	(181, 'Russia', 'RU'),
	(182, 'Rwanda', 'RW'),
	(183, 'Saint Helena', 'SH'),
	(184, 'Saint Kitts And Nevis', 'KN'),
	(185, 'Saint Lucia', 'LC'),
	(186, 'Saint Pierre and Miquelon', 'PM'),
	(187, 'Saint Vincent And The Grenadines', 'VC'),
	(188, 'Samoa', 'WS'),
	(189, 'San Marino', 'SM'),
	(190, 'Sao Tome and Principe', 'ST'),
	(191, 'Saudi Arabia', 'SA'),
	(192, 'Senegal', 'SN'),
	(193, 'Serbia', 'RS'),
	(194, 'Seychelles', 'SC'),
	(195, 'Sierra Leone', 'SL'),
	(196, 'Singapore', 'SG'),
	(197, 'Slovakia', 'SK'),
	(198, 'Slovenia', 'Sl'),
	(199, 'Smaller Territories of the UK', 'UK'),
	(200, 'Solomon Islands', 'SB'),
	(201, 'Somalia', 'SO'),
	(202, 'South Africa', 'ZA'),
	(203, 'South Georgia', 'GS'),
	(204, 'South Sudan', 'SS'),
	(205, 'Spain', 'ES'),
	(206, 'Sri Lanka', 'LK'),
	(207, 'Sudan', 'SD'),
	(208, 'Suriname', 'SR'),
	(209, 'Svalbard And Jan Mayen Islands', 'SJ'),
	(210, 'Swaziland', 'SZ'),
	(211, 'Sweden', 'SE'),
	(212, 'Switzerland', 'CH'),
	(213, 'Syria', 'SY'),
	(214, 'Taiwan', 'TW'),
	(215, 'Tajikistan', 'TJ'),
	(216, 'Tanzania', 'TZ'),
	(217, 'Thailand', 'TH'),
	(218, 'Togo', 'TG'),
	(219, 'Tokelau', 'TK'),
	(220, 'Tonga', 'TO'),
	(221, 'Trinidad And Tobago', 'TT'),
	(222, 'Tunisia', 'TN'),
	(223, 'Turkey', 'TR'),
	(224, 'Turkmenistan', 'TM'),
	(225, 'Turks And Caicos Islands', 'TC'),
	(226, 'Tuvalu', 'TV'),
	(227, 'Uganda', 'UG'),
	(228, 'Ukraine', 'UA'),
	(229, 'United Arab Emirates', 'AE'),
	(230, 'United Kingdom', 'GB'),
	(231, 'United States', 'US'),
	(232, 'United States Minor Outlying Islands', 'UM'),
	(233, 'Uruguay', 'UY'),
	(234, 'Uzbekistan', 'UZ'),
	(235, 'Vanuatu', 'VU'),
	(236, 'Vatican City State (Holy See)', 'VA'),
	(237, 'Venezuela', 'VE'),
	(238, 'Vietnam', 'VN'),
	(239, 'Virgin Islands (British)', 'VG'),
	(240, 'Virgin Islands (US)', 'Vl'),
	(241, 'Wallis And Futuna Islands', 'WF'),
	(242, 'Western Sahara', 'EH'),
	(243, 'Yemen', 'YE'),
	(244, 'Yugoslavia', NULL),
	(245, 'Zambia', 'ZM'),
	(246, 'Zimbabwe', 'ZW'),
	(247, 'default', 'default'),
	(248, 'defaults', 'defaults'),
	(249, 'NILL', 'NILL'),
	(250, 'Guernsey', 'GC'),
	(251, 'EU', 'EU'),
	(252, 'Ukraine', 'UA');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.error_codes: ~4 rows (approximately)
DELETE FROM `error_codes`;
/*!40000 ALTER TABLE `error_codes` DISABLE KEYS */;
INSERT INTO `error_codes` (`id`, `response_code`, `error_template`) VALUES
	(6, 'CMN002', '{"error_code":"CMN002","description":"<ParamName>  is Mandatory Parameter."}'),
	(7, 'CMN003', '{"error_code":"CMN003","description":"<ParamName>  Not Found."}'),
	(8, 'CMN001', '{"error_code":"CMN001","description":"Pending Request Already Exists."}'),
	(9, 'CMN004', '{"error_code":"CMN004","description":"Internal Server Error."}');
/*!40000 ALTER TABLE `error_codes` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.file_registration: ~22 rows (approximately)
DELETE FROM `file_registration`;
/*!40000 ALTER TABLE `file_registration` DISABLE KEYS */;
INSERT INTO `file_registration` (`id`, `file_name`, `file_path`, `uploaded_on`, `uploaded_by`, `description`, `is_fault`, `is_status`) VALUES
	(1, 'SimData.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/SimData.csv', 1540876759, NULL, NULL, 0, 4),
	(2, 'SimData1.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/SimData1.csv', 1540876830, NULL, NULL, 0, 4),
	(3, 'Bulk Upload.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Bulk Upload.csv', 1542003301, NULL, NULL, 0, 2),
	(4, 'Bulk UploadGcontol.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Bulk UploadGcontol.csv', 1542262330, NULL, NULL, 0, 2),
	(5, 'trial34.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/trial34.csv', 1542778685, NULL, NULL, 0, 4),
	(6, 'trial35.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/trial35.csv', 1542778783, NULL, NULL, 0, 2),
	(7, 'Bulk UploadSTC.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Bulk UploadSTC.csv', 1543384896, NULL, NULL, 0, 2),
	(49, 'trialCSVUpload.csv', '/home/user/Tomcat/apache-tomcat-8.0.43/webapps/tmpFiles/trialCSVUpload.csv', 1543906002, NULL, NULL, 0, 2),
	(50, 'trial.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/trial.csv', 1545042089, NULL, NULL, 0, 2),
	(51, 'sample.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/sample.csv', 1547113267, NULL, NULL, 0, 2),
	(52, 'trial (4).csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/trial (4).csv', 1548855256, NULL, NULL, 0, 2),
	(53, 'upload.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/upload.csv', 1548855793, NULL, NULL, 0, 2),
	(54, 'Sim Inventory.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Sim Inventory.csv', 1548859736, NULL, NULL, 0, 2),
	(55, 'Sim Inventory1.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Sim Inventory1.csv', 1548859940, NULL, NULL, 0, 2),
	(56, 'Sim Inventory demo.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Sim Inventory demo.csv', 1548926179, NULL, 'demo', 0, 2),
	(57, 'Sim Inventory demo1.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Sim Inventory demo1.csv', 1548926557, NULL, 'different\n', 0, 2),
	(58, 'Sim Inventory demo2.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Sim Inventory demo2.csv', 1548926715, NULL, 'wwqwe', 0, 2),
	(59, 'Sim Inventory.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Sim Inventory.csv', 1548942575, NULL, NULL, 0, 2),
	(60, 'Sim Inventory (2).csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Sim Inventory (2).csv', 1548942848, NULL, NULL, 0, 2),
	(61, 'Sim Inventory demo2323.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Sim Inventory demo2323.csv', 1548946148, NULL, NULL, 0, 2),
	(62, 'Sim Inventory (1).csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Sim Inventory (1).csv', 1548946211, NULL, NULL, 0, 2),
	(63, 'Sim Inventory_imsi.csv', '/home/ttpl/TomcatTesting/apache-tomcat-8.0.36/webapps/tmpFiles/Sim Inventory_imsi.csv', 1549089996, NULL, 'imsi', 0, 2);
/*!40000 ALTER TABLE `file_registration` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.interfaces: ~4 rows (approximately)
DELETE FROM `interfaces`;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` (`id`, `name`, `mysql_host`, `mysql_port`, `mysql_username`, `mysql_password`, `mysql_password_salt`, `version`, `database_name`, `thirdparty_database_name`) VALUES
	(23, 'Comarch-IN', '192.168.1.117', '3306', 'root', 'Ttpl@123', NULL, 'v1', 'comarch_testing_goup_interface', 'comarch_testing_goup_interface_thirdparty'),
	(24, 'GConnect-AU', '192.168.1.117', '3306', 'root', 'Ttpl@123', NULL, 'v1', 'gconnect_testing_goup_interface', 'gconnect_testing_goup_interface_thirdparty'),
	(28, 'Jasper-ATT', '192.168.1.117', '3306', 'root', 'Ttpl@123', NULL, NULL, 'jasper_testing_goup_interface', 'jasper_testing_goup_interface_thirdparty'),
	(29, 'Comarch', '192.168.1.82', '3306', 'root', 'Ttpl@123', NULL, NULL, 'comarch_development_goup_interface', NULL);
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.language: ~2 rows (approximately)
DELETE FROM `language`;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` (`id`, `language`, `description`, `is_default`, `code`) VALUES
	(1, 'English', 'English Language', 1, 1),
	(2, 'Chinese', 'Chinese Language', 0, 2);
/*!40000 ALTER TABLE `language` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.messages: ~72 rows (approximately)
DELETE FROM `messages`;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` (`id`, `parameter`, `value`, `code`, `message`, `language_id`) VALUES
	(1, 'isLogInserted', 1, 1, 'Log Inserted', 1),
	(2, 'isFileRegistered', 1, 2, 'File is Registered', 1),
	(3, 'isFileExists', 1, 3, 'File already exists', 1),
	(4, 'isInterfaceDeleted', 1, 4, 'Operator node is deleted', 1),
	(5, 'isInterfaceExists', 1, 5, 'Operator node already exists', 1),
	(6, 'isInterfaceInserted', 1, 6, 'Operator node is inserted', 1),
	(7, 'isInterfaceUpdated', 1, 7, 'Operator node is updated', 1),
	(8, 'isCountryOperatorUpdated', 1, 8, 'Country and operator is updated', 1),
	(9, 'isFileStatusUpdated', 1, 9, 'File Status Updated', 1),
	(10, 'isFileExists', 0, 10, 'File does not exists', 1),
	(11, 'FileStatusInfo', 1, 11, 'Incorrect Format', 1),
	(12, 'FileStatusInfo', 1, 12, 'Ready To Process', 1),
	(13, 'FileStatusInfo', 1, 13, 'Inventory Inserted Successfully', 1),
	(14, 'FileStatusInfo', 1, 14, 'Inventory Partially  Inserted', 1),
	(15, 'FileStatusInfo', 1, 15, 'Inventory Not Inserted', 1),
	(16, 'FileStatusInfo', 1, 16, 'Unknown Error', 1),
	(17, 'isSimInventoryDeleted', 1, 17, 'Sim inventory is deleted', 1),
	(18, 'isSimInventoryInserted', 1, 18, 'Sim inventory inserted', 1),
	(19, 'isWso2AppilicationDeleted', 1, 19, 'Mno appilication is deleted', 1),
	(20, 'isWso2AppilicationInserted', 1, 20, 'Mno appilication is inserted', 1),
	(21, 'isWso2AppilicationExists', 1, 21, 'Mno appilication already exists', 1),
	(22, 'isWso2AppilicationUpdated', 1, 22, 'Mno appilication is updated', 1),
	(23, 'isTrackingMessageHeaderExists', 1, 23, 'Tracking message header already exists', 1),
	(24, 'isTrackingMessageHeaderInserted', 1, 24, 'Tracking message header is inserted', 1),
	(25, 'isTrackingMessageHeaderInserted', 1, 24, '插入了跟踪邮件标题', 2),
	(26, 'isTrackingMessageHeaderExists', 1, 23, '跟踪邮件标头已存在', 2),
	(27, 'isWso2AppilicationUpdated', 1, 22, 'Mno应用程序已更新', 2),
	(28, 'isWso2AppilicationExists', 1, 21, 'Mno appilication已经存在', 2),
	(29, 'isWso2AppilicationInserted', 1, 20, '插入MNO应用程序', 2),
	(30, 'isWso2AppilicationDeleted', 1, 19, 'Mno appilication已删除', 2),
	(31, 'isSimInventoryInserted', 1, 18, 'Sim库存已插入', 2),
	(32, 'isSimInventoryDeleted', 1, 17, 'Sim库存已删除', 2),
	(33, 'FileStatusInfo', 1, 16, '未知错误', 2),
	(34, 'FileStatusInfo', 1, 15, '库存未插入', 2),
	(35, 'FileStatusInfo', 1, 14, '库存部分插入', 2),
	(36, 'FileStatusInfo', 1, 13, '库存已成功插入', 2),
	(37, 'FileStatusInfo', 1, 12, '准备好处理', 2),
	(38, 'FileStatusInfo', 1, 11, '格式不正确', 2),
	(39, 'isFileExists', 0, 10, '文件不存在', 2),
	(40, 'isFileStatusUpdated', 1, 9, '文件状态已更新', 2),
	(41, 'isCountryOperatorUpdated', 1, 8, '国家和运营商已更新', 2),
	(42, 'isInterfaceUpdated', 1, 7, '操作员节点已更新', 2),
	(43, 'isInterfaceInserted', 1, 6, '插入了操作员节点', 2),
	(44, 'isInterfaceExists', 1, 5, '操作员节点已存在', 2),
	(45, 'isInterfaceDeleted', 1, 4, '操作员节点已删除', 2),
	(46, 'isFileExists', 1, 3, '文件已存在', 2),
	(47, 'isFileRegistered', 1, 2, '文件已注册', 2),
	(48, 'isLogInserted', 1, 1, '已插入日志', 2),
	(49, 'isOperatorUpdated', 1, 25, 'Operator is updated', 1),
	(50, 'isOperatorUpdated', 1, 25, '运营商已更新', 2),
	(51, 'isOperatorExists', 1, 26, 'Operator already exists', 1),
	(52, 'isOperatorExists', 1, 26, '运营商已存在', 2),
	(53, 'OperatorInserted', 1, 27, 'Operator is inserted', 1),
	(54, 'isOperatorDeleted', 1, 28, 'Operator is deleted', 1),
	(55, 'isOperatorDeleted', 1, 28, '运算符已删除', 2),
	(56, 'OperatorInserted', 1, 27, '插入操作员', 2),
	(57, 'Process Success', 1, 29, 'Process Success', 1),
	(58, 'Process Success', 1, 29, '流程成功', 2),
	(59, 'Process Success', 0, 30, 'Process Fail', 1),
	(60, 'Process Success', 0, 30, '过程失败', 2),
	(61, 'Message', 1, 31, 'msg', 1),
	(62, 'Message', 1, 31, '味精', 2),
	(63, 'isConnectionSuccessfull', 1, 32, 'Successfully made the connection', 1),
	(64, 'isConnectionSuccessfull', 1, 32, '成功建立了连接', 2),
	(65, 'isConnectionSuccessfull', 0, 69, 'Failed to connect to MySQL', 1),
	(66, 'isConnectionSuccessfull', 0, 69, '无法连接到MySQL', 2),
	(67, 'isDataAvailable', 0, 34, 'No data available', 1),
	(68, 'isDataAvailable', 0, 34, '没有可用数据', 2),
	(69, 'Message', 1, 67, 'msg', 1),
	(70, 'Message', 1, 67, '味精', 2),
	(71, 'isInterfaceAlreadyExists', 1, 68, 'Operator node already exists', 1),
	(72, 'isInterfaceAlreadyExists', 1, 68, '操作员节点已存在', 2);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.operator: ~6 rows (approximately)
DELETE FROM `operator`;
/*!40000 ALTER TABLE `operator` DISABLE KEYS */;
INSERT INTO `operator` (`id`, `name`, `code`) VALUES
	(1, 'STC', 'STC'),
	(2, 'ATT', 'ATT'),
	(9, 'GT', 'GT'),
	(10, '1', '1'),
	(11, '2', '2'),
	(12, 'test', 'test');
/*!40000 ALTER TABLE `operator` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.operator_interface: ~4 rows (approximately)
DELETE FROM `operator_interface`;
/*!40000 ALTER TABLE `operator_interface` DISABLE KEYS */;
INSERT INTO `operator_interface` (`id`, `operator_id`, `interface_id`) VALUES
	(27, 1, 23),
	(28, 9, 24),
	(37, 9, 27),
	(40, 2, 28);
/*!40000 ALTER TABLE `operator_interface` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.report_header_mapping: ~1 rows (approximately)
DELETE FROM `report_header_mapping`;
/*!40000 ALTER TABLE `report_header_mapping` DISABLE KEYS */;
INSERT INTO `report_header_mapping` (`id`, `column_names`, `report_api_url`, `column_type`, `column_alias`) VALUES
	(14, 'wso2_appilication_name,sim_uid,name,sim_id,type,remark', 'goup/router/get/bulk/sim/inventory', 'String,String,String,String,String,String', 'Application Name, Sim UID , Name, Sim ID, Type, Remark');
/*!40000 ALTER TABLE `report_header_mapping` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.sim_donor_identfiers: ~34 rows (approximately)
DELETE FROM `sim_donor_identfiers`;
/*!40000 ALTER TABLE `sim_donor_identfiers` DISABLE KEYS */;
INSERT INTO `sim_donor_identfiers` (`id`, `name`, `sim_identfier_bin`, `sim_id`) VALUES
	(61, 'iccid', _binary 0x11E901E589DD26DEBACBAAAD5EFE4DC2, '58269'),
	(62, 'iccid', _binary 0x11E913D731C8E5F88B7BAAAD5EFE4DC2, '894627004440016576'),
	(63, 'imsi', _binary 0x11E913D731C8E5F88B7BAAAD5EFE4DC2, '240276440016576'),
	(64, 'msisdn', _binary 0x11E913D731C8E5F88B7BAAAD5EFE4DC2, '46769802126'),
	(70, 'iccid', _binary 0x11E9249E8E457F2885CFAAAD5EFE4DC2, '54500000000000000000000'),
	(81, 'iccid', _binary 0x11E9255F984D2CBA85CFAAAD5EFE4DC2, '5678965423567'),
	(85, 'iccid', _binary 0x11E926B76C159B0585CFAAAD5EFE4DC2, '8946270044400176972'),
	(86, 'imsi', _binary 0x11E926B76C159B0585CFAAAD5EFE4DC2, '404441111111112'),
	(87, 'userIdentifier', _binary 0x11E926B76C159B0585CFAAAD5EFE4DC2, 'defaults9bb9f345cebc434f8a30327b034d1c84'),
	(88, 'iccid', _binary 0x11E92866F4A7F51D85CFAAAD5EFE4DC2, '8944200012781000090'),
	(89, 'imsi', _binary 0x11E92866F4A7F51D85CFAAAD5EFE4DC2, '240276440016575 '),
	(94, 'iccid', _binary 0x11E929117BE3382085CFAAAD5EFE4DC2, '8944200012781000000'),
	(95, 'imsi', _binary 0x11E929117BE3382085CFAAAD5EFE4DC2, '240276440016575000'),
	(97, 'iccid', _binary 0x11E92B99371C0D6885CFAAAD5EFE4DC2, '8946270044400176977'),
	(98, 'useridentifier', _binary 0x11E92B99371C0D6885CFAAAD5EFE4DC2, 'defaultsb57705d65e11403c88e70b5c1f1e8764'),
	(99, 'imsi', _binary 0x11E92B99371C0D6885CFAAAD5EFE4DC2, '404441111111113'),
	(100, 'msisdn', _binary 0x11E92B99371C0D6885CFAAAD5EFE4DC2, '46769802132'),
	(101, 'msisdn', _binary 0x11E926B76C159B0585CFAAAD5EFE4DC2, '46769802130'),
	(102, 'imsi', _binary 0x11E9544492AB6CE78935AAAD5EFE4DC2, '234206210060005'),
	(103, 'iccid', _binary 0x11E9544492AB6CE78935AAAD5EFE4DC2, '8944200012789600051'),
	(104, 'imsi', _binary 0x11E95444A94AC2A98935AAAD5EFE4DC2, '234206210060015'),
	(105, 'iccid', _binary 0x11E95444A94AC2A98935AAAD5EFE4DC2, '8944200012789600061'),
	(106, 'iccid', _binary 0x11E95501963A07579E48AAAD5EFE4DC2, '89011703278211508703'),
	(107, 'imsi', _binary 0x11E95501963A07579E48AAAD5EFE4DC2, '310170821150870'),
	(108, 'msisdn', _binary 0x11E95501963A07579E48AAAD5EFE4DC2, '882350821150870'),
	(109, 'iccid', _binary 0x11E9550230F339C69E48AAAD5EFE4DC2, '89011703278211508695'),
	(110, 'imsi', _binary 0x11E9550230F339C69E48AAAD5EFE4DC2, '310170821150869'),
	(111, 'msisdn', _binary 0x11E9550230F339C69E48AAAD5EFE4DC2, '882350821150869'),
	(112, 'iccid', _binary 0x11E955027EA0C1D79E48AAAD5EFE4DC2, '89011703278211508711'),
	(113, 'imsi', _binary 0x11E955027EA0C1D79E48AAAD5EFE4DC2, '310170821150871'),
	(114, 'msisdn', _binary 0x11E955027EA0C1D79E48AAAD5EFE4DC2, '882350821150871'),
	(115, 'iccid', _binary 0x11E95502DFBB68779E48AAAD5EFE4DC2, '89011703278211508729'),
	(116, 'imsi', _binary 0x11E95502DFBB68779E48AAAD5EFE4DC2, '310170821150872'),
	(117, 'msisdn', _binary 0x11E95502DFBB68779E48AAAD5EFE4DC2, '882350821150872');
/*!40000 ALTER TABLE `sim_donor_identfiers` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.sim_home_identifiers: ~32 rows (approximately)
DELETE FROM `sim_home_identifiers`;
/*!40000 ALTER TABLE `sim_home_identifiers` DISABLE KEYS */;
INSERT INTO `sim_home_identifiers` (`id`, `name`, `sim_identfier_bin`, `sim_id`) VALUES
	(76, 'iccid', _binary 0x11E901E589DD2754BACBAAAD5EFE4DC2, '75824'),
	(77, 'iccid', _binary 0x11E913D731C8E5F88B7BAAAD5EFE4DC2, '894627004440016576'),
	(78, 'imsi', _binary 0x11E913D731C8E5F88B7BAAAD5EFE4DC2, '240276440016576'),
	(79, 'msisdn', _binary 0x11E913D731C8E5F88B7BAAAD5EFE4DC2, '46769802126'),
	(86, 'imsi', _binary 0x11E9249E8E4580DD85CFAAAD5EFE4DC2, '54500000000000000000000'),
	(97, 'imsi', _binary 0x11E9255F984D2E6885CFAAAD5EFE4DC2, '78675786678'),
	(101, 'iccid', _binary 0x11E926B76C159B0585CFAAAD5EFE4DC2, '8946270044400176972'),
	(102, 'imsi', _binary 0x11E926B76C159B0585CFAAAD5EFE4DC2, '404441111111112'),
	(103, 'useridentifier', _binary 0x11E926B76C159B0585CFAAAD5EFE4DC2, 'defaults9bb9f345cebc434f8a30327b034d1c84'),
	(104, 'imsi', _binary 0x11E92866F4A7F51D85CFAAAD5EFE4DC2, '240276440016575'),
	(105, 'iccid', _binary 0x11E92866F4A7F51D85CFAAAD5EFE4DC2, '8944200012781000090'),
	(110, 'iccid', _binary 0x11E929117BE3382085CFAAAD5EFE4DC2, '8944200012781000000'),
	(111, 'imsi', _binary 0x11E929117BE3382085CFAAAD5EFE4DC2, '240276440016575000'),
	(113, 'iccid', _binary 0x11E92B99371C0D6885CFAAAD5EFE4DC2, '8946270044400176977'),
	(114, 'useridentifier', _binary 0x11E92B99371C0D6885CFAAAD5EFE4DC2, 'defaultsb57705d65e11403c88e70b5c1f1e8764'),
	(115, 'imsi', _binary 0x11E92B99371C0D6885CFAAAD5EFE4DC2, '404441111111113'),
	(116, 'msisdn', _binary 0x11E92B99371C0D6885CFAAAD5EFE4DC2, '46769802132'),
	(117, 'msisdn', _binary 0x11E926B76C159B0585CFAAAD5EFE4DC2, '46769802130'),
	(118, 'imsi', _binary 0x11E9544492AB6CE78935AAAD5EFE4DC2, '234206210060005'),
	(119, 'iccid', _binary 0x11E9544492AB6CE78935AAAD5EFE4DC2, '8944200012789600051'),
	(122, 'iccid', _binary 0x11E95501963A07579E48AAAD5EFE4DC2, '89011703278211508703'),
	(123, 'imsi', _binary 0x11E95501963A07579E48AAAD5EFE4DC2, '310170821150870'),
	(124, 'msisdn', _binary 0x11E95501963A07579E48AAAD5EFE4DC2, '882350821150870'),
	(125, 'iccid', _binary 0x11E9550230F339C69E48AAAD5EFE4DC2, '89011703278211508695'),
	(126, 'imsi', _binary 0x11E9550230F339C69E48AAAD5EFE4DC2, '310170821150869'),
	(127, 'msisdn', _binary 0x11E9550230F339C69E48AAAD5EFE4DC2, '882350821150869'),
	(128, 'iccid', _binary 0x11E955027EA0C1D79E48AAAD5EFE4DC2, '89011703278211508711'),
	(129, 'imsi', _binary 0x11E955027EA0C1D79E48AAAD5EFE4DC2, '310170821150871'),
	(130, 'msisdn', _binary 0x11E955027EA0C1D79E48AAAD5EFE4DC2, '882350821150871'),
	(131, 'iccid', _binary 0x11E95502DFBB68779E48AAAD5EFE4DC2, '89011703278211508729'),
	(132, 'imsi', _binary 0x11E95502DFBB68779E48AAAD5EFE4DC2, '310170821150872'),
	(133, 'msisdn', _binary 0x11E95502DFBB68779E48AAAD5EFE4DC2, '882350821150872');
/*!40000 ALTER TABLE `sim_home_identifiers` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.sim_map: ~18 rows (approximately)
DELETE FROM `sim_map`;
/*!40000 ALTER TABLE `sim_map` DISABLE KEYS */;
INSERT INTO `sim_map` (`id`, `sim_identfier`, `sim_identfier_bin`, `wso2_appilication_id`, `sim_uid`, `file_id`) VALUES
	(226, '89dd26de-01e5-11e9-bacb-aaad5efe4dc2', _binary 0x11E901E589DD26DEBACBAAAD5EFE4DC2, 20, '3', 50),
	(227, '89dd2754-01e5-11e9-bacb-aaad5efe4dc2', _binary 0x11E901E589DD2754BACBAAAD5EFE4DC2, 20, '4', 50),
	(228, '31c8e5f8-13d7-11e9-8b7b-aaad5efe4dc2', _binary 0x11E913D731C8E5F88B7BAAAD5EFE4DC2, 20, '5', NULL),
	(239, '8e457f28-249e-11e9-85cf-aaad5efe4dc2', _binary 0x11E9249E8E457F2885CFAAAD5EFE4DC2, 20, '10', 55),
	(240, '8e4580dd-249e-11e9-85cf-aaad5efe4dc2', _binary 0x11E9249E8E4580DD85CFAAAD5EFE4DC2, 20, '11', 55),
	(258, '984d2cba-255f-11e9-85cf-aaad5efe4dc2', _binary 0x11E9255F984D2CBA85CFAAAD5EFE4DC2, 20, '20', 60),
	(259, '984d2e68-255f-11e9-85cf-aaad5efe4dc2', _binary 0x11E9255F984D2E6885CFAAAD5EFE4DC2, 20, '21', 60),
	(267, '35e48d8e-26b6-11e9-85cf-aaad5efe4dc2', _binary 0x11E926B635E48D8E85CFAAAD5EFE4DC2, 21, '1234', 63),
	(268, '6c159b05-26b7-11e9-85cf-aaad5efe4dc2', _binary 0x11E926B76C159B0585CFAAAD5EFE4DC2, 21, '12456', NULL),
	(269, 'f4a7f51d-2866-11e9-85cf-aaad5efe4dc2', _binary 0x11E92866F4A7F51D85CFAAAD5EFE4DC2, 21, '22', NULL),
	(274, '7be33820-2911-11e9-85cf-aaad5efe4dc2', _binary 0x11E929117BE3382085CFAAAD5EFE4DC2, 21, '12345', 65),
	(275, '371c0d68-2b99-11e9-85cf-aaad5efe4dc2', _binary 0x11E92B99371C0D6885CFAAAD5EFE4DC2, 21, '6', NULL),
	(276, '92ab6ce7-5444-11e9-8935-aaad5efe4dc2', _binary 0x11E9544492AB6CE78935AAAD5EFE4DC2, 21, '7', NULL),
	(277, 'a94ac2a9-5444-11e9-8935-aaad5efe4dc2', _binary 0x11E95444A94AC2A98935AAAD5EFE4DC2, 21, '8', NULL),
	(278, '963a0757-5501-11e9-9e48-aaad5efe4dc2', _binary 0x11E95501963A07579E48AAAD5EFE4DC2, 23, '9', NULL),
	(279, '30f339c6-5502-11e9-9e48-aaad5efe4dc2', _binary 0x11E9550230F339C69E48AAAD5EFE4DC2, 23, '12', NULL),
	(280, '7ea0c1d7-5502-11e9-9e48-aaad5efe4dc2', _binary 0x11E955027EA0C1D79E48AAAD5EFE4DC2, 23, '13', NULL),
	(281, 'dfbb6877-5502-11e9-9e48-aaad5efe4dc2', _binary 0x11E95502DFBB68779E48AAAD5EFE4DC2, 23, '14', NULL);
/*!40000 ALTER TABLE `sim_map` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.sim_map_history: ~0 rows (approximately)
DELETE FROM `sim_map_history`;
/*!40000 ALTER TABLE `sim_map_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `sim_map_history` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.status: ~6 rows (approximately)
DELETE FROM `status`;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` (`id`, `status`, `message`) VALUES
	(1, 0, 'Incorrect Format'),
	(2, 1, 'Ready To Process'),
	(3, 2, 'Inventory Inserted Successfully'),
	(4, 3, 'Inventory Partially  Inserted'),
	(5, 4, 'Inventory Not Inserted '),
	(6, 5, 'Unknown Error');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;

-- Dumping data for table testing_goup_router_v1.wso2_appilication: ~3 rows (approximately)
DELETE FROM `wso2_appilication`;
/*!40000 ALTER TABLE `wso2_appilication` DISABLE KEYS */;
INSERT INTO `wso2_appilication` (`id`, `name`, `operator`, `country`, `interface_id`, `host`, `port`, `version`, `auth_app_key`) VALUES
	(20, 'STC-IN', 1, 101, 23, 'http://192.168.1.242:8280/IndiaSTC/v1', NULL, 'v1', '883edc1a-0cf4-11e9-9b0d-fe984cc15272'),
	(21, 'GT-AU', 9, 13, 24, 'http://192.168.1.242:8280/AustraliaGT/v1', NULL, 'v1', '883edc1a-0cf4-11e9-9b0d-fe984cc15272'),
	(23, 'Jasper-ATT', 2, 231, 28, 'http://192.168.1.242:8280/UsaATT/v1', NULL, 'v1', '883edc1a-0cf4-11e9-9b0d-fe984cc15272');
/*!40000 ALTER TABLE `wso2_appilication` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
