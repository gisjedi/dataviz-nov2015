#!/bin/bash

# Pull down VIIRS tiffs for mosaic
DATA_DIR='/srv/geoserver/data/landsat'
CONFIG_DIR='/srv/geoserver/mosaics/landsat'
PYTHON='/usr/bin/python'
mkdir -p ${DATA_DIR}
mkdir -p ${CONFIG_DIR}
cd ${DATA_DIR}

#FTP_URL='ftp://ftp.ssec.wisc.edu/pub/eosdb/npp/viirs/'
#ACCEPT_PATTERN='npp_viirs_adaptive_dnb*.tif'
#DIR_ACCEPT_PATTERN='pub/eosdb/npp/viirs/*,pub/eosdb/npp/viirs/*/geotiff'
# If you don't want to pull all 5 days you can use the following as a template to further restrict by day
#DIR_ACCEPT_PATTERN='pub/eosdb/npp/viirs/*,pub/eosdb/npp/viirs/2015_11_30_*/geotiff,pub/eosdb/npp/viirs/2015_12_01_*/geotiff'
# -nc No clobber, i.e. don't retrieve existing files.
# -nd No directories. Flatten the tree and place all files in current directory.
# -np No parent. Don't ascend the directory tree.
# --follow-ftp Traverse FTP links
# -A Accept pattern to use for files.
# -I Accept pattern to only include directories containing needed files.
# -r Recursively search the directory tree.

#wget -nc -nd -np --follow-ftp -A "${ACCEPT_PATTERN}" -I "${DIR_ACCEPT_PATTERN}" -r "${FTP_URL}"

#wget 'https://s3.amazonaws.com/ais-landsat/LC80270392015025LGN00.tar.gz'
#wget 'https://s3.amazonaws.com/ais-landsat/LC80270392015073LGN00.tar.gz'
#wget 'https://s3.amazonaws.com/ais-landsat/LC80270392015105LGN00.tar.gz'
#wget 'https://s3.amazonaws.com/ais-landsat/LC80270392015121LGN00.tar.gz'
#wget 'https://s3.amazonaws.com/ais-landsat/LC80270392015153LGN00.tar.gz'
#wget 'https://s3.amazonaws.com/ais-landsat/LC80270392015201LGN00.tar.gz'
#wget 'https://s3.amazonaws.com/ais-landsat/LC80270392015217LGN00.tar.gz'
#wget 'https://s3.amazonaws.com/ais-landsat/LC80270392015249LGN00.tar.gz'
#wget 'https://s3.amazonaws.com/ais-landsat/LC80270392015281LGN00.tar.gz'
#wget 'https://s3.amazonaws.com/ais-landsat/LC80270392015313LGN00.tar.gz'
#wget 'https://s3.amazonaws.com/ais-landsat/LC80270392015345LGN00.tar.gz'
#wget 'https://s3.amazonaws.com/ais-landsat/LO80270392015041LGN00.tar.gz'
wget 'http://landsat-pds.s3.amazonaws.com/L8/027/039/LC80270392015025LGN00/LC80270392015025LGN00_B2.TIF'
wget 'http://landsat-pds.s3.amazonaws.com/L8/027/039/LC80270392015025LGN00/LC80270392015025LGN00_B3.TIF'
wget 'http://landsat-pds.s3.amazonaws.com/L8/027/039/LC80270392015025LGN00/LC80270392015025LGN00_B4.TIF'

$PYTHON gdal_merge.py -init 255 -o LC80270392015025LGN00_BV.TIF LC80270392015025LGN00_B2.TIF LC80270392015025LGN00_B3.TIF LC80270392015025LGN00_B4.TIF

#rm LC80270392015025LGN00_B2.TIF
#rm LC80270392015025LGN00_B3.TIF
#rm LC80270392015025LGN00_B4.TIF

#for ARCHIVE_FILE in `ls *.tar.gz`; do
#    tar -xzvf ${ARCHIVE_FILE}
#    rm ${ARCHIVE_FILE}
#done

# Create inner tiles and overviews to ensure snappy rendering performance
#for FILE in `ls *.TIF`; do
#    echo ${FILE}
#    gdal_translate -co "TILED=YES" -co "BLOCKXSIZE=512" -co "BLOCKYSIZE=512" ${FILE} tiled_${FILE}
#    gdaladdo -r average tiled_${FILE} 2 4 8 16 32
#    mv tiled_${FILE} ${FILE}
#done

# Copy in the mosaic configuration
cp /tmp/geoserver/landsat/* ${CONFIG_DIR}

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
curl -v -u admin:geoserver -XPOST -H "Content-type: text/xml" -d "<workspace><name>mosaic</name></workspace>" http://localhost:8080/geoserver/rest/workspaces
curl -v -u admin:geoserver -XPOST -T ${DIR}/landsat-store.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/mosaic/coveragestores
curl -v -u admin:geoserver -XPOST -T ${DIR}/landsat.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/mosaic/coveragestores/landsat/coverages
