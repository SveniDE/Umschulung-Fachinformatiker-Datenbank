webshopwebshop-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server-Version:               12.2.2-MariaDB - MariaDB Server
-- Server-Betriebssystem:        Win64
-- HeidiSQL Version:             12.14.0.7165
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Exportiere Datenbank-Struktur für webshop
CREATE DATABASE IF NOT EXISTS `webshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `webshop`;

-- Exportiere Struktur von Tabelle webshop.artikel
CREATE TABLE IF NOT EXISTS `artikel` (
  `artikelId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `artikelName` varchar(150) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `preis` decimal(10,2) NOT NULL CHECK (`preis` > 0),
  `kategorieId` int(10) unsigned NOT NULL,
  `lagerbestand` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`artikelId`),
  KEY `idx_artikel_name` (`artikelName`),
  KEY `artikel_kategorie` (`kategorieId`),
  CONSTRAINT `artikel_kategorie` FOREIGN KEY (`kategorieId`) REFERENCES `kategorie` (`kategorieId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportiere Daten aus Tabelle webshop.artikel: ~4 rows (ungefähr)
INSERT INTO `artikel` (`artikelId`, `artikelName`, `beschreibung`, `preis`, `kategorieId`, `lagerbestand`) VALUES
	(1, 'Bildschirm', '27"', 149.00, 1, 1),
	(2, 'Maus', 'Gaming Maus mit 5 Tasten', 35.00, 3, 0),
	(3, 'Tastatur', '', 34.90, 3, 12),
	(4, 'Windows 11', 'Professional', 120.00, 2, 30);

-- Exportiere Struktur von Tabelle webshop.bestellung
CREATE TABLE IF NOT EXISTS `bestellung` (
  `bestellungId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `datum` date DEFAULT NULL,
  `bestellStatus` enum('offen','in Bearbeitung','versendet','geschlossen') NOT NULL DEFAULT 'offen',
  `kundeId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`bestellungId`),
  KEY `bestellung_kunde` (`kundeId`),
  CONSTRAINT `bestellung_kunde` FOREIGN KEY (`kundeId`) REFERENCES `kunde` (`kundeId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportiere Daten aus Tabelle webshop.bestellung: ~4 rows (ungefähr)
INSERT INTO `bestellung` (`bestellungId`, `datum`, `bestellStatus`, `kundeId`) VALUES
	(1, '2025-11-04', 'versendet', 3),
	(2, '2025-11-13', 'in Bearbeitung', 2),
	(3, '2025-11-13', 'geschlossen', 1),
	(4, '2025-11-29', 'versendet', 1);

-- Exportiere Struktur von Tabelle webshop.kategorie
CREATE TABLE IF NOT EXISTS `kategorie` (
  `kategorieId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bezeichnung` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kategorieId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportiere Daten aus Tabelle webshop.kategorie: ~3 rows (ungefähr)
INSERT INTO `kategorie` (`kategorieId`, `bezeichnung`) VALUES
	(1, 'Hardware'),
	(2, 'Software'),
	(3, 'Zubehör');

-- Exportiere Struktur von Tabelle webshop.kunde
CREATE TABLE IF NOT EXISTS `kunde` (
  `aktiv` tinyint(1) DEFAULT 1,
  `kundeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vorname` varchar(50) NOT NULL,
  `nachname` varchar(50) NOT NULL,
  `gebDatum` date DEFAULT NULL,
  `strasse` varchar(75) DEFAULT NULL,
  `plz` char(5) DEFAULT NULL,
  `ort` varchar(75) DEFAULT NULL,
  `eMail` varchar(100) DEFAULT NULL,
  `kundeErstellt` datetime NOT NULL DEFAULT current_timestamp(),
  `telefon` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kundeId`),
  UNIQUE KEY `mail` (`eMail`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportiere Daten aus Tabelle webshop.kunde: ~8 rows (ungefähr)
INSERT INTO `kunde` (`aktiv`, `kundeId`, `vorname`, `nachname`, `gebDatum`, `strasse`, `plz`, `ort`, `eMail`, `kundeErstellt`, `telefon`) VALUES
	(NULL, 1, 'Max', 'Müller', NULL, 'Hauptstraße 12', '10115', 'Potsdam', 'max.mueller@example.com', '2026-07-07 09:08:55', NULL),
	(NULL, 2, 'Laura', 'Schmidt', NULL, 'Bahnhofstraße 7', '20095', 'Hamburg', 'laura.schmidt@example.com', '2026-07-07 09:08:55', NULL),
	(NULL, 3, 'Tim', 'Weber', NULL, 'Gartenweg 3', '50667', 'Köln', 'tim.weber@example.com', '2026-07-07 09:08:55', NULL),
	(NULL, 4, 'Sofia', 'Klein', NULL, 'Ringstraße 44', '80331', 'München', 'sofia.klein@example.com', '2026-07-07 09:08:55', NULL),
	(NULL, 5, 'Jonas', 'Fischer', NULL, 'Buchenallee 9', '80331', 'München', 'jonas.fischer@example.com', '2026-07-07 09:08:55', NULL),
	(NULL, 6, 'Mila', 'Klein', NULL, 'Seestraße 28', '70173', 'Stuttgart', 'mila.klein@example.com', '2026-07-07 09:08:55', NULL),
	(1, 8, 'Max', 'Mustermann', '2026-07-09', 'Teststarasse 1', '11111', 'Musterstadt', '', '2026-07-09 12:08:23', '1234-5678'),
	(1, 10, 'Lisa', 'Musterfrau', '2026-07-09', 'Teststarasse 1', '80331', 'Stuttgart', 'muster@web.de', '2026-07-09 13:22:28', '1234-5678');

-- Exportiere Struktur von Tabelle webshop.kunde_alt
CREATE TABLE IF NOT EXISTS `kunde_alt` (
  `aktiv` tinyint(1) DEFAULT 1,
  `kundeId` int(10) unsigned NOT NULL DEFAULT 0,
  `vorname` varchar(50) NOT NULL,
  `nachname` varchar(50) NOT NULL,
  `gebDatum` date DEFAULT NULL,
  `strasse` varchar(75) DEFAULT NULL,
  `plz` char(5) DEFAULT NULL,
  `ort` varchar(75) DEFAULT NULL,
  `eMail` varchar(100) DEFAULT NULL,
  `kundeErstellt` datetime NOT NULL DEFAULT current_timestamp(),
  `telefon` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportiere Daten aus Tabelle webshop.kunde_alt: ~8 rows (ungefähr)
INSERT INTO `kunde_alt` (`aktiv`, `kundeId`, `vorname`, `nachname`, `gebDatum`, `strasse`, `plz`, `ort`, `eMail`, `kundeErstellt`, `telefon`) VALUES
	(NULL, 1, 'Max', 'Müller', NULL, 'Hauptstraße 12', '10115', 'Potsdam', 'max.mueller@example.com', '2026-07-07 09:08:55', NULL),
	(NULL, 2, 'Laura', 'Schmidt', NULL, 'Bahnhofstraße 7', '20095', 'Hamburg', 'laura.schmidt@example.com', '2026-07-07 09:08:55', NULL),
	(NULL, 3, 'Tim', 'Weber', NULL, 'Gartenweg 3', '50667', 'Köln', 'tim.weber@example.com', '2026-07-07 09:08:55', NULL),
	(NULL, 4, 'Sofia', 'Klein', NULL, 'Ringstraße 44', '80331', 'München', 'sofia.klein@example.com', '2026-07-07 09:08:55', NULL),
	(NULL, 5, 'Jonas', 'Fischer', NULL, 'Buchenallee 9', '80331', 'München', 'jonas.fischer@example.com', '2026-07-07 09:08:55', NULL),
	(NULL, 6, 'Mila', 'Klein', NULL, 'Seestraße 28', '70173', 'Stuttgart', 'mila.klein@example.com', '2026-07-07 09:08:55', NULL),
	(1, 8, 'Max', 'Mustermann', '2026-07-09', 'Teststarasse 1', '11111', 'Musterstadt', '', '2026-07-09 12:08:23', '1234-5678'),
	(1, 10, 'Lisa', 'Musterfrau', '2026-07-09', 'Teststarasse 1', '80331', 'Stuttgart', 'muster@web.de', '2026-07-09 13:22:28', '1234-5678');

-- Exportiere Struktur von Tabelle webshop.lieferant
CREATE TABLE IF NOT EXISTS `lieferant` (
  `aktiv` tinyint(1) DEFAULT 1,
  `lieferantID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firma` varchar(50) NOT NULL,
  `strasse` varchar(75) DEFAULT NULL,
  `plz` char(5) DEFAULT NULL,
  `ort` varchar(75) DEFAULT NULL,
  `eMail` varchar(100) DEFAULT NULL,
  `lieferantErstellt` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`lieferantID`),
  UNIQUE KEY `mail` (`eMail`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportiere Daten aus Tabelle webshop.lieferant: ~4 rows (ungefähr)
INSERT INTO `lieferant` (`aktiv`, `lieferantID`, `firma`, `strasse`, `plz`, `ort`, `eMail`, `lieferantErstellt`) VALUES
	(1, 1, 'Bürobedarf Müller GmbH', 'Industriestr. 12', '80331', 'München', 'info@mueller-buero.de', '2026-07-09 13:43:14'),
	(1, 2, 'IT-Systeme Nord AG', 'Hafenweg 4', '20095', 'Hamburg', 'kontakt@it-nord.de', '2026-07-09 13:43:14'),
	(1, 3, 'Hardware König KG', 'Technikallee 8', '10115', 'Berlin', 'vertrieb@hardware-koenig.de', '2026-07-09 13:43:14'),
	(1, 4, 'Büro & Papier Schneider GmbH', 'Kölner Str. 22', '50667', 'Köln', 'service@papier-schneider.de', '2026-07-09 13:43:14');

-- Exportiere Struktur von Tabelle webshop.position
CREATE TABLE IF NOT EXISTS `position` (
  `positionId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `anzahl` int(10) unsigned NOT NULL,
  `artikelId` int(10) unsigned NOT NULL,
  `bestellungId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`positionId`),
  KEY `position_artikel` (`artikelId`),
  KEY `position_bestellung` (`bestellungId`),
  CONSTRAINT `position_artikel` FOREIGN KEY (`artikelId`) REFERENCES `artikel` (`artikelId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `position_bestellung` FOREIGN KEY (`bestellungId`) REFERENCES `bestellung` (`bestellungId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportiere Daten aus Tabelle webshop.position: ~6 rows (ungefähr)
INSERT INTO `position` (`positionId`, `anzahl`, `artikelId`, `bestellungId`) VALUES
	(1, 2, 3, 1),
	(2, 10, 1, 1),
	(3, 1, 1, 2),
	(4, 4, 4, 3),
	(5, 1, 3, 3),
	(6, 2, 2, 4);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
