-- 1. Zeigen Sie alle Kunden, auch ohne Betsellung im Juli und die Anzahl ihrer Bestellungen
-- im Juli 2026.

SELECT k.kundeId, k.nachname, COUNT(b.bestellungId) AS anzahl_bestellungen
FROM kunde k
LEFT JOIN bestellung b
	ON k.kundeId = b.kundeId
	AND b.datum >= '2026-07-01'
	AND b.datum < '2026-08-01'
GROUP BY k.kundeId;



-- 2. CROSS JOIN / kartesisches Produkt
-- jede Zeile der einen Tabelle wird mit jeder Zeile der anderen Tabelle kombiniert
--
-- CROSS JOIN wird selten benötigt, ist aber wichtig als Fehlerverständnis:
-- Ein vergessener JOIN-Filter kann sehr viele falsche Kombinationen erzeugen.

-- Beispiel kunde, kategorie

SELECT k.kundeId, k.nachname, ka.kategorieId, ka.bezeichnung
FROM kunde k
CROSS JOIN kategorie ka
ORDER BY k.kundeId, ka.kategorieId;




-- FULL OUTER JOIN
/*
Ein FULL JOIN (auch als FULL OUTER JOIN bekannt) in SQL verknüpft zwei 
Tabellen und gibt alle Datensätze aus beiden Tabellen zurück. 
Wenn es keine Übereinstimmung gibt, wird das Ergebnis für die 
fehlenden Spalten mit NULL aufgefüllt. 
Also:
LEFT JOIN + RIGHT JOIN zusammen
Wichtig für MariaDB:
MariaDB unterstützt normalerweise keinen direkten Befehl:
FULL OUTER JOIN
Deshalb baut man ihn mit LEFT JOIN, RIGHT JOIN und UNION nach.*/

-- Beispiel mit kunde und lieferant
-- Kunden und Lieferanten nach gleichem Ort vergleichen.
-- 3. Zeigen Sie alle Orte, in denen Kunden und/oder Lieferanten vorkommen.
SELECT
    COALESCE(k.ort, l.ort) AS ort,
    k.kundeId,
    CONCAT(k.vorname, ' ', k.nachname) AS kunde,
    l.lieferantId,
    l.firma AS lieferant
FROM kunde AS k
LEFT JOIN lieferant AS l
    ON k.ort = l.ort

UNION

SELECT
    COALESCE(k.ort, l.ort) AS ort,
    k.kundeId,
    CONCAT(k.vorname, ' ', k.nachname) AS kunde,
    l.lieferantId,
    l.firma AS lieferant
FROM kunde AS k
RIGHT JOIN lieferant AS l
    ON k.ort = l.ort

ORDER BY ort, kunde, lieferant;







-- FULL OUTER JOIN EXCLUDING INNER JOIN
/*
Zeigen Sie nur die Datensätze, die nicht zusammenpassen.
Also:
Kundenorte ohne passenden Lieferantenort 
Lieferantenorte ohne passenden Kundenort 
Aber nicht:
Orte, die auf beiden Seiten vorkommen 
Das nennt man auch manchmal:
FULL OUTER JOIN ohne Schnittmenge
Oder mathematisch:
symmetrische Differenz*/
-- 4. Nur Kunden/Lieferanten ohne passenden Ort
SELECT
    COALESCE(k.ort, l.ort) AS ort,
    k.kundeId,
    CONCAT(k.vorname, ' ', k.nachname) AS kunde,
    l.lieferantId,
    l.firma AS lieferant
FROM kunde AS k
LEFT JOIN lieferant AS l
    ON k.ort = l.ort
WHERE l.lieferantId IS NULL

UNION

SELECT
    COALESCE(k.ort, l.ort) AS ort,
    k.kundeId,
    CONCAT(k.vorname, ' ', k.nachname) AS kunde,
    l.lieferantId,
    l.firma AS lieferant
FROM kunde AS k
RIGHT JOIN lieferant AS l
    ON k.ort = l.ort
WHERE k.kundeId IS NULL

ORDER BY ort, kunde, lieferant;



-- 5. Mischjoin
-- Zeigen Sie alle Bestellungen mit Kundennamen.
-- Zusätzlich sollen, falls vorhanden, die Positionszeilen, Artikel und Kategorien angezeigt werden.
-- Bestellungen ohne Positionszeilen sollen trotzdem erscheinen.
INSERT INTO bestellung(datum, bestellStatus, kundeId)
	VALUES('2026-07-14', 'offen', 1);

SELECT b.bestellungId, CONCAT (k.vorname, ' ', k.nachname) AS Kundenname,p.positionId AS Positionszeile,
a.artikelName AS artikel, ka.bezeichnung AS kategorie
FROM bestellung b
JOIN kunde k
	ON b.kundeId = k.kundeId
LEFT JOIN `position` p
	ON b.bestellungId = p.bestellungId
LEFT JOIN artikel a
	ON a.artikelId	= p.artikelId
LEFT JOIN kategorie ka
	ON a.kategorieId = ka.kategorieId
ORDER BY b.bestellungId;


-- Verkettungsaufgaben

/*	AND kommt vor OR:
	WHERE A OR B AND C
	wird gelesen als:
	WHERE A OR (B AND C)

	Verkettung von OR: IN() -> mindestens ein Wert passt
	AND: NOT IN() -> kein Wert darf passen
	
	Bei LIKE muss jede Bedingung vollständig angegeben sein.
	*/

-- 6. Zeigen Sie alle Kunden aus Hamburg oder Köln an.
	SELECT kundeId, nachname, ort
	FROM kunde
	WHERE (ort = 'Hamburg'
		OR ort = 'Köln')
		AND gebDatum IS NOT NULL;
		
	SELECT kundeId, nachname, ort
	FROM kunde
	WHERE ort IN('Hamburg', 'Köln')
		AND gebDatum IS NOT NULL;
		
		-- Operatoren Nicht -> '<>' oder !=
	
-- 7. Zeigen Sie alle Kunden aus Hamburg oder Berlin an, die eine E-Mail-Adresse eingetragen haben.

	SELECT kundeId, nachname, ort
	FROM kunde
	WHERE ort IN('Hamburg', 'Köln')
		AND eMail IS NOT NULL;

-- 8. Zeigen Sie alle Bestellungen mit Status offen oder in Bearbeitung, aber nur ab dem 01.07.2026.

SELECT *
FROM bestellung
WHERE bestellStatus IN ('offen', 'in Bearbeitung')
AND datum >='2026-07.01';

-- 9. Zeigen Sie alle Artikel an, die unter 50 Euro kosten und zur Kategorie 1 oder 2 gehören.
	
SELECT * FROM artikel WHERE preis < 50 AND (kategorieId = 1 OR kategorieId = 2);

-- 10. Zeigen Sie Artikel an, die entweder:
-- aus Kategorie 1 sind und unter 50 Euro kosten
-- oder 
-- aus Kategorie 2 sind und mindestens 100 Euro kosten. 

SELECT * FROM artikel WHERE kategorieId = 1 AND preis < 50 OR kategorieId = 2 AND preis >= 100;