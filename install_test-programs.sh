#!/bin/bash

if [[ -z ${BASEDIR} ]]; then
        echo -e "run\n\n\tsource set_volta_environment\n\nfirst!"
        exit 1
fi

cd ${SOURCEDIR}

mkdir -p ${INSTALLDIR}/test-programs/bin

rm -rf ${BUILDDIR}/test-programs
mkdir -p ${BUILDDIR}/test-programs
cd ${BUILDDIR}/test-programs

ff=driver-spectraltransform
for precision in sp dp; do
        echo "Compiling ${ff}_${precision}"
        mpif90 -I${INSTALLDIR}/ectrans/include/ectrans -I${INSTALLDIR}/fiat/include/fiat \
                -I${INSTALLDIR}/ectrans/module/trans_gpu_static_CA_${precision} -I${INSTALLDIR}/fiat/module/fiat \
                -I${INSTALLDIR}/fiat/module/parkind_${precision} \
                -O0 -g -acc -Minfo=acc -gpu=cc70,lineinfo,deepcopy,fastmath,nordc -fpic \
                ${SOURCEDIR}/test-programs/${ff}.F90 -o ${INSTALLDIR}/test-programs/bin/${ff}_${precision} \
                -lgpu -cudalib=cufft,cublas -lnvToolsExt \
                -L${INSTALLDIR}/fiat/lib/ -lfiat -lparkind_${precision} -L${INSTALLDIR}/ectrans/lib/ -ltrans_gpu_static_CA_${precision} -lgpu \
                -L${INSTALLDIR}/nvtx/lib -lnvtx -lblas -llapack
done

ff=dwarf_bifft
for precision in sp dp; do
        echo "Compiling ${ff}_${precision}"
        mpif90 -I${INSTALLDIR}/etrans/include/etrans -I${INSTALLDIR}/ectrans/include/ectrans -I${INSTALLDIR}/fiat/include/fiat \
                -I${INSTALLDIR}/ectrans/module/trans_gpu_static_CA_${precision} -I${INSTALLDIR}/etrans/module/etrans_${precision} -I${INSTALLDIR}/fiat/module/fiat \
                -I${INSTALLDIR}/fiat/module/parkind_${precision} \
                -O2 -g -traceback -acc -Minfo=acc -gpu=cc70,lineinfo,deepcopy,fastmath,nordc -fpic \
                ${SOURCEDIR}/test-programs/${ff}.F90 -o ${INSTALLDIR}/test-programs/bin/${ff}_${precision} \
                -L${INSTALLDIR}/etrans/lib/ -letrans_${precision} \
                -L${INSTALLDIR}/ectrans/lib/ -ltrans_gpu_static_CA_${precision} -lgpu -L${INSTALLDIR}/fiat/lib/ -lfiat -lparkind_${precision} \
                -L${INSTALLDIR}/nvtx/lib -lnvtx -cudalib=cufft,cublas -lnvToolsExt -lblas -llapack
done

