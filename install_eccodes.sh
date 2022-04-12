#!/bin/bash

if [[ -z ${BASEDIR} ]]; then
        echo -e "run\n\n\tsource set_volta_environment\n\nfirst!"
        exit 1
fi

cd ${SOURCEDIR}
rm -rf ${SOURCEDIR}/eccodes
git clone https://github.com/ecmwf/eccodes.git   # ssh doesn't work on volta
cd eccodes
git checkout master
rm -rf ${BUILDDIR}/eccodes
mkdir -p ${BUILDDIR}/eccodes
cd ${BUILDDIR}/eccodes
ecbuild --toolchain=${SOURCEDIR}/toolchain-volta.cmake --prefix=${INSTALLDIR}/eccodes -DENABLE_MEMFS=ON -DENABLE_AEC=OFF ${SOURCEDIR}/eccodes
make -j4 
rm -rf ${INSTALLDIR}/eccodes
make install

