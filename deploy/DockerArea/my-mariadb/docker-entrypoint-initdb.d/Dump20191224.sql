CREATE DATABASE  IF NOT EXISTS `digame` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `digame`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 192.168.1.181    Database: digame
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='帳號';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='餘額異動歷史';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `balance_history`
--

LOCK TABLES `balance_history` WRITE;
/*!40000 ALTER TABLE `balance_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `balance_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bet_sync`
--

DROP TABLE IF EXISTS `bet_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bet_sync` (
  `index_id` varchar(255) NOT NULL COMMENT '訂單索引',
  `mtcode` varchar(255) NOT NULL COMMENT '交易代碼',
  `round_code` varchar(255) NOT NULL COMMENT '局號',
  `round_id` bigint(20) NOT NULL COMMENT '局ID',
  `log_bet_status` int(11) NOT NULL COMMENT '處理前的注單狀態\ncq9用\n0: 押注成功\n1: win api失敗\n2: win api成功\n3: end api 成功\n4: 已補帳',
  `status` int(11) NOT NULL COMMENT '注單狀態\n0: 待sync\n1: 處理完畢',
  `create_time` bigint(20) NOT NULL COMMENT '建立時間',
  `done_time` bigint(20) NOT NULL COMMENT '完成時間',
  PRIMARY KEY (`index_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='cq9待同步注單的資料';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bet_sync`
--

LOCK TABLES `bet_sync` WRITE;
/*!40000 ALTER TABLE `bet_sync` DISABLE KEYS */;
INSERT INTO `bet_sync` VALUES ('BNT000121:cq9','rel-win-BNT000121','BNT000121',121,0,1,1573195800,1573195800),('BNT000122:cq9','rel-win-BNT000122','BNT000122',122,0,1,1573217400,1573217400),('BNT000134:cq9','rel-bet-BNT000134','BNT000134',134,0,1,1573221000,1573221000),('BNT000135:cq9','rel-bet-BNT000135','BNT000135',135,0,1,1573221000,1573221001),('BNT000136:cq9','rel-bet-BNT000136','BNT000136',136,0,1,1573221000,1573221000),('BNT000137:cq9','rel-bet-BNT000137','BNT000137',137,0,1,1573221000,1573221000),('BNT000138:cq9','rel-bet-BNT000138','BNT000138',138,0,1,1573221000,1573221000),('BNT000185:cq9','rel-bet-BNT000185','BNT000185',185,0,1,1573289400,1573289400),('BNT000186:cq9','rel-bet-BNT000186','BNT000186',186,0,1,1573289400,1573289401),('BNT000188:cq9','rel-bet-BNT000188','BNT000188',188,0,1,1573289400,1573289400),('BNT000189:cq9','rel-bet-BNT000189','BNT000189',189,0,1,1573289400,1573289400),('BNT000205:cq9','rel-bet-BNT000205','BNT000205',205,0,1,1573296600,1573296600),('BNT00042:cq9','rel-bet-BNT00042','BNT00042',42,0,1,1572000600,1571998756),('BNT00043:cq9','rel-bet-BNT00043','BNT00043',43,0,1,1572000600,1571998756),('BNT00044:cq9','rel-bet-BNT00044','BNT00044',44,0,1,1572000600,1571998756),('BNT00045:cq9','rel-bet-BNT00045','BNT00045',45,0,1,1572000600,1571998755),('BNT00046:cq9','rel-win-BNT00046','BNT00046',46,0,1,1572000600,1571998755),('BNT00047:cq9','rel-win-BNT00047','BNT00047',47,0,1,1572000600,1571998755),('BNT00048:cq9','rel-win-BNT00048','BNT00048',48,0,1,1572000600,1571998755);
/*!40000 ALTER TABLE `bet_sync` ENABLE KEYS */;
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
  `denom` int(11) NOT NULL COMMENT '匯率\n錢轉分數的匯率 (單位 1/100): 分數=錢/(Denom/100)=錢x(100/Denom)',
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='貨幣';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES (1,'CNY',1);
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
  `game_name` varchar(45) NOT NULL COMMENT '遊戲名稱',
  `game_code` varchar(45) NOT NULL COMMENT '遊戲代碼\ncq9使用',
  `game_class_id` int(11) NOT NULL COMMENT '遊戲類別ID\n主類別',
  `game_type_id` int(11) NOT NULL COMMENT '遊戲類型ID\n類別下的子類型',
  `line` int(11) NOT NULL COMMENT '線數\nslot使用',
  `bet_multiples` varchar(200) NOT NULL COMMENT '押注乘數\nslot使用\n逗點分隔的int字串',
  `bet_unit` bigint(20) NOT NULL COMMENT '押注單位\nslot使用\nbet_unit x bet_multiple x line = total bet',
  `room_num` int(11) NOT NULL COMMENT '預開的房間數',
  `seat_num` int(11) NOT NULL COMMENT '預開的座位數',
  `rtp` int(11) NOT NULL COMMENT '預設的 rtp',
  `flag` bigint(20) unsigned NOT NULL COMMENT '旗標\n每一個bit表示一個開關\n0: 遊戲是否開放',
  PRIMARY KEY (`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='遊戲';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (7,'KingKuLy','BN07',1,1,50,'1,2,3,5,10,30,50,80,125,250,500,750,1250,2500,5000,10000',10,0,1,96,1),(8,'YiHungYuan','BN08',1,1,25,'1,2,3,5,10,30,50,80,125,250,500,750,1250,2500,5000,10000',10,0,1,96,1),(9,'Bibo','BN09',1,1,50,'1,2,3,5,10,30,50,80,125,250,500,750,1250,2500,5000,10000',10,0,1,96,1),(14,'LuckyFortune','BN14',1,1,5,'1,2,3,5,10,30,50,80,125,250,500,750,1250,2500,5000,10000',10,0,1,96,1),(15,'TheMonkeyKing','BN15',1,1,15,'1,2,3,5,10,30,50,80,125,250,500,750,1250,2500,5000,10000',10,0,1,96,1),(17,'Thor','BN17',1,1,50,'1,2,3,5,10,30,50,80,125,250,500,750,1250,2500,5000,10000',10,0,1,96,1);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_class`
--

DROP TABLE IF EXISTS `game_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_class` (
  `game_class_id` int(11) NOT NULL COMMENT '遊戲類別ID',
  `game_class_name` varchar(45) NOT NULL COMMENT '遊戲類別名稱',
  PRIMARY KEY (`game_class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='遊戲類別';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_class`
--

LOCK TABLES `game_class` WRITE;
/*!40000 ALTER TABLE `game_class` DISABLE KEYS */;
INSERT INTO `game_class` VALUES (1,'slot');
/*!40000 ALTER TABLE `game_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_stat`
--

DROP TABLE IF EXISTS `game_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_stat` (
  `game_id` int(11) NOT NULL COMMENT '遊戲ID',
  `total_bet` bigint(20) NOT NULL COMMENT '總押注',
  `total_win` bigint(20) NOT NULL COMMENT '總贏的金額',
  PRIMARY KEY (`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='遊戲統計';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_stat`
--

LOCK TABLES `game_stat` WRITE;
/*!40000 ALTER TABLE `game_stat` DISABLE KEYS */;
INSERT INTO `game_stat` VALUES (7,0,0),(8,4185750,4604200),(9,0,0),(14,0,0),(15,0,0),(17,0,0);
/*!40000 ALTER TABLE `game_stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_type`
--

DROP TABLE IF EXISTS `game_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_type` (
  `game_class_id` int(11) NOT NULL COMMENT '遊戲類別ID',
  `game_type_id` int(11) NOT NULL COMMENT '遊戲類型ID',
  `game_type_name` varchar(45) NOT NULL COMMENT '遊戲類型名稱',
  PRIMARY KEY (`game_class_id`,`game_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='遊戲類型\n類別下的子類型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_type`
--

LOCK TABLES `game_type` WRITE;
/*!40000 ALTER TABLE `game_type` DISABLE KEYS */;
INSERT INTO `game_type` VALUES (1,1,'line'),(1,2,'way');
/*!40000 ALTER TABLE `game_type` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='api request/response紀錄';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_api`
--

LOCK TABLES `log_api` WRITE;
/*!40000 ALTER TABLE `log_api` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_api` ENABLE KEYS */;
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
  `player_code` varchar(255) NOT NULL COMMENT '玩家代碼\ncq9用',
  `user_name` varchar(255) NOT NULL COMMENT '使用者名稱',
  `game_token` varchar(255) NOT NULL COMMENT '遊戲token',
  `game_id` int(11) NOT NULL COMMENT '遊戲ID',
  `blance` bigint(20) NOT NULL COMMENT '餘額',
  `currency_id` int(11) NOT NULL COMMENT '貨幣ID',
  `game_hall` varchar(255) NOT NULL COMMENT '遊戲廠商\ncq9用',
  `game_platform` varchar(255) NOT NULL COMMENT '遊戲平台\ncq9用',
  `game_tech` varchar(255) NOT NULL COMMENT '使用技術\ncq9用',
  `game_type` varchar(255) NOT NULL COMMENT '遊戲類型\ncq9用',
  `parent_code` varchar(255) NOT NULL COMMENT '代理ID\ncq9用',
  `owner_code` varchar(255) NOT NULL COMMENT '上層代理ID\ncq9用',
  `login_ip` varchar(255) NOT NULL COMMENT '登入IP',
  `create_time` bigint(20) NOT NULL COMMENT '建立時間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='登入資訊';
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
  `player_code` varchar(255) NOT NULL COMMENT '玩家代碼\ncq9用',
  `game_token` varchar(255) NOT NULL COMMENT '遊戲token',
  `game_id` int(11) NOT NULL COMMENT '遊戲ID',
  `blance` bigint(20) NOT NULL COMMENT '餘額',
  `create_time` bigint(20) NOT NULL COMMENT '建立時間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='登出資訊';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='轉入轉出紀錄';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_order`
--

LOCK TABLES `log_order` WRITE;
/*!40000 ALTER TABLE `log_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_slot_bet`
--

DROP TABLE IF EXISTS `log_slot_bet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_slot_bet` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '流水號',
  `account_id` int(11) unsigned NOT NULL COMMENT '帳號ID',
  `player_code` varchar(255) NOT NULL COMMENT '玩家代碼\ncq9用',
  `game_token` varchar(255) NOT NULL COMMENT '遊戲token',
  `game_id` int(11) NOT NULL COMMENT '遊戲ID',
  `round_id` bigint(20) unsigned NOT NULL COMMENT '局ID',
  `bet` bigint(20) NOT NULL COMMENT '押注',
  `win` bigint(20) NOT NULL COMMENT '贏的金額',
  `balance` bigint(20) NOT NULL COMMENT '計算完bet、win後的餘額',
  `fg_times` int(11) NOT NULL COMMENT 'free game次數',
  `ld_times` int(11) NOT NULL COMMENT 'lucky draw次數',
  `bg_times` int(11) NOT NULL COMMENT 'bonus game次數',
  `bet_time` bigint(20) NOT NULL COMMENT '押注時間',
  `end_time` bigint(20) NOT NULL COMMENT '結算時間',
  `status` int(11) NOT NULL COMMENT '注單狀態\ncq9用\n0: 押注成功\n1: win api失敗\n2: win api成功\n3: end api 成功\n4: 已補帳',
  PRIMARY KEY (`id`),
  UNIQUE KEY `round_id_UNIQUE` (`round_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='slot的注單\n一局會有一個注單';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_slot_bet`
--

LOCK TABLES `log_slot_bet` WRITE;
/*!40000 ALTER TABLE `log_slot_bet` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_slot_bet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_slot_bet_detail`
--

DROP TABLE IF EXISTS `log_slot_bet_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_slot_bet_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '流水號',
  `account_id` int(11) unsigned NOT NULL COMMENT '帳號ID',
  `player_code` varchar(255) NOT NULL COMMENT '玩家代碼\ncq9用',
  `game_id` int(11) NOT NULL COMMENT '遊戲ID',
  `round_id` bigint(20) unsigned NOT NULL COMMENT '局ID',
  `game_mode` int(11) NOT NULL COMMENT '遊戲模式\n0: base game\n1: bonus game\n2: lucky draw\n3: free game',
  `spin_serial` int(11) NOT NULL COMMENT '此局一輪中bonus game play、lucky draw play、free game spin的流水號',
  `win` bigint(20) NOT NULL COMMENT '贏的金額',
  `detail` text NOT NULL,
  `spin_time` bigint(20) NOT NULL COMMENT 'spin的時間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='slot的細單\n每個spin對應一個細單';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_slot_bet_detail`
--

LOCK TABLES `log_slot_bet_detail` WRITE;
/*!40000 ALTER TABLE `log_slot_bet_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_slot_bet_detail` ENABLE KEYS */;
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
  `team_code` varchar(45) NOT NULL COMMENT '團隊代碼\ncq9用',
  `encrypt_key` varchar(255) NOT NULL COMMENT '加密金鑰\n錢包API用',
  `note` varchar(100) NOT NULL COMMENT '說明',
  `is_deleted` smallint(6) NOT NULL COMMENT '邏輯刪除',
  PRIMARY KEY (`operator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='營運商';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operator`
--

LOCK TABLES `operator` WRITE;
/*!40000 ALTER TABLE `operator` DISABLE KEYS */;
INSERT INTO `operator` VALUES (1,'Demo','','2a927d86fb098cgc','demo',0),(2,'CQ9','BN','2a927d86fb098cgc','cq9',0),(3,'DemoWallet','','2a927d86fb098cgc','demo for wallet',0);
/*!40000 ALTER TABLE `operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_value`
--

DROP TABLE IF EXISTS `system_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_value` (
  `skey` varchar(45) NOT NULL COMMENT 'key\nlast_bet_sync_time: 上次注單與cq9同步的時間\nslot_round_id: slot的round id, 當作除注單round id外的另一個備援資料\nmoney_fraction_multiple: 錢小數轉整數時要乘的倍數; 以整數型態保存, 轉為小數需除以此欄位\nround_code_prefix: 局號 prefix\ncq9_env: cq9 環境\ncq9_auth_header_key: cq9 api auth header key\ncq9_auth_header_value: cq9 api auth header value\ncq9_site_url: cq9 API base url\ncq9_max_win: cq9單一spin允許的最大贏取金額',
  `svalue` varchar(255) NOT NULL COMMENT 'value',
  PRIMARY KEY (`skey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系統用的key-value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_value`
--

LOCK TABLES `system_value` WRITE;
/*!40000 ALTER TABLE `system_value` DISABLE KEYS */;
INSERT INTO `system_value` VALUES ('cq9_auth_header_key','Authorization'),('cq9_auth_header_value','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJnYW1laGFsbCI6ImNxOSIsInRlYW0iOiJCTiIsImp0aSI6IjkyNzEwNDEyIiwiaWF0IjoxNTQ1ODkxMDA1LCJpc3MiOiJDeXByZXNzIiwic3ViIjoiR1NUb2tlbiJ9.UIze9W4W2DcZ7wF8JvQHhiEVAjOjIsjqBStaPKSuAgU'),('cq9_env','rel'),('cq9_max_win','100000000'),('cq9_site_url','http://127.0.0.1:13101'),('last_bet_sync_time','1574322600'),('money_fraction_multiple','1000'),('round_code_prefix','T000'),('slot_round_id','0');
/*!40000 ALTER TABLE `system_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'digame'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetLastBetSyncTime` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetLastBetSyncTime`()
BEGIN
	set time_zone = '+8:00';
	select skey, FROM_UNIXTIME(svalue, '%Y-%m-%d %H:%i') as svalue
    from system_value
    where skey = 'last_bet_sync_time';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ResetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
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
    
    alter table log_login auto_increment = 1;
    delete from log_login;
    
	alter table log_logout auto_increment = 1;
    delete from log_logout;
    
    alter table log_order auto_increment = 1;
    delete from log_order;
    
    alter table log_slot_bet auto_increment = 1;
    delete from log_slot_bet;
    
    alter table log_slot_bet_detail auto_increment = 1;
    delete from log_slot_bet_detail;
    
    set sql_safe_updates = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ShowLatestLogSlotBet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_ShowLatestLogSlotBet`()
BEGIN
	set time_zone = '+8:00';
	select *, FROM_UNIXTIME(bet_time, '%Y-%m-%d %H:%i') as bet_time, FROM_UNIXTIME(end_time, '%Y-%m-%d %H:%i') as end_time
    from log_slot_bet
    order by id desc
    limit 5;
    select *, FROM_UNIXTIME(spin_time, '%Y-%m-%d %H:%i') as spin_time
    from log_slot_bet_detail
    order by id desc
    limit 50;
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

-- Dump completed on 2019-12-24 14:16:57
CREATE DATABASE  IF NOT EXISTS `diwallet` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='帳號';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='餘額異動歷史';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='貨幣';
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
  `game_class_id` int(11) NOT NULL COMMENT '遊戲類別ID',
  `flag` bigint(20) unsigned NOT NULL COMMENT '旗標\n每一個bit表示一個開關\n0: 遊戲是否開放',
  PRIMARY KEY (`game_id`,`game_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='遊戲';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (1,1,'FortuneDragon','BN01',1,1),(2,1,'FiveGodofWealth','BN02',1,1),(3,1,'LeadGenerals','BN03',1,1),(4,1,'WineAndSword','BN04',1,1),(5,1,'FiveElements','BN05',1,1),(7,2,'KingKuLy','BN07',1,1),(8,2,'YiHungYuan','BN08',1,1),(9,2,'Bibo','BN09',1,1),(14,2,'LuckyFortune','BN14',1,1),(15,2,'TheMonkeyKing','BN15',1,1),(17,2,'Thor','BN17',1,1);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_class`
--

DROP TABLE IF EXISTS `game_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_class` (
  `game_class_id` int(11) NOT NULL COMMENT '遊戲類別ID',
  `game_class_name` varchar(45) NOT NULL COMMENT '遊戲類別名稱',
  PRIMARY KEY (`game_class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='遊戲類別';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_class`
--

LOCK TABLES `game_class` WRITE;
/*!40000 ALTER TABLE `game_class` DISABLE KEYS */;
INSERT INTO `game_class` VALUES (1,'slot');
/*!40000 ALTER TABLE `game_class` ENABLE KEYS */;
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
  `game_url` varchar(255) NOT NULL COMMENT '遊戲網址',
  `api_url` varchar(255) NOT NULL COMMENT 'api 網址',
  PRIMARY KEY (`game_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='遊戲群組';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_group`
--

LOCK TABLES `game_group` WRITE;
/*!40000 ALTER TABLE `game_group` DISABLE KEYS */;
INSERT INTO `game_group` VALUES (1,'qt','http://127.0.0.1/game',''),(2,'go','http://127.0.0.1/game','');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='api request/response紀錄';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='注單\n一局會有一個注單';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='登入資訊';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='登出資訊';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='轉入轉出紀錄';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='營運商';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系統用的key-value';
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
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

-- Dump completed on 2019-12-24 14:16:58
