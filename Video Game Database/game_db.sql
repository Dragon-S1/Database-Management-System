SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

-- Create database game_db

create database if not exists game_db;
use game_db;

--
-- Table structure for table player
--

DROP TABLE IF EXISTS player;
CREATE TABLE player (
  id BIGINT NOT NULL AUTO_INCREMENT,
  name varchar(20) NOT NULL,
  wins INT DEFAULT 0,
  losses INT DEFAULT 0,
  team BIGINT DEFAULT NULL,
  membership varchar(20) DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (team) REFERENCES team (id) ON DELETE SET NULL,
  FOREIGN KEY (membership) REFERENCES membership (name) ON DELETE SET NULL
) ;

--
-- Table structure for table friend
--

DROP TABLE IF EXISTS friend;
CREATE TABLE friend (
  player BIGINT NOT NULL,
  friend BIGINT NOT NULL,
  PRIMARY KEY (player, friend),
  FOREIGN KEY (player) REFERENCES player (id) ON DELETE CASCADE,
  FOREIGN KEY (friend) REFERENCES player (id) ON DELETE CASCADE
) ;

--
-- Table structure for table match
--

DROP TABLE IF EXISTS `match`;
CREATE TABLE `match` (
  id BIGINT NOT NULL AUTO_INCREMENT,
  player1 BIGINT NOT NULL,
  player2 BIGINT NOT NULL,
  winner BIGINT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (player1) REFERENCES player (id),
  FOREIGN KEY (player2) REFERENCES player (id),
  FOREIGN KEY (winner) REFERENCES player (id)
) ;

--
-- Table structure for table playerTitle
--

DROP TABLE IF EXISTS playerTitle;
CREATE TABLE playerTitle (
  player BIGINT NOT NULL,
  title varchar(20) NOT NULL,
  PRIMARY KEY (player,title),
  FOREIGN KEY (player) REFERENCES player (id) ON DELETE CASCADE
) ;

--
-- Table structure for table mission
--

DROP TABLE IF EXISTS mission;
CREATE TABLE mission (
  id BIGINT NOT NULL AUTO_INCREMENT,
  name varchar(20) NOT NULL,
  description varchar(256) NOT NULL,
  PRIMARY KEY (id)
) ;

--
-- Table structure for table accomplished
--

DROP TABLE IF EXISTS accomplished;
CREATE TABLE accomplished (
  player BIGINT NOT NULL,
  mission BIGINT NOT NULL,
  PRIMARY KEY (player, mission),
  FOREIGN KEY (player) REFERENCES player (id) ON DELETE CASCADE,
  FOREIGN KEY (mission) REFERENCES mission (id) ON DELETE CASCADE
) ;

--
-- Table structure for table reward
--

DROP TABLE IF EXISTS reward;
CREATE TABLE reward (
  mission BIGINT NOT NULL,
  type varchar(20) NOT NULL,
  PRIMARY KEY (mission, type),
  FOREIGN KEY (mission) REFERENCES mission (id) ON DELETE CASCADE,
  FOREIGN KEY (type) REFERENCES itemType (type) ON DELETE CASCADE
) ;

--
-- Table structure for table itemType
--

DROP TABLE IF EXISTS itemType;
CREATE TABLE itemType (
  type varchar(20) NOT NULL,
  PRIMARY KEY (type)
) ;

--
-- Table structure for table item
--

DROP TABLE IF EXISTS item;

CREATE TABLE item (
  type varchar(20) NOT NULL,
  id BIGINT NOT NULL,
  name varchar(20) NOT NULL,
  attack INT,
  defense INT,
  owner BIGINT NOT NULL,
  PRIMARY KEY (type, id),
  FOREIGN KEY (type) REFERENCES itemType (type) ON DELETE CASCADE,
  FOREIGN KEY (owner) REFERENCES player (id) ON DELETE CASCADE
) ;

--
-- Table structure for table membership
--

DROP TABLE IF EXISTS membership;
CREATE TABLE membership (
  name varchar(20) NOT NULL,
  price INT NOT NULL,
  PRIMARY KEY (name)
) ;

--
-- Table structure for table membershipReward
--

DROP TABLE IF EXISTS membershipReward;
CREATE TABLE membershipReward (
  membership varchar(20) NOT NULL,
  reward varchar(20) NOT NULL,
  PRIMARY KEY (membership, reward),
  FOREIGN KEY (membership) REFERENCES membership (name) ON DELETE CASCADE
) ;

--
-- Table structure for table team
--

DROP TABLE IF EXISTS team;
CREATE TABLE team (
  id BIGINT NOT NULL AUTO_INCREMENT,
  name varchar(20) DEFAULT NULL,
  members INT NOT NULL,
  wins INT DEFAULT 0,
  losses INT DEFAULT 0,
  PRIMARY KEY (id)
) ;

--
-- Table structure for table teamMatch
--

DROP TABLE IF EXISTS teamMatch;
CREATE TABLE teamMatch (
  id BIGINT NOT NULL AUTO_INCREMENT,
  team1 BIGINT NOT NULL,
  team2 BIGINT NOT NULL,
  winner BIGINT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (team1) REFERENCES team (id),
  FOREIGN KEY (team2) REFERENCES team (id),
  FOREIGN KEY (winner) REFERENCES team (id)
) ;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
