#!/bin/sh

# vmangos-docker
# Copyright (C) 2021-present  Michael Serajnik  https://sr.ht/~mser/

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

script_path=$(readlink -f "$0")
repository_path=$(dirname "$script_path")

rm -f "$repository_path/config/*.conf"
cp "$repository_path/config/mangosd.conf.example" \
  "$repository_path/config/mangosd.conf"
cp "$repository_path/config/realmd.conf.example" \
  "$repository_path/config/realmd.conf"

rm -f "$repository_path/docker-compose.yml"
cp "$repository_path/docker-compose.yml.example" \
  "$repository_path/docker-compose.yml"

echo "[VMaNGOS]: Config creation complete!"
