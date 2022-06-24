

CREATE TABLE `kibra_houses` (
  `id` int(11) NOT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `keydata` varchar(255) DEFAULT NULL,
  `date` varchar(255) NOT NULL,
  `status` int(11) DEFAULT 0,
  `paymentinfo` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `kibra_houses` (`id`, `owner`, `keydata`, `date`, `status`, `paymentinfo`) VALUES
(1, NULL, NULL, '', 0, 0),
(2, NULL, NULL, '', 0, 0),
(3, NULL, NULL, '', 0, 0),
(4, NULL, NULL, '', 0, 0),
(5, NULL, NULL, '', 0, 0),
(6, NULL, NULL, '', 0, 0),
(7, NULL, NULL, '', 0, 0),
(8, NULL, NULL, '', 0, 0),
(9, NULL, NULL, '', 0, 0),
(10, NULL, NULL, '', 0, 0),

ALTER TABLE `kibra_houses`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `kibra_houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;
