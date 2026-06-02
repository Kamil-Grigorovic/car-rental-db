-- Dropping Tables

DROP INDEX idx_unique_email;
DROP INDEX idx_kuras;

DROP VIEW kagr0999.Aktyvios_nuomos;
DROP VIEW kagr0999.Top_automobiliai;
DROP MATERIALIZED VIEW kagr0999.Automobiliu_diagnostikos_santrauka;

DROP TABLE kagr0999.Nuoma;
DROP TABLE kagr0999.Megstamas_automobilis;
DROP TABLE kagr0999.Diagnostika;
DROP TABLE kagr0999.Vartotojas;
DROP TABLE kagr0999.Automobilis;


-- Deleting Data
DELETE FROM kagr0999.Megstamas_automobilis;
DELETE FROM kagr0999.Diagnostika;
DELETE FROM kagr0999.Nuoma;
DELETE FROM kagr0999.Automobilis;
DELETE FROM kagr0999.Vartotojas;
