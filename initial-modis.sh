#!/bin/bash

POST_CONTAINER=`docker-compose ps -q postgis`
GEOSERVER_CONTAINER=`docker-compose ps -q geoserver`
docker exec ${POST_CONTAINER} apt-get install curl wget unzip -y
docker exec ${POST_CONTAINER} su - postgres -c "bash /tmp/postgis/initial-modis.sh"

docker exec ${GEOSERVER_CONTAINER} apt-get install curl -y
docker exec ${GEOSERVER_CONTAINER} bash /tmp/geoserver/initial-modis.sh
