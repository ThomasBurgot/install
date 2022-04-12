#!/bin/bash

if [[ -z ${BASEDIR} ]]; then
        echo -e "run\n\n\tsource set_volta_environment\n\nfirst!"
        exit 1
fi

# add dynamic libraries to path
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${INSTALLDIR}/fiat/lib/

# setup/clean workdir
WORKDIR=${BASEDIR}/work
mkdir -p ${WORKDIR}
rm -rf ${WORKDIR}/run*

for program in driver-spectraltransform dwarf_bifft; do
#for program in dwarf_bifft; do
        for precision in sp dp; do

                mkdir -p ${WORKDIR}/run_${program}_${precision}
                cd ${WORKDIR}/run_${program}_${precision}

                # bring executable
                ln -sf ${INSTALLDIR}/test-programs/bin/${program}_${precision}

                # create namelist file
                if [[ ${program} == "driver-spectraltransform" ]]; then
                        echo -e "&NAMTRANS\nITERS=10\n/\n" > fort.4
                        cp ${BASEDIR}/rtablel_2159 .
                elif [[ ${program} == "dwarf_bifft" ]]; then
                        echo -e "&NAMTRANS\nNITERS=1\n/\n&NAMBIFFT\nNLON=576,NLAT=432,NFLD=10,NPROMA=24\n/\n&NAMCT0\n/\n" > fort.4
                else
                        echo "unknown test program ${program}"
                        continue
                fi

                # run!
                #mpirun -np 1 ./driver-spectraltransform_${precision} > log.out 2>log.err
                #mpirun -np 1 nsys profile -t openacc,cuda -f true -o report_nsys ./${program}_${precision} > log.out 2>log.err
                mpirun -np 1 ./${program}_${precision} > log.out 2>log.err
                ret=$?
                echo "${program}_${precision} returned error code $ret"

        done

done

