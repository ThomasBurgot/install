#!/bin/bash

if [[ -z ${BASEDIR} ]]; then
        echo -e "run\n\n\tsource set_volta_environment\n\nfirst!"
        exit 1
fi


cd ${SOURCEDIR}
rm -rf ${SOURCEDIR}/fiat
git clone https://github.com/ecmwf-ifs/fiat.git
cd fiat
git checkout main
rm -rf ${BUILDDIR}/fiat
mkdir -p ${BUILDDIR}/fiat
cd ${BUILDDIR}/fiat
ecbuild --toolchain=${SOURCEDIR}/toolchain-volta.cmake --prefix=${INSTALLDIR}/fiat ${SOURCEDIR}/fiat
make -j4 
rm -rf ${INSTALLDIR}/fiat
make install
