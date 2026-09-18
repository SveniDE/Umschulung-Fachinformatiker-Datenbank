-- JOINS

-- INNER JOINS, nur Datensätze, die in beiden Tabellen verknüpft sind

-- Zeige Bestellungen mit den passenden Kundennachnamen an
-- Tabellen: bestellung und kunde
-- Verknüpfung: bestellung.kundeId = kunde.kundeId

SELECT bestellung.bestellungId, bestellung.datum, bestellung.bestellStatus,
		k.vorname, k.nachname
FROM bestellung
INNER JOIN kunde AS k
	ON bestellung.kundeId = k.kundeId;
	
SELECT b.bestellungId, b.datum, b.bestellStatus,b.kundeId,
		k.kundeId, k.vorname, k.nachname
FROM bestellung b
JOIN kunde k
	ON b.kundeId = k.kundeId;

-- LEFT JOIN -> alle Datensätze (Zeilen) aus der linken Tabelle werden ausgegeben,
-- und deren Bestellungen, Kunden, die bisher keine Bestellungen haben werden auch angezeigt,
-- aber mit NULL-Werten bei Bestellungen
-- Alle Kunden sollen angezeigt werden, mit deren Bestellungen
-- kunde ist linke Tabelle, weil alle Kunden ausgegeben werden sollen
SELECT b.bestellungId, b.datum, b.bestellStatus,b.kundeId,
		k.kundeId, k.vorname, k.nachname	
FROM kunde k
LEFT JOIN bestellung b
	ON b.kundeId = k.kundeId;
	
-- Welche Kunden haben noch nie bestellt, Ausgabe?
SELECT k.kundeId, k.vorname, k.nachname
FROM kunde k
LEFT JOIN bestellung b
	ON b.kundeId = k.kundeId
WHERE b.bestellungId IS NULL
ORDER BY k.KundeId;

-- Artikel ausgeben mit den Kategorienamen
-- Artikel und Kategorie
SELECT a.artikelId, a.artikelName, k.bezeichnung
FROM artikel a
JOIN kategorie k
	ON a.kategorieId = k.kategorieId;


-- Nur Softwareartikel ausgeben mit Kategoriebezeichnung
SELECT a.artikelId, a.artikelName, k.bezeichnung
FROM artikel a
JOIN kategorie k
	ON a.kategorieId = k.kategorieId
WHERE k.bezeichnung = 'Zubehör'
ORDER BY a.artikelName;

-- Welche Artikel stehen in welcher Bestellung und was kostet jede Position
-- Tabellen: bestellung, artikel (artikelName, preis), position (anzahl)

SELECT b.bestellungId, p.positionId, a.artikelName, a.preis, p.anzahl, 
		a.preis * p.anzahl AS positionswert
FROM bestellung b
JOIN position p
		ON b.bestellungId = p.bestellungId
JOIN artikel a
		ON a.artikelId = p.artikelId
ORDER BY b.bestellungId, p.positionId;

-- gemischter JOIN
-- Zeigen Sie alle Artikel mit ihrer Kategorie an. Zusätzlich soll angezeigt werden, 
-- wie oft der Artikel insgesamt bestellt wurde.
-- Artikel, die noch nie bestellt wurden, sollen trotzdem angezeigt werden.
-- Ausgabe: artikelId, artikelName, kategoriebezeichnung, preis, gesamt_bestellt
SELECT a.artikelId, a.artikelName, k.bezeichnung, a.preis,
		SUM(p.anzahl) AS gesamt_bestellt
FROM artikel a
JOIN kategorie k
		ON a.kategorieId = k.kategorieId
LEFT JOIN position p
		ON a.artikelId = p.artikelId
GROUP BY a.artikelId, a.artikelName, k.bezeichnung, a.preis
ORDER BY k.bezeichnung, a.artikelName; 

