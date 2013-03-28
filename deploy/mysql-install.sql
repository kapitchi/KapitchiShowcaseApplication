SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `identity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `identity` ;

CREATE  TABLE IF NOT EXISTS `identity` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` DATETIME NOT NULL ,
  `authEnabled` TINYINT(1)  NOT NULL ,
  `displayName` VARCHAR(128) NULL ,
  `ownerId` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_identity_identity` (`ownerId` ASC) ,
  CONSTRAINT `fk_identity_identity`
    FOREIGN KEY (`ownerId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `identity_auth_credential`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `identity_auth_credential` ;

CREATE  TABLE IF NOT EXISTS `identity_auth_credential` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `identityId` INT UNSIGNED NOT NULL ,
  `enabled` TINYINT(1)  NOT NULL ,
  `username` VARCHAR(64) NOT NULL ,
  `passwordHash` VARCHAR(128) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) ,
  INDEX `fk_identity_auth_credential_identity1` (`identityId` ASC) ,
  CONSTRAINT `fk_identity_auth_credential_identity1`
    FOREIGN KEY (`identityId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `identity_registration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `identity_registration` ;

CREATE  TABLE IF NOT EXISTS `identity_registration` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `requestIp` VARCHAR(39) NOT NULL ,
  `created` DATETIME NOT NULL ,
  `identityId` INT UNSIGNED NULL ,
  `data` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_identity_registration_identity1` (`identityId` ASC) ,
  CONSTRAINT `fk_identity_registration_identity1`
    FOREIGN KEY (`identityId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contact` ;

CREATE  TABLE IF NOT EXISTS `contact` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `typeHandle` VARCHAR(16) NOT NULL ,
  `displayName` VARCHAR(64) NULL ,
  `identityId` INT UNSIGNED NULL ,
  `note` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_contact_identity1` (`identityId` ASC) ,
  CONSTRAINT `fk_contact_identity1`
    FOREIGN KEY (`identityId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contact_individual`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contact_individual` ;

CREATE  TABLE IF NOT EXISTS `contact_individual` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `contactId` INT UNSIGNED NOT NULL ,
  `familyName` VARCHAR(64) NULL ,
  `middleName` VARCHAR(64) NULL ,
  `givenName` VARCHAR(64) NULL ,
  `maidenName` VARCHAR(64) NULL ,
  `honorificPrefix` VARCHAR(16) NULL ,
  `honorificSuffix` VARCHAR(16) NULL ,
  `dob` DATE NULL ,
  `personalId` VARCHAR(64) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_contact_individual_contact1` (`contactId` ASC) ,
  CONSTRAINT `fk_contact_individual_contact1`
    FOREIGN KEY (`contactId` )
    REFERENCES `contact` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `location_division_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `location_division_type` ;

CREATE  TABLE IF NOT EXISTS `location_division_type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `parentId` INT UNSIGNED NULL ,
  `depth` INT NOT NULL ,
  `handle` VARCHAR(32) NOT NULL ,
  `name` VARCHAR(64) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `handle_UNIQUE` (`handle` ASC) ,
  INDEX `fk_location_division_type_location_division_type1` (`parentId` ASC) ,
  CONSTRAINT `fk_location_division_type_location_division_type1`
    FOREIGN KEY (`parentId` )
    REFERENCES `location_division_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `location_division`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `location_division` ;

CREATE  TABLE IF NOT EXISTS `location_division` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `typeId` INT UNSIGNED NOT NULL ,
  `parentId` INT UNSIGNED NULL ,
  `depth` INT UNSIGNED NOT NULL ,
  `code` VARCHAR(16) NULL ,
  `name` VARCHAR(64) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_location_division_location_division1` (`parentId` ASC) ,
  INDEX `fk_location_division_location_division_type1` (`typeId` ASC) ,
  CONSTRAINT `fk_location_division_location_division1`
    FOREIGN KEY (`parentId` )
    REFERENCES `location_division` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_division_location_division_type1`
    FOREIGN KEY (`typeId` )
    REFERENCES `location_division_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `location_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `location_address` ;

CREATE  TABLE IF NOT EXISTS `location_address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `building` TEXT NULL ,
  `floor` TINYINT NULL ,
  `latitude` DECIMAL(9,6)  NULL ,
  `longitude` DECIMAL(9,6)  NULL ,
  `postalCode` VARCHAR(64) NULL ,
  `streetAddress` TEXT NULL ,
  `locality` VARCHAR(128) NULL ,
  `divisionId` INT UNSIGNED NULL ,
  `note` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_location_address_location_division1` (`divisionId` ASC) ,
  CONSTRAINT `fk_location_address_location_division1`
    FOREIGN KEY (`divisionId` )
    REFERENCES `location_division` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auction_auction_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auction_auction_state` ;

CREATE  TABLE IF NOT EXISTS `auction_auction_state` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(128) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auction` ;

CREATE  TABLE IF NOT EXISTS `auction` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `refNumber` VARCHAR(64) NOT NULL ,
  `stateId` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_auction_auction_auction_state1` (`stateId` ASC) ,
  CONSTRAINT `fk_auction_auction_auction_state1`
    FOREIGN KEY (`stateId` )
    REFERENCES `auction_auction_state` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auction_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auction_item` ;

CREATE  TABLE IF NOT EXISTS `auction_item` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `auctionId` INT UNSIGNED NOT NULL ,
  `typeHandle` VARCHAR(64) NOT NULL ,
  `title` TEXT NOT NULL ,
  `description` TEXT NULL ,
  `winningBidderContactId` INT UNSIGNED NULL ,
  `winningBidAmount` DECIMAL(8,2)  NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_auction_item_auction1` (`auctionId` ASC) ,
  INDEX `fk_auction_item_contact1` (`winningBidderContactId` ASC) ,
  CONSTRAINT `fk_auction_item_auction1`
    FOREIGN KEY (`auctionId` )
    REFERENCES `auction` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_auction_item_contact1`
    FOREIGN KEY (`winningBidderContactId` )
    REFERENCES `contact` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auction_round_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auction_round_state` ;

CREATE  TABLE IF NOT EXISTS `auction_round_state` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(128) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auction_round`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auction_round` ;

CREATE  TABLE IF NOT EXISTS `auction_round` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `itemId` INT UNSIGNED NOT NULL ,
  `stateId` INT UNSIGNED NOT NULL ,
  `title` TEXT NULL ,
  `fromTime` DATETIME NULL ,
  `untilTime` DATETIME NULL ,
  `minimumBidAmount` DECIMAL(8,2)  NULL ,
  `reservePrice` DECIMAL(8,2)  NULL ,
  `incrementAmount` DECIMAL(8,2)  NULL ,
  `winningBidAmount` DECIMAL(8,2)  NULL ,
  `registrationDeposit` DECIMAL(8,2)  NULL ,
  `note` TEXT NULL ,
  `venueAddressId` INT UNSIGNED NULL ,
  INDEX `fk_auction_round_auction_item1` (`itemId` ASC) ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_auction_round_auction_round_state1` (`stateId` ASC) ,
  INDEX `fk_auction_round_location_address1` (`venueAddressId` ASC) ,
  CONSTRAINT `fk_auction_round_auction_item1`
    FOREIGN KEY (`itemId` )
    REFERENCES `auction_item` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_auction_round_auction_round_state1`
    FOREIGN KEY (`stateId` )
    REFERENCES `auction_round_state` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_auction_round_location_address1`
    FOREIGN KEY (`venueAddressId` )
    REFERENCES `location_address` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auction_revision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auction_revision` ;

CREATE  TABLE IF NOT EXISTS `auction_revision` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `revisionEntityId` INT UNSIGNED NOT NULL ,
  `revision` INT UNSIGNED NOT NULL DEFAULT 0 ,
  `revisionCreated` DATETIME NOT NULL ,
  `revisionLog` TEXT NULL ,
  `revisionOwnerId` INT UNSIGNED NULL ,
  `refNumber` VARCHAR(64) NOT NULL ,
  `stateId` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_auction_revision_auction1` (`revisionEntityId` ASC) ,
  INDEX `fk_auction_revision_identity1` (`revisionOwnerId` ASC) ,
  CONSTRAINT `fk_auction_revision_auction1`
    FOREIGN KEY (`revisionEntityId` )
    REFERENCES `auction` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_auction_revision_identity1`
    FOREIGN KEY (`revisionOwnerId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auction_round_revision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auction_round_revision` ;

CREATE  TABLE IF NOT EXISTS `auction_round_revision` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `revisionEntityId` INT UNSIGNED NOT NULL ,
  `revision` INT UNSIGNED NOT NULL ,
  `revisionCreated` DATETIME NOT NULL ,
  `revisionLog` TEXT NULL ,
  `revisionOwnerId` INT UNSIGNED NULL ,
  `itemId` INT UNSIGNED NOT NULL ,
  `stateId` INT UNSIGNED NOT NULL ,
  `title` TEXT NULL ,
  `fromTime` DATETIME NULL ,
  `untilTime` DATETIME NULL ,
  `minimumBidAmount` DECIMAL(8,2)  NULL ,
  `reservePrice` DECIMAL(8,2)  NULL ,
  `incrementAmount` DECIMAL(8,2)  NULL ,
  `winningBidAmount` DECIMAL(8,2)  NULL ,
  `registrationDeposit` DECIMAL(8,2)  NULL ,
  `note` TEXT NULL ,
  `venueAddressId` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_auction_round_revision_auction_round1` (`revisionEntityId` ASC) ,
  INDEX `fk_auction_round_revision_identity1` (`revisionOwnerId` ASC) ,
  CONSTRAINT `fk_auction_round_revision_auction_round1`
    FOREIGN KEY (`revisionEntityId` )
    REFERENCES `auction_round` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_auction_round_revision_identity1`
    FOREIGN KEY (`revisionOwnerId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemanager_file`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemanager_file` ;

CREATE  TABLE IF NOT EXISTS `filemanager_file` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `volumeId` VARCHAR(32) NOT NULL ,
  `type` VARCHAR(8) NOT NULL ,
  `name` VARCHAR(128) NOT NULL ,
  `created` DATETIME NOT NULL ,
  `hash` TEXT NULL ,
  `path` TEXT NULL ,
  `mime` VARCHAR(64) NULL ,
  `size` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `log_index`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `log_index` ;

CREATE  TABLE IF NOT EXISTS `log_index` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `typeHandle` VARCHAR(64) NOT NULL ,
  `occured` DATETIME NOT NULL ,
  `data` TEXT NOT NULL ,
  `identityId` INT UNSIGNED NULL ,
  `remoteIp` VARCHAR(16) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_activity_identity1` (`identityId` ASC) ,
  CONSTRAINT `fk_activity_identity1`
    FOREIGN KEY (`identityId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app_plugin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app_plugin` ;

CREATE  TABLE IF NOT EXISTS `app_plugin` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `handle` VARCHAR(128) NOT NULL ,
  `enabled` TINYINT(1)  NOT NULL DEFAULT 0 ,
  `name` VARCHAR(128) NOT NULL ,
  `description` TEXT NULL ,
  `author` VARCHAR(64) NULL ,
  `version` VARCHAR(16) NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `handle_UNIQUE` (`handle` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contact_company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contact_company` ;

CREATE  TABLE IF NOT EXISTS `contact_company` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `contactId` INT UNSIGNED NOT NULL ,
  `name` VARCHAR(128) NULL ,
  `primaryContactId` INT UNSIGNED NULL ,
  `refNumber` VARCHAR(64) NULL ,
  `taxRefNumber` VARCHAR(64) NULL ,
  `taxRegNumber` VARCHAR(64) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_contact_company_contact1` (`contactId` ASC) ,
  INDEX `fk_contact_company_contact2` (`primaryContactId` ASC) ,
  UNIQUE INDEX `contactId_UNIQUE` (`contactId` ASC) ,
  CONSTRAINT `fk_contact_company_contact1`
    FOREIGN KEY (`contactId` )
    REFERENCES `contact` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_company_contact2`
    FOREIGN KEY (`primaryContactId` )
    REFERENCES `contact` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `messenger_message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `messenger_message` ;

CREATE  TABLE IF NOT EXISTS `messenger_message` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `senderId` INT UNSIGNED NOT NULL ,
  `typeHandle` VARCHAR(64) NOT NULL ,
  `sentTime` DATETIME NULL ,
  `subject` TEXT NULL ,
  `body` TEXT NULL ,
  `replyToMessageId` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_messenger_message_identity1` (`senderId` ASC) ,
  INDEX `fk_messenger_message_messenger_message1` (`replyToMessageId` ASC) ,
  CONSTRAINT `fk_messenger_message_identity1`
    FOREIGN KEY (`senderId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messenger_message_messenger_message1`
    FOREIGN KEY (`replyToMessageId` )
    REFERENCES `messenger_message` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calendar` ;

CREATE  TABLE IF NOT EXISTS `calendar` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `handle` VARCHAR(64) NOT NULL ,
  `name` VARCHAR(128) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendar_entry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calendar_entry` ;

CREATE  TABLE IF NOT EXISTS `calendar_entry` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `calendarId` INT UNSIGNED NOT NULL ,
  `typeHandle` VARCHAR(64) NOT NULL ,
  `flag` INT NOT NULL ,
  `fromTime` DATETIME NOT NULL ,
  `untilTime` DATETIME NULL ,
  `data` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_calendar_entry_calendar1` (`calendarId` ASC) ,
  CONSTRAINT `fk_calendar_entry_calendar1`
    FOREIGN KEY (`calendarId` )
    REFERENCES `calendar` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendar_entry_birthday`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calendar_entry_birthday` ;

CREATE  TABLE IF NOT EXISTS `calendar_entry_birthday` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `entryId` INT UNSIGNED NOT NULL ,
  `identityId` INT UNSIGNED NULL ,
  `name` VARCHAR(128) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_calendar_entry_birthday_identity1` (`identityId` ASC) ,
  INDEX `fk_calendar_entry_birthday_calendar_entry1` (`entryId` ASC) ,
  CONSTRAINT `fk_calendar_entry_birthday_identity1`
    FOREIGN KEY (`identityId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_calendar_entry_birthday_calendar_entry1`
    FOREIGN KEY (`entryId` )
    REFERENCES `calendar_entry` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendar_reminder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calendar_reminder` ;

CREATE  TABLE IF NOT EXISTS `calendar_reminder` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `entryId` INT UNSIGNED NOT NULL ,
  `typeHandle` VARCHAR(64) NOT NULL ,
  `timeSpan` INT UNSIGNED NOT NULL ,
  `enabled` TINYINT(1)  NOT NULL ,
  `ownerId` INT UNSIGNED NULL ,
  `triggerTime` DATETIME NULL ,
  `readTime` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_calendar_reminder_calendar_entry1` (`entryId` ASC) ,
  INDEX `fk_calendar_reminder_identity1` (`ownerId` ASC) ,
  CONSTRAINT `fk_calendar_reminder_calendar_entry1`
    FOREIGN KEY (`entryId` )
    REFERENCES `calendar_entry` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_calendar_reminder_identity1`
    FOREIGN KEY (`ownerId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eav`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eav` ;

CREATE  TABLE IF NOT EXISTS `eav` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendar_entry_revision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calendar_entry_revision` ;

CREATE  TABLE IF NOT EXISTS `calendar_entry_revision` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `revisionEntityId` INT UNSIGNED NOT NULL ,
  `revision` INT UNSIGNED NOT NULL ,
  `revisionCreated` DATETIME NOT NULL ,
  `revisionLog` TEXT NULL ,
  `revisionOwnerId` INT UNSIGNED NULL ,
  `calendarId` INT UNSIGNED NOT NULL ,
  `typeHandle` VARCHAR(64) NOT NULL ,
  `flag` INT NOT NULL ,
  `fromTime` DATETIME NOT NULL ,
  `untilTime` DATETIME NULL ,
  `data` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_calendar_entry_revision_calendar_entry1` (`revisionEntityId` ASC) ,
  INDEX `fk_calendar_entry_revision_identity1` (`revisionOwnerId` ASC) ,
  CONSTRAINT `fk_calendar_entry_revision_calendar_entry1`
    FOREIGN KEY (`revisionEntityId` )
    REFERENCES `calendar_entry` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_calendar_entry_revision_identity1`
    FOREIGN KEY (`revisionOwnerId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `realproperty_property_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `realproperty_property_type` ;

CREATE  TABLE IF NOT EXISTS `realproperty_property_type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(128) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `realproperty_property`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `realproperty_property` ;

CREATE  TABLE IF NOT EXISTS `realproperty_property` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `typeId` INT UNSIGNED NOT NULL ,
  `addressId` INT UNSIGNED NOT NULL ,
  `title` VARCHAR(128) NOT NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_realproperty_type1` (`typeId` ASC) ,
  INDEX `fk_realproperty_address1` (`addressId` ASC) ,
  CONSTRAINT `fk_realprop_realproperty_type1`
    FOREIGN KEY (`typeId` )
    REFERENCES `realproperty_property_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_realprop_location_address1`
    FOREIGN KEY (`addressId` )
    REFERENCES `location_address` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auction_item_realproperty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auction_item_realproperty` ;

CREATE  TABLE IF NOT EXISTS `auction_item_realproperty` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `itemId` INT UNSIGNED NOT NULL ,
  `propertyId` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_auction_item_realproperty_auction_item1` (`itemId` ASC) ,
  INDEX `fk_auction_item_realproperty_realproperty1` (`propertyId` ASC) ,
  CONSTRAINT `fk_auction_item_realproperty_auction_item1`
    FOREIGN KEY (`itemId` )
    REFERENCES `auction_item` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_auction_item_realproperty_realproperty1`
    FOREIGN KEY (`propertyId` )
    REFERENCES `realproperty_property` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `messenger_delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `messenger_delivery` ;

CREATE  TABLE IF NOT EXISTS `messenger_delivery` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `ownerId` INT UNSIGNED NOT NULL ,
  `messageId` INT UNSIGNED NOT NULL ,
  `receivedTime` DATETIME NULL ,
  `readTime` DATETIME NULL ,
  INDEX `fk_messenger_message_recipient_messenger_message1` (`messageId` ASC) ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_messenger_delivery_identity1` (`ownerId` ASC) ,
  CONSTRAINT `fk_messenger_message_recipient_messenger_message1`
    FOREIGN KEY (`messageId` )
    REFERENCES `messenger_message` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messenger_delivery_identity1`
    FOREIGN KEY (`ownerId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `security_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `security_role` ;

CREATE  TABLE IF NOT EXISTS `security_role` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `handle` VARCHAR(32) NOT NULL ,
  `name` VARCHAR(128) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `security_identity_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `security_identity_role` ;

CREATE  TABLE IF NOT EXISTS `security_identity_role` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `identityId` INT UNSIGNED NOT NULL ,
  `roleId` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_security_identity_role_identity1` (`identityId` ASC) ,
  INDEX `fk_security_identity_role_security_role1` (`roleId` ASC) ,
  CONSTRAINT `fk_security_identity_role_identity1`
    FOREIGN KEY (`identityId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_security_identity_role_security_role1`
    FOREIGN KEY (`roleId` )
    REFERENCES `security_role` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `security_rule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `security_rule` ;

CREATE  TABLE IF NOT EXISTS `security_rule` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `role` VARCHAR(64) NOT NULL ,
  `resourceId` VARCHAR(128) NOT NULL ,
  `privilege` VARCHAR(64) NULL ,
  `resourceDomain` VARCHAR(128) NOT NULL ,
  `type` ENUM('allow','deny') NOT NULL ,
  `entityId` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contact_storage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contact_storage` ;

CREATE  TABLE IF NOT EXISTS `contact_storage` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `contactId` INT UNSIGNED NOT NULL ,
  `handle` VARCHAR(32) NOT NULL ,
  `tag` VARCHAR(32) NOT NULL ,
  `priority` INT NOT NULL ,
  `value` TEXT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_contact_email_contact1` (`contactId` ASC) ,
  CONSTRAINT `fk_contact_email_contact1`
    FOREIGN KEY (`contactId` )
    REFERENCES `contact` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poll`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `poll` ;

CREATE  TABLE IF NOT EXISTS `poll` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poll_option`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `poll_option` ;

CREATE  TABLE IF NOT EXISTS `poll_option` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `pollId` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_poll_options_poll1_idx` (`pollId` ASC) ,
  CONSTRAINT `fk_poll_options_poll1`
    FOREIGN KEY (`pollId` )
    REFERENCES `poll` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poll_answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `poll_answer` ;

CREATE  TABLE IF NOT EXISTS `poll_answer` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `optionId` INT UNSIGNED NOT NULL ,
  `identityId` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_poll_answer_poll_option1_idx` (`optionId` ASC) ,
  INDEX `fk_poll_answer_identity1_idx` (`identityId` ASC) ,
  CONSTRAINT `fk_poll_answer_poll_option1`
    FOREIGN KEY (`optionId` )
    REFERENCES `poll_option` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_poll_answer_identity1`
    FOREIGN KEY (`identityId` )
    REFERENCES `identity` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `identity`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO identity (`id`, `created`, `authEnabled`, `displayName`, `ownerId`) VALUES ('1', '2012-01-01 00:00:00', 1, 'Root', NULL);
INSERT INTO identity (`id`, `created`, `authEnabled`, `displayName`, `ownerId`) VALUES ('2', '2012-01-01 00:00:00', 1, 'Admin', NULL);
INSERT INTO identity (`id`, `created`, `authEnabled`, `displayName`, `ownerId`) VALUES ('3', '2012-01-01 00:00:00', 1, 'Staff', NULL);
INSERT INTO identity (`id`, `created`, `authEnabled`, `displayName`, `ownerId`) VALUES ('4', '2012-01-01 00:00:00', 1, 'Lender', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `identity_auth_credential`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO identity_auth_credential (`id`, `identityId`, `enabled`, `username`, `passwordHash`) VALUES ('1', '1', 1, 'root', '$2y$14$dGhpcy1zaG91bGQtYmUtYOyY9ynQQ60W9zTK4syrB013ASYa0bGHG');
INSERT INTO identity_auth_credential (`id`, `identityId`, `enabled`, `username`, `passwordHash`) VALUES ('2', '2', 1, 'admin', '$2y$14$dGhpcy1zaG91bGQtYmUtYOyY9ynQQ60W9zTK4syrB013ASYa0bGHG');
INSERT INTO identity_auth_credential (`id`, `identityId`, `enabled`, `username`, `passwordHash`) VALUES ('3', '3', 1, 'staff', '$2y$14$dGhpcy1zaG91bGQtYmUtYOyY9ynQQ60W9zTK4syrB013ASYa0bGHG');
INSERT INTO identity_auth_credential (`id`, `identityId`, `enabled`, `username`, `passwordHash`) VALUES ('4', '4', 1, 'lender', '$2y$14$dGhpcy1zaG91bGQtYmUtYOyY9ynQQ60W9zTK4syrB013ASYa0bGHG');

COMMIT;

-- -----------------------------------------------------
-- Data for table `contact`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO contact (`id`, `typeHandle`, `displayName`, `identityId`, `note`) VALUES ('1', 'individual', 'Matus Zeman', '2', NULL);
INSERT INTO contact (`id`, `typeHandle`, `displayName`, `identityId`, `note`) VALUES ('2', 'company', 'Kapitchi Ltd.', NULL, NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `contact_individual`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO contact_individual (`id`, `contactId`, `familyName`, `middleName`, `givenName`, `maidenName`, `honorificPrefix`, `honorificSuffix`, `dob`, `personalId`) VALUES ('1', '1', 'Zeman', NULL, 'Matus', NULL, 'MSc.', NULL, '1982-12-28', '821228/6104');

COMMIT;

-- -----------------------------------------------------
-- Data for table `location_division_type`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO location_division_type (`id`, `parentId`, `depth`, `handle`, `name`) VALUES ('1', NULL, '0', 'country', 'Country');
INSERT INTO location_division_type (`id`, `parentId`, `depth`, `handle`, `name`) VALUES ('2', '1', '1', 'state', 'State');

COMMIT;

-- -----------------------------------------------------
-- Data for table `location_division`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO location_division (`id`, `typeId`, `parentId`, `depth`, `code`, `name`) VALUES ('1', '1', NULL, '0', 'GBR', 'United Kingdom');
INSERT INTO location_division (`id`, `typeId`, `parentId`, `depth`, `code`, `name`) VALUES ('2', '1', NULL, '0', 'USA', 'United States');
INSERT INTO location_division (`id`, `typeId`, `parentId`, `depth`, `code`, `name`) VALUES ('3', '1', NULL, '0', 'SVK', 'Slovakia');
INSERT INTO location_division (`id`, `typeId`, `parentId`, `depth`, `code`, `name`) VALUES ('4', '2', '2', '1', 'AL', 'Alabama');
INSERT INTO location_division (`id`, `typeId`, `parentId`, `depth`, `code`, `name`) VALUES ('5', '2', '2', '1', 'AK', 'Alaska');

COMMIT;

-- -----------------------------------------------------
-- Data for table `location_address`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO location_address (`id`, `building`, `floor`, `latitude`, `longitude`, `postalCode`, `streetAddress`, `locality`, `divisionId`, `note`) VALUES ('1', 'Number 10', '1', NULL, NULL, 'SW1A 2AA', '10 Downing Street', 'London', '1', NULL);
INSERT INTO location_address (`id`, `building`, `floor`, `latitude`, `longitude`, `postalCode`, `streetAddress`, `locality`, `divisionId`, `note`) VALUES ('2', NULL, NULL, NULL, NULL, 'EN1 2BT', '18 Fawersham Ave.', 'London', '2', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `auction_auction_state`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO auction_auction_state (`id`, `label`) VALUES ('1', 'Aktivna');
INSERT INTO auction_auction_state (`id`, `label`) VALUES ('2', 'Pozastavena');
INSERT INTO auction_auction_state (`id`, `label`) VALUES ('3', 'Ukoncena');
INSERT INTO auction_auction_state (`id`, `label`) VALUES ('4', 'Este nezacata');

COMMIT;

-- -----------------------------------------------------
-- Data for table `auction`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO auction (`id`, `refNumber`, `stateId`) VALUES ('1', '1111', '1');
INSERT INTO auction (`id`, `refNumber`, `stateId`) VALUES ('2', '112233', '1');

COMMIT;

-- -----------------------------------------------------
-- Data for table `auction_item`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO auction_item (`id`, `auctionId`, `typeHandle`, `title`, `description`, `winningBidderContactId`, `winningBidAmount`) VALUES ('1', '1', 'personalproperty', 'GoPro Camera', 'My best ever cam', '1', 100);
INSERT INTO auction_item (`id`, `auctionId`, `typeHandle`, `title`, `description`, `winningBidderContactId`, `winningBidAmount`) VALUES ('2', '1', 'realproperty', 'Your House', 'Hot area family house', '2', 100000);
INSERT INTO auction_item (`id`, `auctionId`, `typeHandle`, `title`, `description`, `winningBidderContactId`, `winningBidAmount`) VALUES ('3', '2', 'realproperty', 'Mum\'s house', 'Better not!', NULL, NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `auction_round_state`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO auction_round_state (`id`, `label`) VALUES ('1', 'Vyhotovene oznamenie o drazbe');
INSERT INTO auction_round_state (`id`, `label`) VALUES ('2', 'Vydrazene');
INSERT INTO auction_round_state (`id`, `label`) VALUES ('3', 'Doplateny zvysok ceny dosiahnutej pri vydrazeni');
INSERT INTO auction_round_state (`id`, `label`) VALUES ('4', 'Predmet drazby odovzdany');
INSERT INTO auction_round_state (`id`, `label`) VALUES ('5', 'Neúspešná dražba');
INSERT INTO auction_round_state (`id`, `label`) VALUES ('6', 'Upustené od dražby');

COMMIT;

-- -----------------------------------------------------
-- Data for table `auction_round`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO auction_round (`id`, `itemId`, `stateId`, `title`, `fromTime`, `untilTime`, `minimumBidAmount`, `reservePrice`, `incrementAmount`, `winningBidAmount`, `registrationDeposit`, `note`, `venueAddressId`) VALUES ('1', '1', '1', 'ROUND1', '2012-07-20 12:00:00', NULL, 50, 70, 1, NULL, 10, NULL, '1');
INSERT INTO auction_round (`id`, `itemId`, `stateId`, `title`, `fromTime`, `untilTime`, `minimumBidAmount`, `reservePrice`, `incrementAmount`, `winningBidAmount`, `registrationDeposit`, `note`, `venueAddressId`) VALUES ('2', '1', '2', 'ROUND2', '2012-08-20 12:00:00', NULL, 50000, 50000, 5000, NULL, 5000, NULL, '1');

COMMIT;

-- -----------------------------------------------------
-- Data for table `auction_revision`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO auction_revision (`id`, `revisionEntityId`, `revision`, `revisionCreated`, `revisionLog`, `revisionOwnerId`, `refNumber`, `stateId`) VALUES ('1', '1', '1', '2012-07-16 12:00:00', 'This is log for rev1', NULL, '1111', '2');
INSERT INTO auction_revision (`id`, `revisionEntityId`, `revision`, `revisionCreated`, `revisionLog`, `revisionOwnerId`, `refNumber`, `stateId`) VALUES ('2', '1', '2', '2012-07-16 13:00:00', 'Rev2 log', NULL, '1111', '3');

COMMIT;

-- -----------------------------------------------------
-- Data for table `filemanager_file`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO filemanager_file (`id`, `volumeId`, `type`, `name`, `created`, `hash`, `path`, `mime`, `size`) VALUES ('1', 'protected', 'file', 'test.jpg', '2012-12-12 12:00:00', NULL, 'test.jpg', 'image/jpeg', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `contact_company`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO contact_company (`id`, `contactId`, `name`, `primaryContactId`, `refNumber`, `taxRefNumber`, `taxRegNumber`) VALUES ('1', '2', 'Kapitchi Ltd.', '1', '12345', '56789', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `messenger_message`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO messenger_message (`id`, `senderId`, `typeHandle`, `sentTime`, `subject`, `body`, `replyToMessageId`) VALUES ('1', '1', 'plain', '2012-01-01 12:00:00', 'Test message to root', 'Message body', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `calendar`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO calendar (`id`, `handle`, `name`) VALUES ('1', 'default', 'Default calendar');
INSERT INTO calendar (`id`, `handle`, `name`) VALUES ('2', 'todo', 'TODO');

COMMIT;

-- -----------------------------------------------------
-- Data for table `calendar_entry`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO calendar_entry (`id`, `calendarId`, `typeHandle`, `flag`, `fromTime`, `untilTime`, `data`) VALUES ('1', '1', 'birthday', '0', '2012-04-28 00:00:00', NULL, NULL);
INSERT INTO calendar_entry (`id`, `calendarId`, `typeHandle`, `flag`, `fromTime`, `untilTime`, `data`) VALUES ('2', '1', 'event', '0', '2012-12-24 18:00:00', '2012-12-24 20:00:00', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `calendar_entry_birthday`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO calendar_entry_birthday (`id`, `entryId`, `identityId`, `name`) VALUES ('1', '1', '1', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `calendar_reminder`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO calendar_reminder (`id`, `entryId`, `typeHandle`, `timeSpan`, `enabled`, `ownerId`, `triggerTime`, `readTime`) VALUES ('1', '2', 'ui', '525949', 1, NULL, NULL, NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `realproperty_property_type`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO realproperty_property_type (`id`, `label`) VALUES ('1', 'Byt');
INSERT INTO realproperty_property_type (`id`, `label`) VALUES ('2', 'Rodinny dom');
INSERT INTO realproperty_property_type (`id`, `label`) VALUES ('3', 'Pozemok');
INSERT INTO realproperty_property_type (`id`, `label`) VALUES ('4', 'Rekreacny objekt');

COMMIT;

-- -----------------------------------------------------
-- Data for table `realproperty_property`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO realproperty_property (`id`, `typeId`, `addressId`, `title`, `description`) VALUES ('1', '1', '1', 'My property', NULL);
INSERT INTO realproperty_property (`id`, `typeId`, `addressId`, `title`, `description`) VALUES ('2', '1', '2', 'Mum\'s house', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `auction_item_realproperty`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO auction_item_realproperty (`id`, `itemId`, `propertyId`) VALUES ('1', '2', '1');
INSERT INTO auction_item_realproperty (`id`, `itemId`, `propertyId`) VALUES ('2', '3', '2');

COMMIT;

-- -----------------------------------------------------
-- Data for table `messenger_delivery`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO messenger_delivery (`id`, `ownerId`, `messageId`, `receivedTime`, `readTime`) VALUES ('1', '1', '1', '2012-01-01 12:00:00', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `security_role`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO security_role (`id`, `handle`, `name`) VALUES ('1', 'anonymous', 'Anonymous');
INSERT INTO security_role (`id`, `handle`, `name`) VALUES ('2', 'root', 'Root');
INSERT INTO security_role (`id`, `handle`, `name`) VALUES ('3', 'admin', 'Admin');
INSERT INTO security_role (`id`, `handle`, `name`) VALUES ('4', 'staff', 'Staff');
INSERT INTO security_role (`id`, `handle`, `name`) VALUES ('5', 'lender', 'Lender');

COMMIT;

-- -----------------------------------------------------
-- Data for table `security_identity_role`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO security_identity_role (`id`, `identityId`, `roleId`) VALUES ('1', '1', '2');
INSERT INTO security_identity_role (`id`, `identityId`, `roleId`) VALUES ('2', '2', '3');
INSERT INTO security_identity_role (`id`, `identityId`, `roleId`) VALUES ('3', '3', '4');
INSERT INTO security_identity_role (`id`, `identityId`, `roleId`) VALUES ('4', '4', '5');

COMMIT;

-- -----------------------------------------------------
-- Data for table `security_rule`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO security_rule (`id`, `role`, `resourceId`, `privilege`, `resourceDomain`, `type`, `entityId`) VALUES ('1', 'auction-admin:1', 'auction/auction:1', 'read', 'auction/auction', 'allow', '1');
INSERT INTO security_rule (`id`, `role`, `resourceId`, `privilege`, `resourceDomain`, `type`, `entityId`) VALUES ('2', 'auction-admin:1', 'auction/round:1', 'read', 'auction/round', 'allow', '1');
INSERT INTO security_rule (`id`, `role`, `resourceId`, `privilege`, `resourceDomain`, `type`, `entityId`) VALUES ('3', 'auction-admin:1', 'auction/round:2', 'read', 'auction/round', 'allow', '2');

COMMIT;

-- -----------------------------------------------------
-- Data for table `contact_storage`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO contact_storage (`id`, `contactId`, `handle`, `tag`, `priority`, `value`) VALUES ('1', '1', 'email', 'personal', '1', 'matus.zeman@gmail.com');
INSERT INTO contact_storage (`id`, `contactId`, `handle`, `tag`, `priority`, `value`) VALUES ('2', '1', 'email', 'work', '2', 'mz@kapitchi.com');
INSERT INTO contact_storage (`id`, `contactId`, `handle`, `tag`, `priority`, `value`) VALUES ('3', '1', 'phone', 'work', '3', '071234567');

COMMIT;

-- -----------------------------------------------------
-- Data for table `poll`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO poll (`id`) VALUES ('1');

COMMIT;

-- -----------------------------------------------------
-- Data for table `poll_option`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO poll_option (`id`, `name`, `pollId`) VALUES ('1', 'aaa', '1');
INSERT INTO poll_option (`id`, `name`, `pollId`) VALUES ('2', 'bbb', '1');
INSERT INTO poll_option (`id`, `name`, `pollId`) VALUES ('3', 'ccc', '1');

COMMIT;

-- -----------------------------------------------------
-- Data for table `poll_answer`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO poll_answer (`id`, `optionId`, `identityId`) VALUES ('1', '1', '1');
INSERT INTO poll_answer (`id`, `optionId`, `identityId`) VALUES ('2', '2', '2');
INSERT INTO poll_answer (`id`, `optionId`, `identityId`) VALUES ('3', '3', '3');

COMMIT;
