-- SQLite
CREATE TABLE IF NOT EXISTS Region(
    ID INTEGER PRIMARY KEY,
    AREA REAL,
    Name Text,
    HDI REAL,
    Acronym TEXT,
    Populacion INTEGER);
CREATE TABLE IF NOT EXISTS State(
    ID INTEGER PRIMARY KEY,
    FU text,
    HDI REAL,
    Region INTEGER NOT NULL,
    Populacion INTEGER,
    AREA REAL,
    Density REAL,
    Income REAL,
    FOREIGN KEY (Region) REFERENCES Region(ID)
);
CREATE TABLE IF NOT EXISTS Prevision(
    ID integer PRIMARY KEY,
    Age INTEGER,
    Sex Text,
    Year INTEGER,
    nMx REAL,
    nqx REAL,
    nAx REAL,
    lx INTEGER,
    ndx INTEGER,
    nLx INTEGER,
    Sx REAL,
    Tx INTEGER,
    ex REAL,
    STATE INTEGER NOT NULL,
    FOREIGN KEY (State) REFERENCES State(ID)
);