#!/bin/bash

if [[ -z ${BASEDIR} ]]; then
        echo -e "run\n\n\tsource set_volta_environment\n\nfirst!"
        exit 1
fi

if [[ ! -d ${SOURCEDIR}/ectrans ]]; then
        cd ${SOURCEDIR}
        rm -rf ${SOURCEDIR}/ectrans
	#git clone ${HOME}/accord/ectrans/ectrans/
        #git clone /home/ms/be/cv9/accord/ectrans/ectrans/
        git clone https://github.com/ThomasBurgot/ectrans.git
	cd ${SOURCEDIR}/ectrans
        git checkout gpu_thomasb
fi

rm -rf ${BUILDDIR}/ectrans
mkdir -p ${BUILDDIR}/ectrans
cd ${BUILDDIR}/ectrans
ecbuild --toolchain=${SOURCEDIR}/toolchain-volta.cmake --prefix=${INSTALLDIR}/ectrans -Dfiat_ROOT=${INSTALLDIR}/fiat -Deccodes_ROOT=${INSTALLDIR}/eccodes -DNVTX_ROOT=${INSTALLDIR}/nvtx -DENABLE_GPU=ON -DENABLE_FFTW=OFF ${SOURCEDIR}/ectrans
make -j4 
rm -rf ${INSTALLDIR}/ectrans
make install

