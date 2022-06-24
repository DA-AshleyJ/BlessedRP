CREATE TABLE IF NOT EXISTS `rev_jobs` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`citizenid` varchar(50) NOT NULL,
	`elecexperience` int(11) DEFAULT NULL
	PRIMARY KEY (`citizenid`)
	KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

ALTER TABLE rev_jobs ADD elecexperience INT(11) NOT NULL default 1;