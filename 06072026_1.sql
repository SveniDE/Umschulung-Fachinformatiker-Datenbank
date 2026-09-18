-- neue DB erstellen
 
/* mehrzeiliger
Kommentar*/
 
CREATE DATABASE if NOT EXISTS webshop;
 
USE webshop;
 
-- erstellen Tabelle Kategorie, da sie von keiner Tabelle direkt abhängig ist
 
CREATE TABLE if NOT EXISTS kategorie(
	kategorieID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	bezeichnung VARCHAR(50)
	);
-- Tabelle überprüfen
 
DESCRIBE kategorie;
 
-- referenzierte Tabelle muss vorher existieren
CREATE TABLE if NOT EXISTS artikel(
	artikelID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	artikelName VARCHAR(75) NOT NULL,
	beschreibung TEXT,
	preis DECIMAL(10,2),
	kategorieID INT UNSIGNED NOT NULL,
	/* Ein Index beschleunigt das Suchen, Sortieren und Verknüpfen,
	kostet aber zusätzlichen Speicherplatz.
	Wichtig: PRIMARY KEY und UNIQUE erzeugen automatisch einen Index.*/
	INDEX idx_artikel_name (artikelName),
	-- FOREIGN KEY (kategorieID) REFERENCE kategorie (kategorieID)
	CONSTRAINT artikel_kategorie
		FOREIGN KEY (kategorieID)
		REFERENCES kategorie (kategorieID)
		-- ON UPDATE CASCADE: Änderungen in der Tabelle kategorie
		-- werden automatisch in der Tabelle artikel mitgeändert
		ON UPDATE CASCADE
		-- ON DELETE NO ACTION: Es kann keine kategorie gelöscht werden
		-- Artikel auf diese kategorie verweisen
		ON DELETE NO ACTION
	);

INSERT INTO kategorie (bezeichnung)
	values
		('Hardware'),
		('Software'),
		('Zubehör');
		