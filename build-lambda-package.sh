#!/usr/bin/env bash

set -e

docker run --rm \
    -v $(pwd)/build-virtualenv.sh:/build.sh \
    -v $(pwd)/build/venv:/lambda/venv \
    --entrypoint=bash lambdabuild /build.sh

PACKAGE_DIR=$(pwd)/build/lambda-package
mkdir -p ${PACKAGE_DIR}

cp src/*.py ${PACKAGE_DIR}
cp -r build/venv/lib/python2.7/site-packages/ ${PACKAGE_DIR}
cp -r build/venv/lib64/python2.7/site-packages/ ${PACKAGE_DIR}
cp build/venv/lib/libgeos_c.so ${PACKAGE_DIR}
cp build/venv/lib/libgeos-*.so ${PACKAGE_DIR}

rm -rf ${PACKAGE_DIR}/pip ${PACKAGE_DIR}/setuptools ${PACKAGE_DIR}/*.dist-info

pushd ${PACKAGE_DIR}
zip -r9 ../lambda-package.zip *
popd
