#!/bin/bash

docker exec dockercomposegeodata_postgis_1 apt-get install curl wget unzip -y
docker exec dockercomposegeodata_postgis_1 su - postgres -c "bash /tmp/postgis/initial-modis.sh"

docker exec dockercomposegeodata_geoserver_1 apt-get install curl -y
docker exec dockercomposegeodata_geoserver_1 bash /tmp/geoserver/initial-modis.sh
