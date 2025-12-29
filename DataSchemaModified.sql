CREATE TABLE lightData (       
    lightID SERIAL PRIMARY KEY,
    userID INTEGER,
    lightLevel INTEGER CHECK (lightLevel < 0),  -- ❌ Некоректна логіка (менше нуля)
    measuredAt TIMESTAMP NOT NULL
);
