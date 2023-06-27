#!/bin/bash

#Get variables defined in .env

source .env

#Date and Time Variable

date_time=$(date "+%Y.%m.%d-%H.%M.%S")

#Handle script call from other directory

get_script_path() {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
repository_path=$(dirname "$(get_script_path "$0")")
cd "$repository_path"

echo "[VMaNGOS]: Merging database migrations..."

cd ./src/github_core/sql/migrations
./merge.sh
cd "$repository_path"

echo "[VMaNGOS]: Copying database migrations to /vol/database..."

cp -r ./src/github_core/sql/migrations/ ./vol/database/
cp -r ./src/github_core/sql/migrations/ ./vol/database/
cp -r ./src/github_core/sql/migrations/ ./vol/database/
cp -r ./src/github_core/sql/migrations/ ./vol/database/

echo "[VMaNGOS]: Importing migrations..."

docker exec vmangos_database /bin/sh \
  '[ -e /opt/core/sql/migrations/world_db_updates.sql ] mariadb -u mangos -p$MYSQL_ROOT_PASSWORD mangos < /src/github_core/sql/migrations/"$date_time"_world_db_updates.sql'
docker exec vmangos_database /bin/sh \
  '[ -e /opt/core/sql/migrations/characters_db_updates.sql ] mariadb -u mangos -p$MYSQL_ROOT_PASSWORD characters < /src/github_core/sql/migrations/"$date_time"_characters_db_updates.sql'
docker exec vmangos_database /bin/sh \ 
  '[ -e /opt/core/sql/migrations/logon_db_updates.sql ] mariadb -u mangos -p$MYSQL_ROOT_PASSWORD realmd < /src/github_core/sql/migrations/"$date_time"_logon_db_updates.sql'
docker exec vmangos_database /bin/sh \ 
  '[ -e /opt/core/sql/migrations/logs_db_updates.sql ] mariadb -u mangos -p$MYSQL_ROOT_PASSWORD logs < /src/github_core/sql/migrations/"$date_time"_logs_db_updates.sql'

echo "[VMaNGOS]: Importing database updates..."
