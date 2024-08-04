-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Vært: 127.0.0.1
-- Genereringstid: 10. 11 2022 kl. 21:10:04
-- Serverversion: 10.4.25-MariaDB
-- PHP-version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database`
--
CREATE DATABASE IF NOT EXISTS `database` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `database`;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_srv_data`
--

DROP TABLE IF EXISTS `vrp_srv_data`;
CREATE TABLE `vrp_srv_data` (
  `dkey` varchar(255) NOT NULL,
  `dvalue` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_users`
--

DROP TABLE IF EXISTS `vrp_users`;
CREATE TABLE `vrp_users` (
  `id` int(11) NOT NULL,
  `last_login` varchar(255) DEFAULT NULL,
  `last_date` varchar(255) NOT NULL DEFAULT '',
  `whitelisted` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  `DmvTest` int(11) NOT NULL DEFAULT 0,
  `warnings` int(11) NOT NULL DEFAULT 0,
  `ban_reason` varchar(250) DEFAULT NULL,
  `discord` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_business`
--

DROP TABLE IF EXISTS `vrp_user_business`;
CREATE TABLE `vrp_user_business` (
  `user_id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `capital` int(11) DEFAULT NULL,
  `laundered` int(11) DEFAULT NULL,
  `reset_timestamp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_data`
--

DROP TABLE IF EXISTS `vrp_user_data`;
CREATE TABLE `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(255) NOT NULL,
  `dvalue` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_homes`
--

DROP TABLE IF EXISTS `vrp_user_homes`;
CREATE TABLE `vrp_user_homes` (
  `user_id` int(11) NOT NULL,
  `home` varchar(255) DEFAULT NULL,
  `number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_identities`
--

DROP TABLE IF EXISTS `vrp_user_identities`;
CREATE TABLE `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registration` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_ids`
--

DROP TABLE IF EXISTS `vrp_user_ids`;
CREATE TABLE `vrp_user_ids` (
  `identifier` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_moneys`
--

DROP TABLE IF EXISTS `vrp_user_moneys`;
CREATE TABLE `vrp_user_moneys` (
  `user_id` int(11) NOT NULL,
  `wallet` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `debt` int(11) DEFAULT 0,
  `depositOnLogin` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_user_vehicles`
--

CREATE TABLE IF NOT EXISTS `player_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `iban` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `messages` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `number` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(4) DEFAULT 0,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `crypto_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_gallery` (
   `citizenid` VARCHAR(255) NOT NULL , 
   `image` VARCHAR(255) NOT NULL ,
   `date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `firstName` varchar(25) DEFAULT NULL,
  `lastName` varchar(25) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `url` text DEFAULT NULL,
  `picture` text DEFAULT './img/default.png',
  `tweetId` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `crypto` (
  `crypto` varchar(50) NOT NULL DEFAULT 'qbit',
  `worth` int(11) NOT NULL DEFAULT 0,
  `history` text DEFAULT NULL,
  PRIMARY KEY (`crypto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `crypto` VALUES ('qbit', 1000, '[{"NewWorth":1000,"PreviousWorth":1000}]');

CREATE TABLE IF NOT EXISTS `lapraces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `vrp_user_vehicles`;
CREATE TABLE `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `veh_type` varchar(255) NOT NULL DEFAULT 'default',
  `vehicle_plate` varchar(255) NOT NULL,
  `impound` int(11) NOT NULL DEFAULT 0,
  `hashkey` varchar(255) DEFAULT NULL,
  `vehicle_colorprimary` varchar(255) DEFAULT NULL,
  `modifications` mediumtext NOT NULL,
  `vehicle_colorsecondary` varchar(255) DEFAULT NULL,
  `vehicle_fuel` varchar(50) DEFAULT '60.0',
  `vehicle_damage` varchar(50) DEFAULT '1000.0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vrp_wanted`
--

DROP TABLE IF EXISTS `vrp_wanted`;
CREATE TABLE `vrp_wanted` (
  `user_id` int(11) DEFAULT NULL,
  `wantedreason` varchar(100) DEFAULT NULL,
  `wantedby` int(11) DEFAULT NULL,
  `timestamp` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `vrp_srv_data`
--
ALTER TABLE `vrp_srv_data`
  ADD PRIMARY KEY (`dkey`);

--
-- Indeks for tabel `vrp_users`
--
ALTER TABLE `vrp_users`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `vrp_user_business`
--
ALTER TABLE `vrp_user_business`
  ADD PRIMARY KEY (`user_id`);

--
-- Indeks for tabel `vrp_user_data`
--
ALTER TABLE `vrp_user_data`
  ADD PRIMARY KEY (`user_id`,`dkey`);

--
-- Indeks for tabel `vrp_user_homes`
--
ALTER TABLE `vrp_user_homes`
  ADD PRIMARY KEY (`user_id`);

--
-- Indeks for tabel `vrp_user_ids`
--
ALTER TABLE `vrp_user_ids`
  ADD PRIMARY KEY (`identifier`),
  ADD KEY `fk_user_ids_users` (`user_id`);

--
-- Indeks for tabel `vrp_user_moneys`
--
ALTER TABLE `vrp_user_moneys`
  ADD PRIMARY KEY (`user_id`);

--
-- Indeks for tabel `vrp_user_vehicles`
--
ALTER TABLE `vrp_user_vehicles`
  ADD PRIMARY KEY (`user_id`,`vehicle`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `vrp_users`
--
ALTER TABLE `vrp_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Begrænsninger for tabel `vrp_user_business`
--
ALTER TABLE `vrp_user_business`
  ADD CONSTRAINT `fk_user_business_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `vrp_user_data`
--
ALTER TABLE `vrp_user_data`
  ADD CONSTRAINT `fk_user_data_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `vrp_user_homes`
--
ALTER TABLE `vrp_user_homes`
  ADD CONSTRAINT `fk_user_homes_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `vrp_user_ids`
--
ALTER TABLE `vrp_user_ids`
  ADD CONSTRAINT `fk_user_ids_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `vrp_user_moneys`
--
ALTER TABLE `vrp_user_moneys`
  ADD CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
