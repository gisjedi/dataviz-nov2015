#!/bin/bash

# Pull down VIIRS tiffs for mosaic
DATA_DIR='/srv/geoserver/data/landsat'
CONFIG_DIR='/srv/geoserver/mosaics/landsat'
mkdir -p ${DATA_DIR}
mkdir -p ${CONFIG_DIR}
cd ${DATA_DIR}

wget 'http://landsat-pds.s3.amazonaws.com/L8/027/039/LC80270392015025LGN00/LC80270392015025LGN00_B2.TIF'
wget 'http://landsat-pds.s3.amazonaws.com/L8/027/039/LC80270392015025LGN00/LC80270392015025LGN00_B3.TIF'
wget 'http://landsat-pds.s3.amazonaws.com/L8/027/039/LC80270392015025LGN00/LC80270392015025LGN00_B4.TIF'

gdal_merge.py -init 255 -o LC80270392015025LGN00_BV.TIF LC80270392015025LGN00_B2.TIF LC80270392015025LGN00_B3.TIF LC80270392015025LGN00_B4.TIF

# Toss all input files
ls | grep -v _BV.TIF | xargs rm

# Copy in the mosaic configuration
cp /tmp/geoserver/landsat/* ${CONFIG_DIR}

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
curl -v -u admin:geoserver -XPOST -H "Content-type: text/xml" -d "<workspace><name>mosaic</name></workspace>" http://localhost:8080/geoserver/rest/workspaces
curl -v -u admin:geoserver -XPOST -T ${DIR}/landsat-store.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/mosaic/coveragestores
curl -v -u admin:geoserver -XPOST -T ${DIR}/landsat.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/mosaic/coveragestores/landsat/coverages
