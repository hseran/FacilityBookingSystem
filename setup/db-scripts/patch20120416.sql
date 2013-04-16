/*
additional columns in booking table
*/
ALTER TABLE `booking_system`.`booking` ADD COLUMN `is_cancelled` BIT NULL DEFAULT 0  AFTER `booking_to` , ADD COLUMN `cancellation_date` TIMESTAMP NULL  AFTER `is_cancelled` ;