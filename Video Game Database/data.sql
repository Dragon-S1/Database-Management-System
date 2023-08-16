SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET GLOBAL local_infile=1;

--
-- Dumping data for table player
--
DELETE FROM player;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/player.txt"
INTO TABLE player
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(name, wins, losses, team, membership);

--
-- Dumping data for table friend
--
DELETE FROM friend;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/friend.txt"
INTO TABLE friend
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

--
-- Dumping data for table match
--
DELETE FROM `match`;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/match.txt"
INTO TABLE `match`
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(player1, player2, winner);

--
-- Dumping data for table playerTitle
--
DELETE FROM playerTitle;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/playerTitle.txt"
INTO TABLE playerTitle
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

--
-- Dumping data for table mission
--
DELETE FROM mission;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mission.txt"
INTO TABLE mission
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(name, description);

--
-- Dumping data for table accomplished
--
DELETE FROM accomplished;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/accomplished.txt"
INTO TABLE accomplished
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

--
-- Dumping data for table reward
--
DELETE FROM reward;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reward.txt"
INTO TABLE reward
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

--
-- Dumping data for table itemType
--
DELETE FROM itemType;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/itemType.txt"
INTO TABLE itemType
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

--
-- Dumping data for table item
--
DELETE FROM item;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/item.txt"
INTO TABLE item
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

--
-- Dumping data for table membership
--
DELETE FROM membership;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/membership.txt"
INTO TABLE membership
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

--
-- Dumping data for table membershipReward
--
DELETE FROM membershipReward;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/membershipReward.txt"
INTO TABLE membershipReward
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

--
-- Dumping data for table team
--
DELETE FROM team;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/team.txt"
INTO TABLE team
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(name, members, wins, losses);

--
-- Dumping data for table teamMatch
--
DELETE FROM teamMatch;
LOAD DATA LOCAL INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/teamMatch.txt"
INTO TABLE teamMatch
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(team1, team2, winner);

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;