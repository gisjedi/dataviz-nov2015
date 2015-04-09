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
echo stripping file name to prefix
SHAPEFILEPRE=${SHAPEFILEZIP/_shapefile/}
SHAPEFILEPRE=`echo $SHAPEFILEPRE | cut -d "." -f 1`
shp2pgsql -I -c -D -s 4326 $SHAPEFILEPRE.shp public.modis_${YEAR} > /tmp/tempdata.sql

# Start  database so that we can execute the data intialization tasks
/etc/init.d/postgresql start 
psql -c "CREATE DATABASE testdb;"
psql -c "CREATE EXTENSION postgis;" testdb
psql -f /tmp/tempdata.sql testdb

# Cleanup scratch files
rm $SHAPEFILEPRE.*
rm /tmp/tempdata.sql
