-- Aufgaben Joins

-- 1. Zeigen Sie alle Artikel mit Kategorienamen an, aber nur Artikel ab 40 Euro.
-- 	  Ausgabe: artikelId, artikelName, preis, kategorie

SELECT a.artikelId, a.artikelName, a.preis, k.bezeichnung AS kategorie
FROM artikel a
JOIN kategorie k
	ON a.kategorieId = k.kategorieId
WHERE a.preis >=40
ORDER BY a.preis;

-- 2. Zeigen Sie alle Kategorien und die Anzahl der zugeordneten Artikel.
-- 	  Auch Kategorien ohne Artikel sollen angezeigt werden.
-- 	  Ausgabe: kategorieId, bezeichnung, anzahl_artikel

SELECT k.kategorieId, k.bezeichnung, COUNT(a.artikelId) AS anzahl_artikel
FROM kategorie k
left JOIN artikel a
	ON a.kategorieId = k.kategorieId
GROUP BY k.bezeichnung;


-- 3. Zeigen Sie alle Kunden aus München und Hamburg mit ihren Bestellnummern.
-- 	  Kunden ohne Bestellung sollen trotzdem erscheinen.
-- 	  Ausgabe: kundeId, kunde, ort, bestellungId, datum

SELECT k.kundeId, CONCAT (k.vorname, ' ', k.nachname) AS kunde , k.ort, b.bestellungId, b.datum
FROM kunde k
LEFT JOIN bestellung b
	ON k.kundeId = b.kundeId
WHERE k.ort = 'München' or k.ort = 'Hamburg'
ORDER BY k.ort;

-- 4. Zeigen Sie je Bestellung die Anzahl der Positionszeilen.
-- 	  Ausgabe: bestellungId, datum, anzahl_positionen

SELECT b.bestellungId, b.datum, count(p.positionId) AS anzahl_position
FROM bestellung b 
JOIN `position` p ON b.bestellungId = p.bestellungId 
GROUP BY b.bestellungId, b.datum;


-- 5. Zeigen Sie Bestellungen, deren Bestellwert mindestens 200 Euro beträgt.
-- 	  Ausgabe: bestellungId, kunde, bestellwert

SELECT b.bestellungId, concat(k.nachname, ' ', k.vorname), SUM(a.preis * p.anzahl) AS bestellwert
FROM bestellung b 
JOIN kunde k 
	ON b.kundeId = k.kundeId 
JOIN `position` p 
	ON p.bestellungId = b.bestellungId 
JOIN artikel a 
	ON p.artikelId = a.artikelId
GROUP BY b.bestellungId
HAVING Bestellwert >= 200;


-- 6. Zeigen Sie alle Kunden mit ihrer letzten Bestellung.
-- 	  Kunden ohne Bestellung sollen ebenfalls angezeigt werden.
-- 	  Ausgabe: kundeId, kunde, letzte_bestellung

SELECT k.kundeId, CONCAT (k.vorname,' ', k.nachname) AS kunde, MAX(b.datum)
FROM kunde k
LEFT JOIN bestellung b
	ON k.kundeId = b.kundeId
GROUP BY k.kundeId;

-- 7. Zeigen Sie je Artikel, in wie vielen Positionszeilen er vorkommt.
-- 	Auch nie bestellte Artikel sollen erscheinen.
-- 	Ausgabe: artikelId, artikelName, anzahl_positionszeilen

SELECT a.artikelId, a.artikelName, COUNT(p.positionId) AS anzahl_positionszeilen
FROM artikel a
LEFT JOIN `position` p
	ON a.artikelId = p.artikelId
GROUP BY a.artikelId, a.artikelName;


-- 8. Zeigen Sie je Kategorie die insgesamt verkaufte Stückzahl.
-- 	Kategorien ohne Verkäufe sollen mit 0 angezeigt werden.
-- 	Ausgabe: kategorie, verkaufte_stueckzahl

SELECT k.bezeichnung, IFNULL(SUM(p.anzahl),0) AS verkaufte_stueckzahl
FROM kategorie k 
LEFT JOIN artikel a ON k.kategorieId = a.kategorieId 
LEFT JOIN `position` p ON p.artikelId = a.artikelId 
GROUP BY k.bezeichnung;


-- 9. Zeigen Sie alle Kunden, die eine Bestellung mit dem Status 'versendet' haben.
-- 	Ausgabe: kundeId, kunde

SELECT k.kundeId, k.nachname
FROM kunde k 
JOIN bestellung b 
ON k.kundeId = b.kundeId
WHERE b.bestellStatus = 'versendet';

-- 10. Zeigen Sie alle Kunden und zusätzlich, wie viele versendete Bestellungen sie haben.
-- 	Kunden ohne versendete Bestellung sollen mit 0 erscheinen.
-- 	Ausgabe: kundeId, kunde, anzahl_versendet

SELECT k.kundeId, k.nachname, count(b.bestellungId) AS anzahl_versendet

FROM kunde k 

LEFT JOIN bestellung b ON b.kundeId = k.kundeId

	AND b.bestellStatus = 'versendet'

GROUP BY k.kundeId, k.nachname;
 
 

-- 11. Zeigen Sie alle Bestellpositionen der Kategorie 'Zubehör'.
-- 	 Ausgabe: bestellungId, artikelName, kategorie, anzahl

SELECT p.bestellungId, a.artikelName, k.bezeichnung AS kategorie, p.anzahl
FROM `position` p
JOIN artikel a
	ON a.artikelId = p.artikelId
JOIN kategorie k
	ON k.kategorieId = a.kategorieId
WHERE k.bezeichnung = 'Zubehör';