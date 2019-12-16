CREATE DATABASE  IF NOT EXISTS `diwallet` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `diwallet`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 192.168.1.181    Database: diwallet
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_id` int(11) unsigned NOT NULL COMMENT '帳號ID',
  `operator_id` int(11) NOT NULL COMMENT '營運商ID',
  `user_name` varchar(20) NOT NULL COMMENT '使用者名稱',
  `balance` bigint(20) NOT NULL COMMENT '餘額',
  `currency_id` int(11) NOT NULL COMMENT '貨幣ID',
  `status` int(11) NOT NULL COMMENT '狀態\n0: 正常\n1: 凍結\n2: 停用',
  `create_time` bigint(20) NOT NULL COMMENT '建立時間',
  `update_time` bigint(20) NOT NULL COMMENT '最近一次的修改時間',
  `is_deleted` smallint(6) NOT NULL COMMENT '邏輯刪除',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`,`operator_id`) /*!80000 INVISIBLE */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='帳號';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `balance_history`
--

DROP TABLE IF EXISTS `balance_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `balance_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '流水號',
  `account_id` int(11) unsigned NOT NULL COMMENT '帳號ID',
  `operator_id` int(11) NOT NULL COMMENT '營運商ID',
  `amount` bigint(20) NOT NULL COMMENT '異動金額的數量',
  `balance` bigint(20) NOT NULL COMMENT '操作完後的餘額',
  `create_time` bigint(20) NOT NULL COMMENT '建立時間',
  `table_name` varchar(45) NOT NULL COMMENT 'table名稱\n紀錄關聯的table名稱',
  `table_row_id` bigint(20) unsigned NOT NULL COMMENT 'table row id\n紀錄關聯的table對應資料列的ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='餘額異動歷史';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `balance_history`
--

LOCK TABLES `balance_history` WRITE;
/*!40000 ALTER TABLE `balance_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `balance_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency` (
  `currency_id` int(11) NOT NULL COMMENT '貨幣ID',
  `currency_name` varchar(20) NOT NULL COMMENT '貨幣名稱',
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='貨幣';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES (1,'CNY');
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game` (
  `game_id` int(11) NOT NULL COMMENT '遊戲ID',
  `game_group_id` int(11) NOT NULL COMMENT '遊戲群組ID',
  `game_name` varchar(45) NOT NULL COMMENT '遊戲名稱',
  `game_code` varchar(45) NOT NULL COMMENT '遊戲代碼',
  `flag` bigint(20) unsigned NOT NULL COMMENT '旗標\n每一個bit表示一個開關\n0: 遊戲是否開放',
  PRIMARY KEY (`game_id`,`game_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='遊戲';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (7,1,'KingKuLy','BN07',1),(8,1,'YiHungYuan','BN08',1),(9,1,'Bibo','BN09',1);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_group`
--

DROP TABLE IF EXISTS `game_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_group` (
  `game_group_id` int(11) NOT NULL COMMENT '遊戲群組ID',
  `game_group_name` varchar(45) NOT NULL COMMENT '遊戲群組名稱',
  PRIMARY KEY (`game_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='遊戲群組';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_group`
--

LOCK TABLES `game_group` WRITE;
/*!40000 ALTER TABLE `game_group` DISABLE KEYS */;
INSERT INTO `game_group` VALUES (1,'slot');
/*!40000 ALTER TABLE `game_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_api`
--

DROP TABLE IF EXISTS `log_api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_api` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '流水號',
  `api_name` varchar(45) NOT NULL COMMENT 'api名稱',
  `operator_code` varchar(20) NOT NULL COMMENT '營運商代碼',
  `user_name` varchar(20) NOT NULL COMMENT '使用者名稱',
  `request` text NOT NULL COMMENT 'request內容',
  `response` text NOT NULL COMMENT 'response內容',
  `code` int(11) NOT NULL COMMENT '回應碼',
  `create_time` bigint(20) NOT NULL COMMENT '建立時間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='api request/response紀錄';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_api`
--

LOCK TABLES `log_api` WRITE;
/*!40000 ALTER TABLE `log_api` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_api` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_bet`
--

DROP TABLE IF EXISTS `log_bet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_bet` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '流水號',
  `account_id` int(11) unsigned NOT NULL COMMENT '帳號ID',
  `game_token` varchar(255) NOT NULL COMMENT '遊戲token',
  `game_id` int(11) NOT NULL COMMENT '遊戲ID',
  `operator_id` int(11) NOT NULL COMMENT '營運商ID',
  `round_code` varchar(50) NOT NULL COMMENT '局號',
  `bet` bigint(20) NOT NULL COMMENT '押注',
  `win` bigint(20) NOT NULL COMMENT '贏的金額',
  `balance` bigint(20) NOT NULL COMMENT '計算完bet、win後的餘額',
  `detail` varchar(255) NOT NULL COMMENT '詳細資料',
  `bet_time` bigint(20) NOT NULL COMMENT '押注時間',
  `win_time` bigint(20) NOT NULL,
  `end_time` bigint(20) NOT NULL COMMENT '結算時間',
  `order_time` bigint(20) NOT NULL COMMENT '成單時間',
  `status` int(11) NOT NULL COMMENT '注單狀態\ncq9用\n0: 押注成功\n1: win api失敗\n2: win api成功\n3: end api 成功\n4: 已補帳',
  PRIMARY KEY (`id`),
  UNIQUE KEY `round_code_UNIQUE` (`round_code`,`operator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='注單\n一局會有一個注單';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_bet`
--

LOCK TABLES `log_bet` WRITE;
/*!40000 ALTER TABLE `log_bet` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_bet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_login`
--

DROP TABLE IF EXISTS `log_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_login` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '流水號',
  `account_id` int(11) unsigned NOT NULL COMMENT '帳號ID',
  `user_name` varchar(20) NOT NULL COMMENT '使用者名稱',
  `operator_id` int(11) NOT NULL,
  `game_token` varchar(255) NOT NULL COMMENT '遊戲token',
  `game_id` int(11) NOT NULL COMMENT '遊戲ID',
  `blance` bigint(20) NOT NULL COMMENT '餘額',
  `create_time` bigint(20) NOT NULL COMMENT '建立時間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='登入資訊';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_login`
--

LOCK TABLES `log_login` WRITE;
/*!40000 ALTER TABLE `log_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_logout`
--

DROP TABLE IF EXISTS `log_logout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_logout` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '流水號',
  `account_id` int(11) unsigned NOT NULL COMMENT '帳號ID',
  `user_name` varchar(20) NOT NULL,
  `operator_id` int(11) NOT NULL,
  `game_token` varchar(255) NOT NULL COMMENT '遊戲token',
  `game_id` int(11) NOT NULL COMMENT '遊戲ID',
  `blance` bigint(20) NOT NULL COMMENT '餘額',
  `create_time` bigint(20) NOT NULL COMMENT '建立時間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='登出資訊';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_logout`
--

LOCK TABLES `log_logout` WRITE;
/*!40000 ALTER TABLE `log_logout` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_logout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_order`
--

DROP TABLE IF EXISTS `log_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '單號',
  `account_id` int(11) unsigned NOT NULL COMMENT '帳號ID',
  `operator_id` int(11) NOT NULL COMMENT '營運商ID',
  `order_id` varchar(50) NOT NULL COMMENT '交易唯一碼',
  `amount` bigint(20) NOT NULL COMMENT '金額\n正數: 轉入錢包\n負數: 轉出錢包',
  `balance` bigint(20) NOT NULL COMMENT '操作完後的餘額',
  `order_status` tinyint(1) NOT NULL COMMENT '交易狀態\n0: 成功\n1: 餘額不足',
  `create_time` bigint(20) NOT NULL COMMENT '建立時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id_UNIQUE` (`order_id`,`operator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='轉入轉出紀錄';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_order`
--

LOCK TABLES `log_order` WRITE;
/*!40000 ALTER TABLE `log_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operator`
--

DROP TABLE IF EXISTS `operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operator` (
  `operator_id` int(11) NOT NULL COMMENT '營運商ID',
  `operator_code` varchar(20) NOT NULL COMMENT '營運商代碼',
  `encrypt_key` varchar(255) NOT NULL COMMENT '加密金鑰\n錢包API用',
  `note` varchar(100) NOT NULL COMMENT '說明',
  `is_deleted` smallint(6) NOT NULL COMMENT '邏輯刪除',
  PRIMARY KEY (`operator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='營運商';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operator`
--

LOCK TABLES `operator` WRITE;
/*!40000 ALTER TABLE `operator` DISABLE KEYS */;
INSERT INTO `operator` VALUES (1,'Demo','2a927d86fb098cgc','demo',0),(2,'CQ9','2a927d86fb098cgc','cq9',0),(3,'DemoWallet','2a927d86fb098cgc','demo for wallet',0);
/*!40000 ALTER TABLE `operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_value`
--

DROP TABLE IF EXISTS `system_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_value` (
  `skey` varchar(45) NOT NULL COMMENT 'key\nmoney_fraction_multiple: 錢小數轉整數時要乘的倍數; 以整數型態保存, 轉為小數需除以此欄位\ncq9_auth_header_key: cq9 api auth header key\ncq9_auth_header_value: cq9 api auth header value',
  `svalue` varchar(255) NOT NULL COMMENT 'value',
  PRIMARY KEY (`skey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系統用的key-value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_value`
--

LOCK TABLES `system_value` WRITE;
/*!40000 ALTER TABLE `system_value` DISABLE KEYS */;
INSERT INTO `system_value` VALUES ('cq9_auth_header_key','Authorization'),('cq9_auth_header_value','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJnYW1laGFsbCI6ImNxOSIsInRlYW0iOiJCTiIsImp0aSI6IjkyNzEwNDEyIiwiaWF0IjoxNTQ1ODkxMDA1LCJpc3MiOiJDeXByZXNzIiwic3ViIjoiR1NUb2tlbiJ9.UIze9W4W2DcZ7wF8JvQHhiEVAjOjIsjqBStaPKSuAgU'),('money_fraction_multiple','1000');
/*!40000 ALTER TABLE `system_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'diwallet'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_ResetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_ResetAll`()
BEGIN
	set sql_safe_updates = 0;
    
    delete from account;
    
    alter table balance_history auto_increment = 1;
    delete from balance_history;
    
    alter table log_api auto_increment = 1;
    delete from log_api;
    
    alter table log_bet auto_increment = 1;
    delete from log_bet;
    
	alter table log_login auto_increment = 1;
    delete from log_login;
    
	alter table log_logout auto_increment = 1;
    delete from log_logout;
    
    alter table log_order auto_increment = 1;
    delete from log_order;
    
    set sql_safe_updates = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-16 19:25:17
