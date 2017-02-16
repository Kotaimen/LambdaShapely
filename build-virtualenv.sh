#!/usr/bin/env bash

WORKDIR=${WORKDIR:-/tmp/}
PREFIX=${PREFIX:-/tmp/venv}

mkdir -p ${PREFIX}
cd ${WORKDIR}

echo Creating virtualenv...
if [ ! -f ${PREFIX}/bin/activate ]; then
    virtualenv ${PREFIX}
    source ${PREFIX}/bin/activate
    pip install --upgrade pip
else
    source ${PREFIX}/bin/activate
fi

echo Building geos...
GEOS_VERSION=3.6.1
if [ ! -f ${PREFIX}/lib/libgeos-${GEOS_VERSION}.so ]; then
    curl -sSL http://download.osgeo.org/geos/geos-${GEOS_VERSION}.tar.bz2 | tar -xj
    cd geos-${GEOS_VERSION}
    ./configure --prefix=${PREFIX}
    make -j $(nproc)
    make install
fi

echo Pip install...
pip install \
    requests \
    geojson \
    shapely

echo Done.
deactivate
