#!/bin/bash

docker exec dockercomposemodis_postgis_1 su - postgres -c "bash /tmp/postgis/initial-viirs-dnb.sh"

docker exec dockercomposemodis_geoserver_1 apt-get install curl wget -y
docker exec dockercomposemodis_geoserver_1 bash /tmp/geoserver/initial-viirs-dnb.sh
