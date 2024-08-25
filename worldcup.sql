/*https://www.freecodecamp.org/learn/relational-database/build-a-world-cup-database-project/build-a-world-cup-database*/

CREATE DATABASE worldcup;

CREATE TABLE teams (
  team_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE games (
  game_id SERIAL PRIMARY KEY,
  round VARCHAR(255) NOT NULL,
  year INT NOT NULL,
  winner_id INT NOT NULL,
  opponent_id INT NOT NULL,
  winner_goals INT NOT NULL,
  opponent_goals INT NOT NULL,
  FOREIGN KEY (winner_id) REFERENCES teams(team_id),
  FOREIGN KEY (opponent_id) REFERENCES teams(team_id)
);
