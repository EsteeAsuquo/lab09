-- SQL QUERIES
/*
SELECT * FROM Game ORDER BY time DESC;
SELECT * FROM Game WHERE time >= NOW() - INTERVAL '7 days';
SELECT * FROM Player WHERE name IS NOT NULL;
SELECT DISTINCT playerID FROM PlayerGame WHERE score > 2000;
SELECT * FROM Player where emailAddress LIKE '%@gmail.edu';
*/

-- Multiple-Table Queries 
SELECT PlayerGame.score FROM PlayerGame JOIN Player ON PlayerGame.playerID = Player.ID
WHERE Player.name = 'The King' ORDER BY PlayerGame.score DESC;

SELECT Player.name FROM Player JOIN PlayerGame ON Player.ID = PlayerGame.playerID
JOIN Game ON PlayerGame.gameID = Game.ID WHERE Game.time = '2006-06-28 13:20:00'
ORDER BY PlayerGame.score DESC LIMIT 1;

-- P1.ID < P2.ID is used to avoid duplicate pairs and also self pairing when joining a table to itself. It gives you one unique combination.
-- A realistic situation could be to find all pairs of players who played in the same game.
