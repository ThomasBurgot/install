#!/bin/bash

if [[ -z ${BASEDIR} ]]; then
        echo -e "run\n\n\tsource set_volta_environment\n\nfirst!"
        exit 1
fi


cd ${SOURCEDIR}
#rm -rf ${SOURCEDIR}/nvtx
#cp -r ${HOME}/accord/ectrans/nvtx ${SOURCEDIR}
cd nvtx
make all install

