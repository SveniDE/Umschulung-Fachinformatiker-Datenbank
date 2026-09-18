-- Aufgaben zu Datumsfunktionen

-- 1. Zeigen Sie zu jeder Bestellung den Monatsnamen und Wochentag an.
-- 	Ausgabe: bestellungId, datum, monat, wochentag
-- 	Hinweis: SET lc_time_names = 'de_DE'; -> deutsche Ausgabe

SET lc_time_names = 'de_DE';
SELECT bestellungId, datum, DATE_FORMAT (datum, '%M') AS monat , DATE_FORMAT (datum, '%W') AS wochentag FROM bestellung;


-- 2. Berechnen Sie, wie viele Tage seit der Kundenerstellung vergangen sind.
--		Ausgabe: kundeId, kunde(Vor- und Nachname),kundeErstellt, tage_seit_anlage

SELECT kundeId ,CONCAT (vorname, ' ', nachname), kundeErstellt, DATEDIFF(CURRENT_DATE  , kundeErstellt) AS tage_seit_anlage
FROM kunde;

-- 3. Geben Sie in einer Ausgabe jeweils das aktuelle Datum, die aktuelle Uhrzeit 
-- 	und den aktuellen Zeitstempel mit sinnvollen Spaltennamen aus.
--		Ausgabe: heutiges_datum, aktuelle_uhrzeit, aktueller_zeitstempel

SELECT Current_DATE AS heutiges_datum, Current_TIME AS aktuell_uhrzeit, CURRENT_TIMESTAMP AS aktueller_zeitstempel;


-- 4. Geben Sie aus der aktuellen Uhrzeit die Stunde, Minute und Sekunde getrennt aus.
--		Ausgabe: stunde, minuten, sekunden

SELECT HOUR(CURRENT_TIMESTAMP) AS stunde, MINUTE (CURRENT_TIMESTAMP) AS minuten, SECOND(CURRENT_TIMESTAMP) AS sekunden ;

-- 5. Zeigen Sie zu jeder Bestellung das Bestelldatum sowie Jahr, Monat und Tag separat an.
--		Ausgabe: bestellungId, datum, jahr, monat, tag

SELECT bestellungId, DATE(datum) AS datum, YEAR(datum) AS jahr, MONTH(datum) AS monat, DAY(datum) AS tag  FROM bestellung;

-- 6. Zeigen Sie alle Bestellungen aus dem Jahr 2025.
--		Ausgabe: bestellungId, datum, bestellStatus

SELECT bestellungId, datum, bestellStatus FROM bestellung WHERE YEAR(datum)=2025;

-- 7. Zeigen Sie alle Bestellungen vom 01.11.2025 bis einschließlich 15.11.2025.

SELECT * FROM bestellung WHERE datum BETWEEN '2025-11-01' AND '2025-11-15';
-- 8. Zeigen Sie alle Bestellungen aus dem Jahr 2025, die nicht im November liegen.

SELECT * FROM bestellung WHERE MONTH(datum) =! '11' AND YEAR(datum)= '2025';

-- 9. Zeigen Sie, wie viele Kunden pro Kalendertag erstellt wurden. 
-- 	Ausgabe: erstellungsdatum, anzahl_kunden

SELECT kundeErstellt AS erstellungsdatum, COUNT(kundeId) AS anzahl_kunden FROM kunde GROUP BY kundeErstellt ORDER BY kundeErstellt DESC;

-- 10. Berechnen Sie zu jeder Bestellung ein voraussichtliches Lieferdatum fünf Tage nach dem Bestelldatum.
--		 Ausgabe: bestellungid, bestelldatum, lieferdatum


SELECT bestellungId, datum AS bestelldatum, DATE_ADD (datum, INTERVAL  5 DAY) AS lieferdatum FROM bestellung;
-- 11. Das Zahlungsziel liegt 14 Tage nach der Bestellung. Drei Tage vor dem Zahlungsziel 
-- 	 soll eine Erinnerung erfolgen. 
-- 	 Zeigen Sie Bestelldatum, Zahlungsziel und Erinnerungsdatum zu der jeder bestellungId.


-- 12. Das Zahlungsziel liegt 14 Tage nach der Bestellung. 
-- 	 Zeigen Sie alle Bestellungen, deren Zahlungsziel im Dezember 2025 liegt.
-- 	 Ausgabe: bestellungId, bestelldatum, zahlungsziel


-- 13. Zeigen Sie Kunden mit Name und Erstellungsdatum im Format TT.MM.JJJJ HH:MM.
