#!/bin/bash

YEAR=$(date +'%Y')
SOURCEPAGE=modisfire_${YEAR}_conus.htm

# Identify shapefile with current days data
wget http://activefiremaps.fs.fed.us/data/fireptdata/$SOURCEPAGE
SHAPEFILEZIP=`cat $SOURCEPAGE |grep shapefile -m 1| cut -d "\"" -f 2`
rm $SOURCEPAGE
echo $SHAPEFILEZIP

wget $SHAPEFILEZIP
SHAPEFILEZIP=$(basename $SHAPEFILEZIP)
unzip $SHAPEFILEZIP
rm $SHAPEFILEZIP

SHAPEFILEPRE=${SHAPEFILEZIP/_shapefile/}
SHAPEFILEPRE=`echo $SHAPEFILEPRE | cut -d "." -f 1`
echo $SHAPEFILEPRE
su - postgres -c "shp2pgsql -I -D -s 4326 $SHAPEFILEPRE.shp modis_${YEAR} | psql -U docker gis"

rm $SHAPEFILEPRE.*

