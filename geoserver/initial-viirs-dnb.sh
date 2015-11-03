#!/bin/bash

# Pull down VIIRS tiffs for mosaic
VIIRS_DIR='/srv/geoserver/mosiacs/viirs-dnb'
mkdir -p ${VIIRS_DIR}
cd ${VIIRS_DIR}

FTP_URL='ftp://ftp.ssec.wisc.edu/pub/eosdb/npp/viirs/'
ACCEPT_PATTERN='npp_viirs_adaptive_dnb*.tif'
# -nc No clobber, i.e. don't retrieve existing files
# -nd No directories. Flatten the tree and place all files in current directory
# -np No parent. Don't ascend the directory tree.
# --follow-ftp Traverse FTP links
# -A Accept pattern to use for files.
# -r Recursively search the directory tree.

wget -nc -nd -np --follow-ftp -A ${ACCEPT_PATTERN} -r ${FTP_URL}

cp /tmp/geoserver/viirs-dnb/* ${VIIRS_DIR}

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
curl -v -u admin:geoserver -XDELETE http://localhost:8080/geoserver/rest/workspaces/mosaic?recurse=true
curl -v -u admin:geoserver -XPOST -H "Content-type: text/xml" -d "<workspace><name>mosaic</name></workspace>" http://localhost:8080/geoserver/rest/workspaces
curl -v -u admin:geoserver -XPOST -T ${DIR}/viirs-store.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/mosaic/coveragestores
curl -v -u admin:geoserver -XPOST -T ${DIR}/viirs-dnb.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/mosaic/coveragestores/viirs-dnb/coverages
