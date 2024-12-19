--
-- This SQL script builds a monopoly database, deleting any pre-existing version.
--
-- @author kvlinden
-- @version Summer, 2015
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS PlayerProperty;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS PlayerStatus;
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;

-- Create the schema.
CREATE TABLE Game (
	ID integer PRIMARY KEY,
	time timestamp
	);

CREATE TABLE Player (
	ID integer PRIMARY KEY, 
	emailAddress varchar(50) NOT NULL,
	name varchar(50)
	);

CREATE TABLE PlayerGame (
	gameID integer REFERENCES Game(ID), 
	playerID integer REFERENCES Player(ID),
	score integer
	);
CREATE TABLE PlayerStatus (
    gameID integer REFERENCES Game(ID),
    playerID integer REFERENCES Player(ID),
    cash integer,
    current_position integer,
    PRIMARY KEY (gameID, playerID)
);

CREATE TABLE Property (
    propertyID integer PRIMARY KEY,
    name varchar(50) NOT NULL,
    cost integer,
    colorgroup varchar(50)
);

CREATE TABLE PlayerProperty (
    gameID integer REFERENCES Game(ID),
    playerID integer REFERENCES Player(ID),
    propertyID integer REFERENCES Property(propertyID),
    numHouses integer DEFAULT 0,
    numHotels integer DEFAULT 0,
    PRIMARY KEY (gameID, playerID, propertyID)
);

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON PlayerStatus TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;
GRANT SELECT ON PlayerProperty TO PUBLIC;

-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO PlayerGame VALUES (1, 1, 0.00);
INSERT INTO PlayerGame VALUES (1, 2, 0.00);
INSERT INTO PlayerGame VALUES (1, 3, 2350.00);
INSERT INTO PlayerGame VALUES (2, 1, 1000.00);
INSERT INTO PlayerGame VALUES (2, 2, 0.00);
INSERT INTO PlayerGame VALUES (2, 3, 500.00);
INSERT INTO PlayerGame VALUES (3, 2, 0.00);
INSERT INTO PlayerGame VALUES (3, 3, 5500.00);

INSERT INTO PlayerStatus (gameID, playerID, cash, current_position) VALUES (1, 1, 1500, 0);
INSERT INTO PlayerStatus VALUES (1, 2, 1500, 0);
INSERT INTO PlayerStatus VALUES (1, 3, 1500, 0);

INSERT INTO Property (propertyID, name, cost, colorgroup) VALUES (1, 'Boardwalk', 400, 'Blue');
INSERT INTO Property VALUES (2, 'Park Place', 350, 'Blue');

INSERT INTO PlayerProperty (gameID, playerID, propertyID, numHouses, numHotels) VALUES (1, 1, 1, 0, 0);
INSERT INTO PlayerProperty VALUES (1, 2, 2, 2, 1);
