#!/bin/bash

if [[ -z ${BASEDIR} ]]; then
        echo -e "run\n\n\tsource set_volta_environment\n\nfirst!"
        exit 1
fi

if [[ ! -d ${SOURCEDIR}/etrans ]]; then
        #git clone ${HOME}/accord/ectrans/etrans/
        git clone https://github.com/ddegrauwe/etrans.git
	cd ${SOURCEDIR}/etrans
        git checkout gpu_daand_lam
fi

rm -rf ${BUILDDIR}/etrans
mkdir -p ${BUILDDIR}/etrans
cd ${BUILDDIR}/etrans
ecbuild --toolchain=${SOURCEDIR}/toolchain-volta.cmake --prefix=${INSTALLDIR}/etrans -Dectrans_ROOT=${INSTALLDIR}/ectrans -Dfiat_ROOT=${INSTALLDIR}/fiat ${SOURCEDIR}/etrans
make -j4 
rm -rf ${INSTALLDIR}/etrans
make install

