CREATE TABLE `users` (
  `users_email_address` varchar(255) PRIMARY KEY,
  `password` varchar(255),
  `userRunLevel` int,
  `isStaff` bit,
  `staff_id` int,
  `client_id` int
);

CREATE TABLE `vehicle` (
  `vehicle_registration_number` varchar(255) PRIMARY KEY,
  `vehicle_model` varchar(255),
  `vehicle_make` varchar(255),
  `vehicle_type` varchar(255),
  `engine_size` int,
  `capacity` int,
  `mileage` int,
  `MOT_test_date` datetime,
  `hire_rate` float,
  `outlet_id` int,
  `isRented` bit,
  `isActive` bit
);

CREATE TABLE `outlet` (
  `outlet_id` int PRIMARY KEY,
  `location` varchar(255),
  `telephone_number` varchar(255),
  `fax_number` varchar(255),
  `manager_id` int
);

CREATE TABLE `staff` (
  `staff_id` int PRIMARY KEY,
  `fst_name` varchar(255),
  `lst_name` varchar(255),
  `home_address` varchar(255),
  `home_phone_number` varchar(255),
  `birthdate` datetime,
  `sex` varchar(255),
  `national_insurance_number` int,
  `date_joined` datetime,
  `job_title` varchar(255),
  `salary` float,
  `outlet_id` int
);

CREATE TABLE `client` (
  `client_id` int PRIMARY KEY,
  `isBusiness` bit,
  `business_profile_id` int,
  `personal_profile_id` int
);

CREATE TABLE `personal_profile` (
  `personal_profile_id` int PRIMARY KEY,
  `fst_name` varchar(255),
  `lst_name` varchar(255),
  `telephone_number` varchar(255),
  `home_address` varchar(255),
  `birthdate` datetime,
  `driving_license_number` varchar(255)
);

CREATE TABLE `business_profile` (
  `business_profile_id` int PRIMARY KEY,
  `business_name` varchar(255),
  `business_type` varchar(255),
  `address` varchar(255),
  `telephone_number` varchar(255),
  `fax_number` varchar(255)
);

CREATE TABLE `hire_agreement` (
  `hire_agreement_id` int PRIMARY KEY,
  `rental_cost` float,
  `vehicle_registration_number` varchar(255),
  `client_id` int,
  `date_start` datetime,
  `date_end` datetime,
  `fault_report_id` int
);

CREATE TABLE `fault_report` (
  `fault_report_id` int PRIMARY KEY,
  `vehicle_registration_number` varchar(255),
  `staff_id` int,
  `comments` varchar(255),
  `isFound` bit
);

CREATE TABLE `fine` (
  `fine_id` int PRIMARY KEY,
  `vehicle_registration_number` varchar(255),
  `amount` float,
  `type` varchar(255),
  `client_id` int,
  `date` datetime,
  `isPaid` bit,
  `transaction_id` int
);

CREATE TABLE `transaction` (
  `transaction_id` int PRIMARY KEY,
  `client_id` int,
  `amount` float,
  `isFine` bit,
  `hire_agreement_id` int,
  `fine_id` int
);

CREATE TABLE `accident` (
  `accident_id` int PRIMARY KEY,
  `client_id` int,
  `staff_id` int,
  `vehicle_registration_number` varchar(255),
  `repair_id` int,
  `insurance_claim_id` int,
  `location` varchar(255),
  `comments` varchar(255)
);

CREATE TABLE `insurance_claim` (
  `insurance_claim_id` int PRIMARY KEY,
  `client_id` int,
  `insurance_account_id` int
);

CREATE TABLE `insurance_account` (
  `insurance_account_id` int PRIMARY KEY,
  `client_id` int,
  `premium` float,
  `deductible` float
);

CREATE TABLE `repair` (
  `repair_id` int PRIMARY KEY,
  `staff_id` int,
  `client_id` int,
  `hire_agreement_id` int,
  `vehicle_registration_number` varchar(255),
  `fault_report_id` int,
  `comments` varchar(255),
  `amount` float,
  `insurance_claim_id` int
);

CREATE TABLE `maintenance` (
  `maintenance_id` int PRIMARY KEY,
  `staff_id` int,
  `client` int,
  `vehicle_registration_number` varchar(255),
  `comments` varchar(255),
  `amount` float
);

ALTER TABLE `users` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `users` ADD FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`);

ALTER TABLE `vehicle` ADD FOREIGN KEY (`outlet_id`) REFERENCES `outlet` (`outlet_id`);

ALTER TABLE `outlet` ADD FOREIGN KEY (`manager_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `staff` ADD FOREIGN KEY (`outlet_id`) REFERENCES `outlet` (`outlet_id`);

ALTER TABLE `client` ADD FOREIGN KEY (`business_profile_id`) REFERENCES `business_profile` (`business_profile_id`);

ALTER TABLE `client` ADD FOREIGN KEY (`personal_profile_id`) REFERENCES `personal_profile` (`personal_profile_id`);

ALTER TABLE `hire_agreement` ADD FOREIGN KEY (`vehicle_registration_number`) REFERENCES `vehicle` (`vehicle_registration_number`);

ALTER TABLE `hire_agreement` ADD FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`);

ALTER TABLE `hire_agreement` ADD FOREIGN KEY (`fault_report_id`) REFERENCES `fault_report` (`fault_report_id`);

ALTER TABLE `fault_report` ADD FOREIGN KEY (`vehicle_registration_number`) REFERENCES `vehicle` (`vehicle_registration_number`);

ALTER TABLE `fault_report` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `fine` ADD FOREIGN KEY (`vehicle_registration_number`) REFERENCES `vehicle` (`vehicle_registration_number`);

ALTER TABLE `fine` ADD FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`);

ALTER TABLE `transaction` ADD FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`);

ALTER TABLE `transaction` ADD FOREIGN KEY (`hire_agreement_id`) REFERENCES `hire_agreement` (`hire_agreement_id`);

ALTER TABLE `transaction` ADD FOREIGN KEY (`fine_id`) REFERENCES `fine` (`fine_id`);

ALTER TABLE `accident` ADD FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`);

ALTER TABLE `accident` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `accident` ADD FOREIGN KEY (`vehicle_registration_number`) REFERENCES `vehicle` (`vehicle_registration_number`);

ALTER TABLE `accident` ADD FOREIGN KEY (`repair_id`) REFERENCES `repair` (`repair_id`);

ALTER TABLE `insurance_claim` ADD FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`);

ALTER TABLE `insurance_claim` ADD FOREIGN KEY (`insurance_account_id`) REFERENCES `insurance_account` (`insurance_account_id`);

ALTER TABLE `insurance_account` ADD FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`);

ALTER TABLE `repair` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `repair` ADD FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`);

ALTER TABLE `repair` ADD FOREIGN KEY (`hire_agreement_id`) REFERENCES `hire_agreement` (`hire_agreement_id`);

ALTER TABLE `repair` ADD FOREIGN KEY (`vehicle_registration_number`) REFERENCES `vehicle` (`vehicle_registration_number`);

ALTER TABLE `repair` ADD FOREIGN KEY (`fault_report_id`) REFERENCES `fault_report` (`fault_report_id`);

ALTER TABLE `repair` ADD FOREIGN KEY (`insurance_claim_id`) REFERENCES `insurance_claim` (`insurance_claim_id`);

ALTER TABLE `maintenance` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `maintenance` ADD FOREIGN KEY (`client`) REFERENCES `client` (`client_id`);

ALTER TABLE `maintenance` ADD FOREIGN KEY (`vehicle_registration_number`) REFERENCES `vehicle` (`vehicle_registration_number`);
