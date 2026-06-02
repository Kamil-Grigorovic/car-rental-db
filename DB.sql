CREATE TABLE kagr0999.Vartotojas (
    ID               INTEGER              PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    Vardas           CHAR(12)    NOT NULL,
    Pavarde          VARCHAR(20) NOT NULL,
    Gimimo_data      DATE        NOT NULL CONSTRAINT PatikraAmzius 
                                          CHECK(Gimimo_data <= CURRENT_DATE - INTERVAL '18 years'), 
    Telefono_numeris CHAR(12)    NOT NULL,
    El_pastas        VARCHAR(50) NOT NULL
);

CREATE TABLE kagr0999.Automobilis (
    VIN         CHAR(17)     NOT NULL CONSTRAINT PatikraVINIlgis 
                                      CHECK (CHAR_LENGTH(VIN) = 17),
    Marke       VARCHAR(30)  NOT NULL,
    Modelis     VARCHAR(20)  NOT NULL,
    Metai       SMALLINT     NOT NULL CONSTRAINT PatikraMetai
                                      CHECK(Metai >= 2015 AND Metai <= EXTRACT(YEAR FROM CURRENT_DATE)),
    Kuro_tipas  CHAR(10)     NOT NULL DEFAULT 'Benzinas',
    Kaina       DECIMAL(5,2) NOT NULL CONSTRAINT KainosDydis 
                                      CHECK(Kaina > 0),
    PRIMARY KEY (VIN)
);

CREATE TABLE kagr0999.Nuoma (
    Nr              INTEGER                PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    Vartotojo_ID    INTEGER       NOT NULL,
    Automobilio_VIN CHAR(17)      NOT NULL,
    Miestas         VARCHAR(20)   NOT NULL,
    Kaina           DECIMAL(5,2)  NOT NULL CONSTRAINT KainosDydis_Nuoma 
                                           CHECK(Kaina > 0),
    Nuomos_pradzia  DATE          NOT NULL DEFAULT CURRENT_DATE,
    Nuomos_pabaiga  DATE          NOT NULL CONSTRAINT PatikraLaikotarpis
                                           CHECK(Nuomos_pradzia <= Nuomos_pabaiga),
    CONSTRAINT FK_Vartotojas FOREIGN KEY (Vartotojo_ID)  REFERENCES kagr0999.Vartotojas  ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Automobilis FOREIGN KEY (Automobilio_VIN)  REFERENCES kagr0999.Automobilis  ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE kagr0999.Megstamas_automobilis (
    Vartotojo_ID    INTEGER     NOT NULL,
    Automobilio_VIN CHAR(17)    NOT NULL,
    Pridejimo_data  DATE        NOT NULL DEFAULT CURRENT_DATE,
    Ivertinimas     SMALLINT    NOT NULL CONSTRAINT PatikraIvertinimas
                                         CHECK(Ivertinimas >= 1 AND Ivertinimas <= 5),
    PRIMARY KEY (Vartotojo_ID, Automobilio_VIN),
    CONSTRAINT FK_Vartotojas FOREIGN KEY (Vartotojo_ID)  REFERENCES kagr0999.Vartotojas  ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Automobilis FOREIGN KEY (Automobilio_VIN)  REFERENCES kagr0999.Automobilis  ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE kagr0999.Diagnostika (
    Nr                  INTEGER               PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    Automobilio_VIN     CHAR(17)     NOT NULL,
    Diagnostikos_data   DATE         NOT NULL DEFAULT CURRENT_DATE,
    Tipas               CHAR(16)     NOT NULL DEFAULT 'Remontas' 
                                              CHECK(Tipas IN ('Remontas', 'Techninė apžiūra')),
    Kaina               DECIMAL(6,2) NOT NULL CONSTRAINT KainosDydis_Diagnostika 
                                              CHECK(Kaina > 0),
    CONSTRAINT FK_Automobilis FOREIGN KEY (Automobilio_VIN)  REFERENCES kagr0999.Automobilis  ON DELETE CASCADE ON UPDATE RESTRICT
);


