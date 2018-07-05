CREATE DATABASE  IF NOT EXISTS `bonita` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bonita`;


-- MySQL dump 10.13  Distrib 5.5.46, for Linux (x86_64)
--
-- Host: localhost    Database: bonita
-- ------------------------------------------------------
-- Server version	5.5.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `QRTZ_BLOB_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` mediumblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_CALENDARS`
--

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_CALENDARS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` mediumblob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_CRON_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `FK_QRTZ_CRON_TRIGGERS_QRTZ_TRIGGERS` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_FIRED_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(20) NOT NULL,
  `SCHED_TIME` bigint(20) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` tinyint(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_JOB_DETAILS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` tinyint(1) NOT NULL,
  `IS_NONCONCURRENT` tinyint(1) NOT NULL,
  `IS_UPDATE_DATA` tinyint(1) NOT NULL,
  `REQUESTS_RECOVERY` tinyint(1) NOT NULL,
  `JOB_DATA` mediumblob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_LOCKS`
--

DROP TABLE IF EXISTS `QRTZ_LOCKS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_LOCKS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(20) NOT NULL,
  `CHECKIN_INTERVAL` bigint(20) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_SIMPLE_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(20) NOT NULL,
  `REPEAT_INTERVAL` bigint(20) NOT NULL,
  `TIMES_TRIGGERED` bigint(20) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `FK_QRTZ_SIMPLE_TRIGGERS_QRTZ_TRIGGERS` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_SIMPROP_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` tinyint(1) DEFAULT NULL,
  `BOOL_PROP_2` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `FK_QRTZ_SIMPROP_TRIGGERS_QRTZ_TRIGGERS` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QRTZ_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(20) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(20) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(20) NOT NULL,
  `END_TIME` bigint(20) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(6) DEFAULT NULL,
  `JOB_DATA` mediumblob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `FK_QRTZ_TRIGGERS_QRTZ_JOB_DETAILS` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `actor`
--

DROP TABLE IF EXISTS `actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actor` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `scopeId` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `displayName` varchar(75) DEFAULT NULL,
  `description` text,
  `initiator` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`id`,`scopeId`,`name`),
  CONSTRAINT `fk_actor_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `actormember`
--

DROP TABLE IF EXISTS `actormember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actormember` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `actorId` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `groupId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`actorId`,`userId`,`groupId`,`roleId`),
  CONSTRAINT `fk_actormember_actorId` FOREIGN KEY (`tenantid`, `actorId`) REFERENCES `actor` (`tenantid`, `id`),
  CONSTRAINT `fk_actormember_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arch_connector_instance`
--

DROP TABLE IF EXISTS `arch_connector_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arch_connector_instance` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `containerId` bigint(20) NOT NULL,
  `containerType` varchar(10) NOT NULL,
  `connectorId` varchar(255) NOT NULL,
  `version` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `activationEvent` varchar(30) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `sourceObjectId` bigint(20) DEFAULT NULL,
  `archiveDate` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `idx1_arch_connector_instance` (`tenantid`,`containerId`,`containerType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arch_contract_data`
--

DROP TABLE IF EXISTS `arch_contract_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arch_contract_data` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `kind` varchar(20) NOT NULL,
  `scopeId` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `val` longblob,
  `archiveDate` bigint(20) NOT NULL,
  `sourceObjectId` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`,`scopeId`),
  UNIQUE KEY `uc_acd_scope_name` (`kind`,`scopeId`,`name`,`tenantid`),
  KEY `idx_acd_scope_name` (`kind`,`scopeId`,`name`,`tenantid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arch_data_instance`
--

DROP TABLE IF EXISTS `arch_data_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arch_data_instance` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `transientData` tinyint(1) DEFAULT NULL,
  `className` varchar(100) DEFAULT NULL,
  `containerId` bigint(20) DEFAULT NULL,
  `containerType` varchar(60) DEFAULT NULL,
  `namespace` varchar(100) DEFAULT NULL,
  `element` varchar(60) DEFAULT NULL,
  `intValue` int(11) DEFAULT NULL,
  `longValue` bigint(20) DEFAULT NULL,
  `shortTextValue` varchar(255) DEFAULT NULL,
  `booleanValue` tinyint(1) DEFAULT NULL,
  `doubleValue` decimal(19,5) DEFAULT NULL,
  `floatValue` float DEFAULT NULL,
  `blobValue` mediumblob,
  `clobValue` mediumtext,
  `discriminant` varchar(50) NOT NULL,
  `archiveDate` bigint(20) NOT NULL,
  `sourceObjectId` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantId`,`id`),
  KEY `idx1_arch_data_instance` (`tenantId`,`containerId`,`containerType`,`archiveDate`,`name`,`sourceObjectId`),
  KEY `idx2_arch_data_instance` (`sourceObjectId`,`containerId`,`archiveDate`,`id`,`tenantId`),
  CONSTRAINT `fk_arch_data_instance_tenantId` FOREIGN KEY (`tenantId`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arch_document_mapping`
--

DROP TABLE IF EXISTS `arch_document_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arch_document_mapping` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `sourceObjectId` bigint(20) DEFAULT NULL,
  `processinstanceid` bigint(20) NOT NULL,
  `documentid` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `version` varchar(10) NOT NULL,
  `index_` int(11) NOT NULL,
  `archiveDate` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `idx_a_doc_mp_pr_id` (`processinstanceid`,`tenantid`),
  KEY `fk_archdocmap_docid` (`tenantid`,`documentid`),
  CONSTRAINT `fk_archdocmap_docid` FOREIGN KEY (`tenantid`, `documentid`) REFERENCES `document` (`tenantid`, `id`) ON DELETE CASCADE,
  CONSTRAINT `fk_arch_document_mapping_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arch_flownode_instance`
--

DROP TABLE IF EXISTS `arch_flownode_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arch_flownode_instance` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `flownodeDefinitionId` bigint(20) NOT NULL,
  `kind` varchar(25) NOT NULL,
  `sourceObjectId` bigint(20) DEFAULT NULL,
  `archiveDate` bigint(20) NOT NULL,
  `rootContainerId` bigint(20) NOT NULL,
  `parentContainerId` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `displayName` varchar(255) DEFAULT NULL,
  `displayDescription` varchar(255) DEFAULT NULL,
  `stateId` int(11) NOT NULL,
  `stateName` varchar(50) DEFAULT NULL,
  `terminal` tinyint(1) NOT NULL,
  `stable` tinyint(1) DEFAULT NULL,
  `actorId` bigint(20) DEFAULT NULL,
  `assigneeId` bigint(20) NOT NULL DEFAULT '0',
  `reachedStateDate` bigint(20) DEFAULT NULL,
  `lastUpdateDate` bigint(20) DEFAULT NULL,
  `expectedEndDate` bigint(20) DEFAULT NULL,
  `claimedDate` bigint(20) DEFAULT NULL,
  `priority` tinyint(4) DEFAULT NULL,
  `gatewayType` varchar(50) DEFAULT NULL,
  `hitBys` varchar(255) DEFAULT NULL,
  `logicalGroup1` bigint(20) NOT NULL,
  `logicalGroup2` bigint(20) NOT NULL,
  `logicalGroup3` bigint(20) DEFAULT NULL,
  `logicalGroup4` bigint(20) NOT NULL,
  `loop_counter` int(11) DEFAULT NULL,
  `loop_max` int(11) DEFAULT NULL,
  `loopCardinality` int(11) DEFAULT NULL,
  `loopDataInputRef` varchar(255) DEFAULT NULL,
  `loopDataOutputRef` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sequential` tinyint(1) DEFAULT NULL,
  `dataInputItemRef` varchar(255) DEFAULT NULL,
  `dataOutputItemRef` varchar(255) DEFAULT NULL,
  `nbActiveInst` int(11) DEFAULT NULL,
  `nbCompletedInst` int(11) DEFAULT NULL,
  `nbTerminatedInst` int(11) DEFAULT NULL,
  `executedBy` bigint(20) DEFAULT NULL,
  `executedBySubstitute` bigint(20) DEFAULT NULL,
  `activityInstanceId` bigint(20) DEFAULT NULL,
  `aborting` tinyint(1) NOT NULL,
  `triggeredByEvent` tinyint(1) DEFAULT NULL,
  `interrupting` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `idx_afi_kind_lg2_executedBy` (`kind`,`logicalGroup2`,`executedBy`),
  KEY `idx_afi_sourceId_tenantid_kind` (`sourceObjectId`,`tenantid`,`kind`),
  KEY `idx1_arch_flownode_instance` (`tenantid`,`rootContainerId`,`parentContainerId`),
  CONSTRAINT `fk_arch_flownode_instance_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arch_process_comment`
--

DROP TABLE IF EXISTS `arch_process_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arch_process_comment` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `processInstanceId` bigint(20) NOT NULL,
  `postDate` bigint(20) NOT NULL,
  `content` varchar(512) NOT NULL,
  `archiveDate` bigint(20) NOT NULL,
  `sourceObjectId` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `idx1_arch_process_comment` (`tenantid`,`sourceObjectId`),
  KEY `idx2_arch_process_comment` (`processInstanceId`,`archiveDate`,`tenantid`),
  CONSTRAINT `fk_arch_process_comment_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arch_process_instance`
--

DROP TABLE IF EXISTS `arch_process_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arch_process_instance` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(75) NOT NULL,
  `processDefinitionId` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `startDate` bigint(20) NOT NULL,
  `startedBy` bigint(20) NOT NULL,
  `startedBySubstitute` bigint(20) NOT NULL,
  `endDate` bigint(20) NOT NULL,
  `archiveDate` bigint(20) NOT NULL,
  `stateId` int(11) NOT NULL,
  `lastUpdate` bigint(20) NOT NULL,
  `rootProcessInstanceId` bigint(20) DEFAULT NULL,
  `callerId` bigint(20) DEFAULT NULL,
  `sourceObjectId` bigint(20) NOT NULL,
  `stringIndex1` varchar(255) DEFAULT NULL,
  `stringIndex2` varchar(255) DEFAULT NULL,
  `stringIndex3` varchar(255) DEFAULT NULL,
  `stringIndex4` varchar(255) DEFAULT NULL,
  `stringIndex5` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `idx1_arch_process_instance` (`tenantid`,`sourceObjectId`,`rootProcessInstanceId`,`callerId`),
  KEY `idx2_arch_process_instance` (`tenantid`,`processDefinitionId`,`archiveDate`),
  KEY `idx3_arch_process_instance` (`tenantid`,`sourceObjectId`,`callerId`,`stateId`),
  CONSTRAINT `fk_arch_process_instance_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blob_`
--

DROP TABLE IF EXISTS `blob_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blob_` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `blobValue` mediumblob,
  PRIMARY KEY (`tenantId`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_app`
--

DROP TABLE IF EXISTS `business_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_app` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `token` varchar(50) NOT NULL,
  `version` varchar(50) NOT NULL,
  `description` text,
  `iconPath` varchar(255) DEFAULT NULL,
  `creationDate` bigint(20) NOT NULL,
  `createdBy` bigint(20) NOT NULL,
  `lastUpdateDate` bigint(20) NOT NULL,
  `updatedBy` bigint(20) NOT NULL,
  `state` varchar(30) NOT NULL,
  `homePageId` bigint(20) DEFAULT NULL,
  `profileId` bigint(20) DEFAULT NULL,
  `layoutId` bigint(20) DEFAULT NULL,
  `themeId` bigint(20) DEFAULT NULL,
  `displayName` varchar(255) NOT NULL,
  PRIMARY KEY (`tenantId`,`id`),
  UNIQUE KEY `uk_app_token_version` (`tenantId`,`token`,`version`),
  KEY `idx_app_token` (`token`,`tenantId`),
  KEY `idx_app_profile` (`profileId`,`tenantId`),
  KEY `idx_app_homepage` (`homePageId`,`tenantId`),
  KEY `fk_app_profileId` (`tenantId`,`profileId`),
  KEY `fk_app_layoutId` (`tenantId`,`layoutId`),
  KEY `fk_app_themeId` (`tenantId`,`themeId`),
  CONSTRAINT `fk_app_layoutId` FOREIGN KEY (`tenantId`, `layoutId`) REFERENCES `page` (`tenantId`, `id`),
  CONSTRAINT `fk_app_profileId` FOREIGN KEY (`tenantId`, `profileId`) REFERENCES `profile` (`tenantId`, `id`),
  CONSTRAINT `fk_app_tenantId` FOREIGN KEY (`tenantId`) REFERENCES `tenant` (`id`),
  CONSTRAINT `fk_app_themeId` FOREIGN KEY (`tenantId`, `themeId`) REFERENCES `page` (`tenantId`, `id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_app_menu`
--

DROP TABLE IF EXISTS `business_app_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_app_menu` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `displayName` varchar(255) NOT NULL,
  `applicationId` bigint(20) NOT NULL,
  `applicationPageId` bigint(20) DEFAULT NULL,
  `parentId` bigint(20) DEFAULT NULL,
  `index_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tenantId`,`id`),
  KEY `idx_app_menu_app` (`applicationId`,`tenantId`),
  KEY `idx_app_menu_page` (`applicationPageId`,`tenantId`),
  KEY `idx_app_menu_parent` (`parentId`,`tenantId`),
  KEY `fk_app_menu_appId` (`tenantId`,`applicationId`),
  KEY `fk_app_menu_pageId` (`tenantId`,`applicationPageId`),
  KEY `fk_app_menu_parentId` (`tenantId`,`parentId`),
  CONSTRAINT `fk_app_menu_appId` FOREIGN KEY (`tenantId`, `applicationId`) REFERENCES `business_app` (`tenantId`, `id`),
  CONSTRAINT `fk_app_menu_pageId` FOREIGN KEY (`tenantId`, `applicationPageId`) REFERENCES `business_app_page` (`tenantId`, `id`),
  CONSTRAINT `fk_app_menu_parentId` FOREIGN KEY (`tenantId`, `parentId`) REFERENCES `business_app_menu` (`tenantId`, `id`),
  CONSTRAINT `fk_app_menu_tenantId` FOREIGN KEY (`tenantId`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_app_page`
--

DROP TABLE IF EXISTS `business_app_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_app_page` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `applicationId` bigint(20) NOT NULL,
  `pageId` bigint(20) NOT NULL,
  `token` varchar(255) NOT NULL,
  PRIMARY KEY (`tenantId`,`id`),
  UNIQUE KEY `uk_app_page_appId_token` (`tenantId`,`applicationId`,`token`),
  KEY `idx_app_page_token` (`applicationId`,`token`,`tenantId`),
  KEY `idx_app_page_pageId` (`pageId`,`tenantId`),
  KEY `fk_page_id` (`tenantId`,`pageId`),
  CONSTRAINT `fk_app_page_tenantId` FOREIGN KEY (`tenantId`) REFERENCES `tenant` (`id`),
  CONSTRAINT `fk_bus_app_id` FOREIGN KEY (`tenantId`, `applicationId`) REFERENCES `business_app` (`tenantId`, `id`) ON DELETE CASCADE,
  CONSTRAINT `fk_page_id` FOREIGN KEY (`tenantId`, `pageId`) REFERENCES `page` (`tenantId`, `id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `creator` bigint(20) DEFAULT NULL,
  `description` text,
  `creationDate` bigint(20) NOT NULL,
  `lastUpdateDate` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`name`),
  CONSTRAINT `fk_category_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `command`
--

DROP TABLE IF EXISTS `command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `IMPLEMENTATION` varchar(100) NOT NULL,
  `system` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`name`),
  CONSTRAINT `fk_command_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connector_instance`
--

DROP TABLE IF EXISTS `connector_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `connector_instance` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `containerId` bigint(20) NOT NULL,
  `containerType` varchar(10) NOT NULL,
  `connectorId` varchar(255) NOT NULL,
  `version` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `activationEvent` varchar(30) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `executionOrder` int(11) DEFAULT NULL,
  `exceptionMessage` varchar(255) DEFAULT NULL,
  `stackTrace` text,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `idx_ci_container_activation` (`tenantid`,`containerId`,`containerType`,`activationEvent`),
  CONSTRAINT `fk_connector_instance_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contract_data`
--

DROP TABLE IF EXISTS `contract_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract_data` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `kind` varchar(20) NOT NULL,
  `scopeId` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `val` longblob,
  PRIMARY KEY (`tenantid`,`id`,`scopeId`),
  UNIQUE KEY `uc_cd_scope_name` (`kind`,`scopeId`,`name`,`tenantid`),
  KEY `idx_cd_scope_name` (`kind`,`scopeId`,`name`,`tenantid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_usr_inf_def`
--

DROP TABLE IF EXISTS `custom_usr_inf_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_usr_inf_def` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(75) NOT NULL,
  `description` text,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`name`),
  KEY `idx_custom_usr_inf_def_name` (`tenantid`,`name`),
  CONSTRAINT `fk_custom_usr_inf_def_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_usr_inf_val`
--

DROP TABLE IF EXISTS `custom_usr_inf_val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_usr_inf_val` (
  `id` bigint(20) NOT NULL,
  `tenantid` bigint(20) NOT NULL,
  `definitionId` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`definitionId`,`userId`),
  KEY `fk_user_id` (`tenantid`,`userId`),
  CONSTRAINT `fk_custom_usr_inf_val_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`),
  CONSTRAINT `fk_definition_id` FOREIGN KEY (`tenantid`, `definitionId`) REFERENCES `custom_usr_inf_def` (`tenantid`, `id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`tenantid`, `userId`) REFERENCES `user_` (`tenantid`, `id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_instance`
--

DROP TABLE IF EXISTS `data_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_instance` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `transientData` tinyint(1) DEFAULT NULL,
  `className` varchar(100) DEFAULT NULL,
  `containerId` bigint(20) DEFAULT NULL,
  `containerType` varchar(60) DEFAULT NULL,
  `namespace` varchar(100) DEFAULT NULL,
  `element` varchar(60) DEFAULT NULL,
  `intValue` int(11) DEFAULT NULL,
  `longValue` bigint(20) DEFAULT NULL,
  `shortTextValue` varchar(255) DEFAULT NULL,
  `booleanValue` tinyint(1) DEFAULT NULL,
  `doubleValue` decimal(19,5) DEFAULT NULL,
  `floatValue` float DEFAULT NULL,
  `blobValue` mediumblob,
  `clobValue` mediumtext,
  `discriminant` varchar(50) NOT NULL,
  PRIMARY KEY (`tenantId`,`id`),
  KEY `idx_datai_container` (`tenantId`,`containerId`,`containerType`,`name`),
  CONSTRAINT `fk_data_instance_tenantId` FOREIGN KEY (`tenantId`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dependency`
--

DROP TABLE IF EXISTS `dependency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dependency` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text,
  `filename` varchar(255) NOT NULL,
  `value_` mediumblob NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`name`),
  KEY `idx_dependency_name` (`name`),
  CONSTRAINT `fk_dependency_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dependencymapping`
--

DROP TABLE IF EXISTS `dependencymapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dependencymapping` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `artifactid` bigint(20) NOT NULL,
  `artifacttype` varchar(50) NOT NULL,
  `dependencyid` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`dependencyid`,`artifactid`,`artifacttype`),
  KEY `idx_dependencymapping_depid` (`dependencyid`),
  CONSTRAINT `fk_dependencymapping_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`),
  CONSTRAINT `fk_depmapping_depid` FOREIGN KEY (`tenantid`, `dependencyid`) REFERENCES `dependency` (`tenantid`, `id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `author` bigint(20) DEFAULT NULL,
  `creationdate` bigint(20) NOT NULL,
  `hascontent` tinyint(1) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `mimetype` varchar(255) DEFAULT NULL,
  `url` varchar(1024) DEFAULT NULL,
  `content` longblob,
  PRIMARY KEY (`tenantid`,`id`),
  CONSTRAINT `fk_document_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_mapping`
--

DROP TABLE IF EXISTS `document_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_mapping` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `processinstanceid` bigint(20) NOT NULL,
  `documentid` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `version` varchar(10) NOT NULL,
  `index_` int(11) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `fk_docmap_docid` (`tenantid`,`documentid`),
  CONSTRAINT `fk_docmap_docid` FOREIGN KEY (`tenantid`, `documentid`) REFERENCES `document` (`tenantid`, `id`) ON DELETE CASCADE,
  CONSTRAINT `fk_document_mapping_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_trigger_instance`
--

DROP TABLE IF EXISTS `event_trigger_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_trigger_instance` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `kind` varchar(15) NOT NULL,
  `eventInstanceId` bigint(20) NOT NULL,
  `eventInstanceName` varchar(50) DEFAULT NULL,
  `messageName` varchar(255) DEFAULT NULL,
  `targetProcess` varchar(255) DEFAULT NULL,
  `targetFlowNode` varchar(255) DEFAULT NULL,
  `signalName` varchar(255) DEFAULT NULL,
  `errorCode` varchar(255) DEFAULT NULL,
  `executionDate` bigint(20) DEFAULT NULL,
  `jobTriggerName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  CONSTRAINT `fk_event_trigger_instance_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `external_identity_mapping`
--

DROP TABLE IF EXISTS `external_identity_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_identity_mapping` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `kind` varchar(25) NOT NULL,
  `externalId` varchar(50) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `groupId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`kind`,`externalId`,`userId`,`groupId`,`roleId`),
  CONSTRAINT `fk_external_identity_mapping_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flownode_instance`
--

DROP TABLE IF EXISTS `flownode_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flownode_instance` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `flownodeDefinitionId` bigint(20) NOT NULL,
  `kind` varchar(25) NOT NULL,
  `rootContainerId` bigint(20) NOT NULL,
  `parentContainerId` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `displayName` varchar(255) DEFAULT NULL,
  `displayDescription` varchar(255) DEFAULT NULL,
  `stateId` int(11) NOT NULL,
  `stateName` varchar(50) DEFAULT NULL,
  `prev_state_id` int(11) NOT NULL,
  `terminal` tinyint(1) NOT NULL,
  `stable` tinyint(1) DEFAULT NULL,
  `actorId` bigint(20) DEFAULT NULL,
  `assigneeId` bigint(20) NOT NULL DEFAULT '0',
  `reachedStateDate` bigint(20) DEFAULT NULL,
  `lastUpdateDate` bigint(20) DEFAULT NULL,
  `expectedEndDate` bigint(20) DEFAULT NULL,
  `claimedDate` bigint(20) DEFAULT NULL,
  `priority` tinyint(4) DEFAULT NULL,
  `gatewayType` varchar(50) DEFAULT NULL,
  `hitBys` varchar(255) DEFAULT NULL,
  `stateCategory` varchar(50) NOT NULL,
  `logicalGroup1` bigint(20) NOT NULL,
  `logicalGroup2` bigint(20) NOT NULL,
  `logicalGroup3` bigint(20) DEFAULT NULL,
  `logicalGroup4` bigint(20) NOT NULL,
  `loop_counter` int(11) DEFAULT NULL,
  `loop_max` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sequential` tinyint(1) DEFAULT NULL,
  `loopDataInputRef` varchar(255) DEFAULT NULL,
  `loopDataOutputRef` varchar(255) DEFAULT NULL,
  `dataInputItemRef` varchar(255) DEFAULT NULL,
  `dataOutputItemRef` varchar(255) DEFAULT NULL,
  `loopCardinality` int(11) DEFAULT NULL,
  `nbActiveInst` int(11) DEFAULT NULL,
  `nbCompletedInst` int(11) DEFAULT NULL,
  `nbTerminatedInst` int(11) DEFAULT NULL,
  `executedBy` bigint(20) DEFAULT NULL,
  `executedBySubstitute` bigint(20) DEFAULT NULL,
  `activityInstanceId` bigint(20) DEFAULT NULL,
  `state_executing` tinyint(1) DEFAULT '0',
  `abortedByBoundary` bigint(20) DEFAULT NULL,
  `triggeredByEvent` tinyint(1) DEFAULT NULL,
  `interrupting` tinyint(1) DEFAULT NULL,
  `tokenCount` int(11) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `idx_fni_rootcontid` (`rootContainerId`),
  KEY `idx_fni_loggroup4` (`logicalGroup4`),
  KEY `idx_fn_lg2_state_tenant_del` (`logicalGroup2`,`stateName`,`tenantid`),
  CONSTRAINT `fk_flownode_instance_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_mapping`
--

DROP TABLE IF EXISTS `form_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_mapping` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `process` bigint(20) NOT NULL,
  `type` int(11) NOT NULL,
  `task` varchar(255) DEFAULT NULL,
  `page_mapping_tenant_id` bigint(20) DEFAULT NULL,
  `page_mapping_id` bigint(20) DEFAULT NULL,
  `lastUpdateDate` bigint(20) DEFAULT NULL,
  `lastUpdatedBy` bigint(20) DEFAULT NULL,
  `target` varchar(16) NOT NULL,
  PRIMARY KEY (`tenantId`,`id`),
  KEY `fk_form_mapping_key` (`page_mapping_tenant_id`,`page_mapping_id`),
  CONSTRAINT `fk_form_mapping_key` FOREIGN KEY (`page_mapping_tenant_id`, `page_mapping_id`) REFERENCES `page_mapping` (`tenantId`, `id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_`
--

DROP TABLE IF EXISTS `group_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(125) NOT NULL,
  `parentPath` varchar(255) DEFAULT NULL,
  `displayName` varchar(255) DEFAULT NULL,
  `description` text,
  `iconName` varchar(50) DEFAULT NULL,
  `iconPath` varchar(50) DEFAULT NULL,
  `createdBy` bigint(20) DEFAULT NULL,
  `creationDate` bigint(20) DEFAULT NULL,
  `lastUpdate` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`parentPath`,`name`),
  CONSTRAINT `fk_group__tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_desc`
--

DROP TABLE IF EXISTS `job_desc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_desc` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `jobclassname` varchar(100) NOT NULL,
  `jobname` varchar(100) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `fk_job_desc_Id_idx` (`id`,`tenantid`),
  CONSTRAINT `fk_job_desc_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_log`
--

DROP TABLE IF EXISTS `job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_log` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `jobDescriptorId` bigint(20) NOT NULL,
  `retryNumber` bigint(20) DEFAULT NULL,
  `lastUpdateDate` bigint(20) DEFAULT NULL,
  `lastMessage` text,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`jobDescriptorId`),
  KEY `fk_job_log_jobId_idx` (`jobDescriptorId`,`tenantid`),
  CONSTRAINT `fk_job_log_jobid` FOREIGN KEY (`tenantid`, `jobDescriptorId`) REFERENCES `job_desc` (`tenantid`, `id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_param`
--

DROP TABLE IF EXISTS `job_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_param` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `jobDescriptorId` bigint(20) NOT NULL,
  `key_` varchar(50) NOT NULL,
  `value_` mediumblob NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `fk_job_param_jobId_idx` (`jobDescriptorId`,`tenantid`),
  KEY `fk_job_param_jobid` (`tenantid`,`jobDescriptorId`),
  CONSTRAINT `fk_job_param_jobid` FOREIGN KEY (`tenantid`, `jobDescriptorId`) REFERENCES `job_desc` (`tenantid`, `id`) ON DELETE CASCADE,
  CONSTRAINT `fk_job_param_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message_instance`
--

DROP TABLE IF EXISTS `message_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_instance` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `messageName` varchar(255) NOT NULL,
  `targetProcess` varchar(255) NOT NULL,
  `targetFlowNode` varchar(255) DEFAULT NULL,
  `locked` tinyint(1) NOT NULL,
  `handled` tinyint(1) NOT NULL,
  `processDefinitionId` bigint(20) NOT NULL,
  `flowNodeName` varchar(255) DEFAULT NULL,
  `correlation1` varchar(128) DEFAULT NULL,
  `correlation2` varchar(128) DEFAULT NULL,
  `correlation3` varchar(128) DEFAULT NULL,
  `correlation4` varchar(128) DEFAULT NULL,
  `correlation5` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `idx_message_instance` (`messageName`,`targetProcess`,`correlation1`,`correlation2`,`correlation3`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `multi_biz_data`
--

DROP TABLE IF EXISTS `multi_biz_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `multi_biz_data` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `idx` bigint(20) NOT NULL,
  `data_id` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`,`data_id`),
  CONSTRAINT `fk_multi_biz_data_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`),
  CONSTRAINT `fk_rbdi_mbd` FOREIGN KEY (`tenantid`, `id`) REFERENCES `ref_biz_data_inst` (`tenantid`, `id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS `page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `displayName` varchar(255) NOT NULL,
  `description` text,
  `installationDate` bigint(20) NOT NULL,
  `installedBy` bigint(20) NOT NULL,
  `provided` tinyint(1) DEFAULT NULL,
  `lastModificationDate` bigint(20) NOT NULL,
  `lastUpdatedBy` bigint(20) NOT NULL,
  `contentName` varchar(50) NOT NULL,
  `content` longblob,
  `contentType` varchar(50) NOT NULL,
  `processDefinitionId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tenantId`,`id`),
  UNIQUE KEY `uk_page` (`tenantId`,`name`,`processDefinitionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page_mapping`
--

DROP TABLE IF EXISTS `page_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_mapping` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `key_` varchar(255) NOT NULL,
  `pageId` bigint(20) DEFAULT NULL,
  `url` varchar(1024) DEFAULT NULL,
  `urladapter` varchar(255) DEFAULT NULL,
  `page_authoriz_rules` text,
  `lastUpdateDate` bigint(20) DEFAULT NULL,
  `lastUpdatedBy` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tenantId`,`id`),
  UNIQUE KEY `tenantId` (`tenantId`,`key_`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pdependency`
--

DROP TABLE IF EXISTS `pdependency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pdependency` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `filename` varchar(255) NOT NULL,
  `value_` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `idx_pdependency_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pdependencymapping`
--

DROP TABLE IF EXISTS `pdependencymapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pdependencymapping` (
  `id` bigint(20) NOT NULL,
  `artifactid` bigint(20) NOT NULL,
  `artifacttype` varchar(50) NOT NULL,
  `dependencyid` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dependencyid` (`dependencyid`,`artifactid`,`artifacttype`),
  KEY `idx_pdependencymapping_depid` (`dependencyid`),
  CONSTRAINT `fk_pdepmapping_depid` FOREIGN KEY (`dependencyid`) REFERENCES `pdependency` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pending_mapping`
--

DROP TABLE IF EXISTS `pending_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pending_mapping` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `activityId` bigint(20) NOT NULL,
  `actorId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `idx_UQ_pending_mapping` (`tenantid`,`activityId`,`userId`,`actorId`),
  CONSTRAINT `fk_pending_mapping_flownode_instanceId` FOREIGN KEY (`tenantid`, `activityId`) REFERENCES `flownode_instance` (`tenantid`, `id`),
  CONSTRAINT `fk_pending_mapping_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `platform`
--

DROP TABLE IF EXISTS `platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platform` (
  `id` bigint(20) NOT NULL,
  `version` varchar(50) NOT NULL,
  `previousVersion` varchar(50) NOT NULL,
  `initialVersion` varchar(50) NOT NULL,
  `created` bigint(20) NOT NULL,
  `createdBy` varchar(50) NOT NULL,
  `information` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `platformCommand`
--

DROP TABLE IF EXISTS `platformCommand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platformCommand` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `IMPLEMENTATION` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `process_comment`
--

DROP TABLE IF EXISTS `process_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_comment` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `kind` varchar(25) NOT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `processInstanceId` bigint(20) NOT NULL,
  `postDate` bigint(20) NOT NULL,
  `content` varchar(512) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  CONSTRAINT `fk_process_comment_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `process_content`
--

DROP TABLE IF EXISTS `process_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_content` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `content` mediumtext NOT NULL,
  PRIMARY KEY (`tenantid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `process_definition`
--

DROP TABLE IF EXISTS `process_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_definition` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `processId` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `version` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deploymentDate` bigint(20) NOT NULL,
  `deployedBy` bigint(20) NOT NULL,
  `activationState` varchar(30) NOT NULL,
  `configurationState` varchar(30) NOT NULL,
  `displayName` varchar(75) DEFAULT NULL,
  `displayDescription` varchar(255) DEFAULT NULL,
  `lastUpdateDate` bigint(20) DEFAULT NULL,
  `categoryId` bigint(20) DEFAULT NULL,
  `iconPath` varchar(255) DEFAULT NULL,
  `content_tenantid` bigint(20) NOT NULL,
  `content_id` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`name`,`version`),
  KEY `fk_process_definition_content` (`content_tenantid`,`content_id`),
  CONSTRAINT `fk_process_definition_content` FOREIGN KEY (`content_tenantid`, `content_id`) REFERENCES `process_content` (`tenantid`, `id`),
  CONSTRAINT `fk_process_definition_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `process_instance`
--

DROP TABLE IF EXISTS `process_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_instance` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(75) NOT NULL,
  `processDefinitionId` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `startDate` bigint(20) NOT NULL,
  `startedBy` bigint(20) NOT NULL,
  `startedBySubstitute` bigint(20) NOT NULL,
  `endDate` bigint(20) NOT NULL,
  `stateId` int(11) NOT NULL,
  `stateCategory` varchar(50) NOT NULL,
  `lastUpdate` bigint(20) NOT NULL,
  `containerId` bigint(20) DEFAULT NULL,
  `rootProcessInstanceId` bigint(20) DEFAULT NULL,
  `callerId` bigint(20) DEFAULT NULL,
  `callerType` varchar(50) DEFAULT NULL,
  `interruptingEventId` bigint(20) DEFAULT NULL,
  `stringIndex1` varchar(255) DEFAULT NULL,
  `stringIndex2` varchar(255) DEFAULT NULL,
  `stringIndex3` varchar(255) DEFAULT NULL,
  `stringIndex4` varchar(255) DEFAULT NULL,
  `stringIndex5` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `idx1_proc_inst_pdef_state` (`tenantid`,`processDefinitionId`,`stateId`),
  CONSTRAINT `fk_process_instance_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `processcategorymapping`
--

DROP TABLE IF EXISTS `processcategorymapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `processcategorymapping` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `categoryid` bigint(20) NOT NULL,
  `processid` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`categoryid`,`processid`),
  CONSTRAINT `fk_catmapping_catid` FOREIGN KEY (`tenantid`, `categoryid`) REFERENCES `category` (`tenantid`, `id`) ON DELETE CASCADE,
  CONSTRAINT `fk_processcategorymapping_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `processsupervisor`
--

DROP TABLE IF EXISTS `processsupervisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `processsupervisor` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `processDefId` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `groupId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`processDefId`,`userId`,`groupId`,`roleId`),
  CONSTRAINT `fk_processsupervisor_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `isDefault` tinyint(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `creationDate` bigint(20) NOT NULL,
  `createdBy` bigint(20) NOT NULL,
  `lastUpdateDate` bigint(20) NOT NULL,
  `lastUpdatedBy` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantId`,`id`),
  UNIQUE KEY `tenantId` (`tenantId`,`name`),
  CONSTRAINT `fk_profile_tenantId` FOREIGN KEY (`tenantId`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profileentry`
--

DROP TABLE IF EXISTS `profileentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profileentry` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `profileId` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `parentId` bigint(20) DEFAULT NULL,
  `index_` bigint(20) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `page` varchar(50) DEFAULT NULL,
  `custom` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`tenantId`,`id`),
  KEY `indexProfileEntry` (`tenantId`,`parentId`,`profileId`),
  KEY `fk_profileentry_profileId` (`tenantId`,`profileId`),
  CONSTRAINT `fk_profileentry_profileId` FOREIGN KEY (`tenantId`, `profileId`) REFERENCES `profile` (`tenantId`, `id`),
  CONSTRAINT `fk_profileentry_tenantId` FOREIGN KEY (`tenantId`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profilemember`
--

DROP TABLE IF EXISTS `profilemember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profilemember` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `profileId` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `groupId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantId`,`id`),
  UNIQUE KEY `tenantId` (`tenantId`,`profileId`,`userId`,`groupId`,`roleId`),
  CONSTRAINT `fk_profilemember_profileId` FOREIGN KEY (`tenantId`, `profileId`) REFERENCES `profile` (`tenantId`, `id`),
  CONSTRAINT `fk_profilemember_tenantId` FOREIGN KEY (`tenantId`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queriable_log`
--

DROP TABLE IF EXISTS `queriable_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queriable_log` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `timeStamp` bigint(20) NOT NULL,
  `year` smallint(6) NOT NULL,
  `month` tinyint(4) NOT NULL,
  `dayOfYear` smallint(6) NOT NULL,
  `weekOfYear` tinyint(4) NOT NULL,
  `userId` varchar(255) NOT NULL,
  `threadNumber` bigint(20) NOT NULL,
  `clusterNode` varchar(50) DEFAULT NULL,
  `productVersion` varchar(50) NOT NULL,
  `severity` varchar(50) NOT NULL,
  `actionType` varchar(50) NOT NULL,
  `actionScope` varchar(100) DEFAULT NULL,
  `actionStatus` tinyint(4) NOT NULL,
  `rawMessage` varchar(255) NOT NULL,
  `callerClassName` varchar(200) DEFAULT NULL,
  `callerMethodName` varchar(80) DEFAULT NULL,
  `numericIndex1` bigint(20) DEFAULT NULL,
  `numericIndex2` bigint(20) DEFAULT NULL,
  `numericIndex3` bigint(20) DEFAULT NULL,
  `numericIndex4` bigint(20) DEFAULT NULL,
  `numericIndex5` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queriablelog_p`
--

DROP TABLE IF EXISTS `queriablelog_p`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queriablelog_p` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `queriableLogId` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `stringValue` varchar(255) DEFAULT NULL,
  `blobId` bigint(20) DEFAULT NULL,
  `valueType` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `idx_queriablelog` (`queriableLogId`),
  KEY `fk_queriableLogId` (`tenantid`,`queriableLogId`),
  CONSTRAINT `fk_queriableLogId` FOREIGN KEY (`tenantid`, `queriableLogId`) REFERENCES `queriable_log` (`tenantid`, `id`),
  CONSTRAINT `fk_queriablelog_p_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ref_biz_data_inst`
--

DROP TABLE IF EXISTS `ref_biz_data_inst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ref_biz_data_inst` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `kind` varchar(15) NOT NULL,
  `name` varchar(255) NOT NULL,
  `proc_inst_id` bigint(20) DEFAULT NULL,
  `fn_inst_id` bigint(20) DEFAULT NULL,
  `data_id` bigint(20) DEFAULT NULL,
  `data_classname` varchar(255) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `uk_ref_biz_data_inst` (`name`,`proc_inst_id`,`fn_inst_id`,`tenantid`),
  KEY `idx_biz_data_inst1` (`tenantid`,`proc_inst_id`),
  KEY `idx_biz_data_inst2` (`tenantid`,`fn_inst_id`),
  CONSTRAINT `fk_ref_biz_data_fn` FOREIGN KEY (`tenantid`, `fn_inst_id`) REFERENCES `flownode_instance` (`tenantid`, `id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ref_biz_data_inst_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`),
  CONSTRAINT `fk_ref_biz_data_proc` FOREIGN KEY (`tenantid`, `proc_inst_id`) REFERENCES `process_instance` (`tenantid`, `id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `installationDate` bigint(20) NOT NULL,
  `installedBy` bigint(20) NOT NULL,
  `provided` tinyint(1) DEFAULT NULL,
  `lastModificationDate` bigint(20) NOT NULL,
  `screenshot` mediumblob,
  `content` longblob,
  PRIMARY KEY (`tenantId`,`id`),
  UNIQUE KEY `tenantId` (`tenantId`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `displayName` varchar(255) DEFAULT NULL,
  `description` text,
  `iconName` varchar(50) DEFAULT NULL,
  `iconPath` varchar(50) DEFAULT NULL,
  `createdBy` bigint(20) DEFAULT NULL,
  `creationDate` bigint(20) DEFAULT NULL,
  `lastUpdate` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`name`),
  KEY `idx_role_name` (`tenantid`,`name`),
  CONSTRAINT `fk_role_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequence`
--

DROP TABLE IF EXISTS `sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequence` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `nextid` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tenant`
--

DROP TABLE IF EXISTS `tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tenant` (
  `id` bigint(20) NOT NULL,
  `created` bigint(20) NOT NULL,
  `createdBy` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `defaultTenant` tinyint(1) NOT NULL,
  `iconname` varchar(50) DEFAULT NULL,
  `iconpath` varchar(255) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `status` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `theme`
--

DROP TABLE IF EXISTS `theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `theme` (
  `tenantId` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `isDefault` tinyint(1) NOT NULL,
  `content` longblob NOT NULL,
  `cssContent` longblob,
  `type` varchar(50) NOT NULL,
  `lastUpdateDate` bigint(20) NOT NULL,
  PRIMARY KEY (`tenantId`,`id`),
  UNIQUE KEY `UK_Theme` (`tenantId`,`isDefault`,`type`),
  CONSTRAINT `fk_theme_tenantId` FOREIGN KEY (`tenantId`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_`
--

DROP TABLE IF EXISTS `user_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `password` varchar(60) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `jobTitle` varchar(255) DEFAULT NULL,
  `managerUserId` bigint(20) DEFAULT NULL,
  `iconName` varchar(50) DEFAULT NULL,
  `iconPath` varchar(50) DEFAULT NULL,
  `createdBy` bigint(20) DEFAULT NULL,
  `creationDate` bigint(20) DEFAULT NULL,
  `lastUpdate` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`userName`),
  KEY `idx_user_name` (`tenantid`,`userName`),
  CONSTRAINT `fk_user__tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_contactinfo`
--

DROP TABLE IF EXISTS `user_contactinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_contactinfo` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `building` varchar(50) DEFAULT NULL,
  `room` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `zipCode` varchar(50) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `personal` tinyint(1) NOT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`userId`,`personal`),
  KEY `idx_user_contactinfo` (`userId`,`tenantid`,`personal`),
  CONSTRAINT `fk_contact_user` FOREIGN KEY (`tenantid`, `userId`) REFERENCES `user_` (`tenantid`, `id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_login`
--

DROP TABLE IF EXISTS `user_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_login` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `lastConnection` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_membership`
--

DROP TABLE IF EXISTS `user_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_membership` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  `groupId` bigint(20) NOT NULL,
  `assignedBy` bigint(20) DEFAULT NULL,
  `assignedDate` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  UNIQUE KEY `tenantid` (`tenantid`,`userId`,`roleId`,`groupId`),
  CONSTRAINT `fk_user_membership_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `waiting_event`
--

DROP TABLE IF EXISTS `waiting_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waiting_event` (
  `tenantid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `kind` varchar(15) NOT NULL,
  `eventType` varchar(50) DEFAULT NULL,
  `messageName` varchar(255) DEFAULT NULL,
  `signalName` varchar(255) DEFAULT NULL,
  `errorCode` varchar(255) DEFAULT NULL,
  `processName` varchar(150) DEFAULT NULL,
  `flowNodeName` varchar(50) DEFAULT NULL,
  `flowNodeDefinitionId` bigint(20) DEFAULT NULL,
  `subProcessId` bigint(20) DEFAULT NULL,
  `processDefinitionId` bigint(20) DEFAULT NULL,
  `rootProcessInstanceId` bigint(20) DEFAULT NULL,
  `parentProcessInstanceId` bigint(20) DEFAULT NULL,
  `flowNodeInstanceId` bigint(20) DEFAULT NULL,
  `relatedActivityInstanceId` bigint(20) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `progress` tinyint(4) DEFAULT NULL,
  `correlation1` varchar(128) DEFAULT NULL,
  `correlation2` varchar(128) DEFAULT NULL,
  `correlation3` varchar(128) DEFAULT NULL,
  `correlation4` varchar(128) DEFAULT NULL,
  `correlation5` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`tenantid`,`id`),
  KEY `idx_waiting_event` (`progress`,`tenantid`,`kind`,`locked`,`active`),
  CONSTRAINT `fk_waiting_event_tenantId` FOREIGN KEY (`tenantid`) REFERENCES `tenant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'bonita'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-06 20:53:40
