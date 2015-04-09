#!/bin/bash

docker exec dockercomposemodis_postgis_1 apt-get install curl wget unzip -y
docker exec dockercomposemodis_postgis_1 su - postgres -c "bash /tmp/postgis/initial-data.sh" 

docker exec dockercomposemodis_geoserver_1 apt-get install curl -y
docker exec dockercomposemodis_geoserver_1 bash /tmp/geoserver/initial-data.sh 
