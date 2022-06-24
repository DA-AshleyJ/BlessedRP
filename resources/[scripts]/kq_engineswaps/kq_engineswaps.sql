CREATE TABLE IF NOT EXISTS `kq_tuning` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) NOT NULL DEFAULT '',
  `engine` varchar(50) NOT NULL DEFAULT '',
  `tuned_by` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2148 DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `kq_tuningparts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storage` varchar(50) NOT NULL DEFAULT '0',
  `type` varchar(50) NOT NULL DEFAULT '0',
  `part` varchar(50) NOT NULL DEFAULT '0',
  `available_at` bigint(20) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4;
