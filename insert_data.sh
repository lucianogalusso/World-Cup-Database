#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#database creation
#chmod +x insert_data.sh

SELECT_TEAMS="SELECT team_id FROM teams WHERE name="
INSERT_TEAMS="INSERT INTO teams(name) VALUES"
INSERT_GAMES="INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES"

#first insert teams
awk -F, -v PSQL="$PSQL" -v INSERT_TEAMS="$INSERT_TEAMS" '
NR==1 { next }
{ 
  system(PSQL " \"" INSERT_TEAMS " (\x27" $3 "\x27);\"")
  system(PSQL " \"" INSERT_TEAMS " (\x27" $4 "\x27);\"")
}' games.csv

#then insert games
awk -F, -v PSQL="$PSQL" -v SELECT_TEAMS="$SELECT_TEAMS" -v INSERT_GAMES="$INSERT_GAMES" '
NR==1 { next }
{ 
  cmd = PSQL " \"" SELECT_TEAMS " \x27" $3 "\x27;\""
  cmd | getline WINNER_ID
  close(cmd)

  cmd = PSQL " \"" SELECT_TEAMS " \x27" $4 "\x27;\""
  cmd | getline OPPONENT_ID
  close(cmd)

  system(PSQL " \"" INSERT_GAMES " ("$1",\x27" $2 "\x27,"WINNER_ID","OPPONENT_ID","$5","$6");\"")
}' games.csv
