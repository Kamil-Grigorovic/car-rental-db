-- 1
-- Indexes
CREATE UNIQUE INDEX idx_unique_email ON kagr0999.Vartotojas(el_pastas);
CREATE INDEX idx_kuras ON kagr0999.Automobilis(kuro_tipas);

-- 2
-- Active Rentals
CREATE VIEW kagr0999.Aktyvios_nuomos AS
SELECT
    n.Nr,
    v.Vardas,
    v.Pavarde,
    a.Marke,
    a.Modelis,
    n.Nuomos_pradzia,
    n.Nuomos_pabaiga
FROM
    kagr0999.Nuoma AS n
    JOIN kagr0999.Vartotojas AS v ON v.ID = n.Vartotojo_ID
    JOIN kagr0999.Automobilis AS a ON a.VIN = n.Automobilio_VIN
WHERE
    CURRENT_DATE BETWEEN n.Nuomos_pradzia AND n.Nuomos_pabaiga;

-- Most Popular Cars by Rating
CREATE VIEW kagr0999.Top_automobiliai AS
SELECT
    a.VIN,
    a.Marke,
    a.Modelis,
    COUNT(*) AS Ivairuotoju_kiekis
FROM
    kagr0999.Megstamas_automobilis AS m 
    JOIN kagr0999.Automobilis AS a 
                                        ON a.VIN = m.Automobilio_VIN
WHERE
    m.Ivertinimas > 3
GROUP BY
    a.VIN, a.Marke, a.Modelis
ORDER BY
    Ivairuotoju_kiekis DESC;

-- 3
-- Total Diagnostic Cost per Vehicle
CREATE MATERIALIZED VIEW kagr0999.Automobiliu_diagnostikos_santrauka AS
SELECT
    a.VIN,
    a.Marke,
    a.Modelis,
    COUNT(d.Nr) AS Diagnostiku_kiekis,
    SUM(d.Kaina) AS Bendra_kaina
FROM
    kagr0999.Automobilis a
JOIN
    kagr0999.Diagnostika d ON d.Automobilio_VIN = a.VIN
GROUP BY
    a.VIN, a.Marke, a.Modelis;

