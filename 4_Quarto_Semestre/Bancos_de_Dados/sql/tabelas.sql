-- EXTENSIONS
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- DROP TABLES
DROP TABLE IF EXISTS FRIENDS, GAMELIBRARY, REVIEWS, GAMETAG, GAMEDEVELOPER, TAG, GAMEUSER, DEVELOPER, GAME CASCADE;

-- CREATE 
CREATE TABLE GAME (
    codgame SERIAL PRIMARY KEY,
    gamename VARCHAR(255) NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL DEFAULT 0.00 CHECK (price >= 0.00),
    description TEXT NOT NULL,
    estimated_owners VARCHAR(100) NOT NULL,
    launch_date DATE NOT NULL,
    positive_reviews INT NOT NULL,
    negative_reviews INT NOT NULL,
    average_play_time INT NOT NULL
);

CREATE TABLE DEVELOPER (
    coddev SERIAL PRIMARY KEY,
    devname VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE GAMEUSER (
    coduser SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    wallet_balance DECIMAL(10, 2) NOT NULL DEFAULT 0.00 CHECK(wallet_balance >= 0.00),
    birth_date DATE NOT NULL,
    birth_name VARCHAR(100) NOT NULL
);

CREATE TABLE TAG (
    codtag SERIAL PRIMARY KEY,
    nametag VARCHAR(100) NOT NULL UNIQUE
);

-- Association Tables (Many-to-Many Relationships)
CREATE TABLE GAMEDEVELOPER (
    codgame INT,
    coddev INT,
    PRIMARY KEY (codgame, coddev),
    FOREIGN KEY (codgame) REFERENCES GAME(codgame),
    FOREIGN KEY (coddev) REFERENCES DEVELOPER(coddev)
);

CREATE TABLE GAMETAG (
    codgame INT,
    codtag INT,
    PRIMARY KEY (codgame, codtag),
    FOREIGN KEY (codgame) REFERENCES GAME(codgame),
    FOREIGN KEY (codtag) REFERENCES TAG(codtag)
);

-- Dependent Tables (One-to-Many Weak Entities)
CREATE TABLE REVIEWS (
    coduser INT NOT NULL,
    codgame INT NOT NULL,
    ispositive BOOLEAN NOT NULL,
    review TEXT,
    PRIMARY KEY (coduser, codgame),
    FOREIGN KEY (coduser) REFERENCES GAMEUSER(coduser),
    FOREIGN KEY (codgame) REFERENCES GAME(codgame)
);

-- User Interaction Tables
CREATE TABLE GAMELIBRARY (
    codgame INT,
    coduser INT,
    purchase_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    playtime INT NOT NULL DEFAULT 0,
    PRIMARY KEY (codgame, coduser),
    FOREIGN KEY (codgame) REFERENCES GAME(codgame),
    FOREIGN KEY (coduser) REFERENCES GAMEUSER(coduser)
);

CREATE TABLE FRIENDS (
    friend_requester INT,
    friend_receiver INT,
    -- Restrições para o status, o conteudo de status só pode ser pending, accepted ou rejected.
    status VARCHAR(50) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'rejected')),
    PRIMARY KEY (friend_requester, friend_receiver),
    FOREIGN KEY (friend_requester) REFERENCES GAMEUSER(coduser),
    FOREIGN KEY (friend_receiver) REFERENCES GAMEUSER(coduser),
    -- Impede amizante consigo memso.
    CHECK (friend_requester <> friend_receiver) 
);


CREATE TABLE SCREENSHOT(
    codgame INT,
    screenshot_url VARCHAR(250) UNIQUE NOT NULL,
    PRIMARY KEY (screenshot_url,codgame),
    FOREIGN KEY (codgame) REFERENCES GAME (codgame)
)