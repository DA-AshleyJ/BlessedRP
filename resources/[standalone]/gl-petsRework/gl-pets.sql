DROP TABLE IF EXISTS `gl_pets`;
CREATE TABLE IF NOT EXISTS `gl_pets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(60) DEFAULT NULL,
  `model` varchar(250) DEFAULT NULL,
  `stats` varchar(60) DEFAULT '{"loyalty":50,"stam":100,"hunger":100}',
  `variation` varchar(60) DEFAULT NULL,
  `name` varchar(255) DEFAULT 'Pet',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;