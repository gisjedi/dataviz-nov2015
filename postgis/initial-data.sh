#!/bin/bash

# Identify year for pulling data
YEAR=$(date +'%Y')
SOURCEPAGE=modisfire_${YEAR}_conus.htm

# Identify shapefile with current days data
wget http://activefiremaps.fs.fed.us/data/fireptdata/$SOURCEPAGE
SHAPEFILEZIP=`cat $SOURCEPAGE |grep shapefile -m 1| cut -d "\"" -f 2`
rm $SOURCEPAGE
echo $SHAPEFILEZIP

# Grab file name only and unzip dataset
wget $SHAPEFILEZIP
SHAPEFILEZIP=$(basename $SHAPEFILEZIP)
unzip $SHAPEFILEZIP
rm $SHAPEFILEZIP

# Strip extension off name and convert shapefile to a SQL script
SHAPEFILEPRE=${SHAPEFILEZIP/_shapefile/}
SHAPEFILEPRE=`echo $SHAPEFILEPRE | cut -d "." -f 1`
echo $SHAPEFILEPRE
shp2pgsql -I -D -s 4326 $SHAPEFILEPRE.shp modis_${YEAR} > $SHAPEFILEPRE.sql

# Add test database
POSTGRES="gosu postgres postgres"

$POSTGRES --single -E <<EOSQL
CREATE DATABASE testdb
EOSQL

# Add postgis extension and load data
POSTGIS_CONFIG=/usr/share/postgresql/$PG_MAJOR/contrib/postgis-$POSTGIS_MAJOR
$POSTGRES --single testdb -j < $POSTGIS_CONFIG/postgis.sql
$POSTGRES --single testdb -j < $SHAPEFILEPRE.sql

# Cleanup scratch files
rm $SHAPEFILEPRE.*

