#!/bin/bash

if [[ -z ${BASEDIR} ]]; then
        echo -e "run\n\n\tsource set_volta_environment\n\nfirst!"
        exit 1
fi

cd ${SOURCEDIR}
rm -rf ${SOURCEDIR}/ecbuild
#git clone git@github.com:ecmwf/ecbuild.git
git clone https://github.com/ecmwf/ecbuild.git   # ssh doesn't work on volta
cd ecbuild
git checkout master
rm -rf ${BUILDDIR}/ecbuild
mkdir -p ${BUILDDIR}/ecbuild
cd ${BUILDDIR}/ecbuild
${SOURCEDIR}/ecbuild/bin/ecbuild --prefix=${INSTALLDIR}/ecbuild -DENABLE_INSTALL=ON ${SOURCEDIR}/ecbuild 
make
rm -rf ${INSTALLDIR}/ecbuild
make install

