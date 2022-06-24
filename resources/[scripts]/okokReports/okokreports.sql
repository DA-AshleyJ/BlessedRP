CREATE TABLE `okokreports`(
    `admin_identifier` varchar(255) NOT NULL,
    `responded_reports` varchar(255) NOT NULL DEFAULT 1,
    UNIQUE KEY abc_ndx (admin_identifier)
);