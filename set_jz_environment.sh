module load openmpi/4.1.0-cuda
#module load nvidia-compilers/21.7
module load cmake

export BASEDIR=${HOME}/accord/ectrans_jz
export SOURCEDIR=${BASEDIR}/sources
export BUILDDIR=${BASEDIR}/build
export INSTALLDIR=${BASEDIR}/install
mkdir -p ${BASEDIR} ${SOURCEDIR} ${BUILDDIR} ${INSTALLDIR}
export CC=mpicc
export CXX=mpic++
export FC=mpifort
export PATH=${PATH}:${INSTALLDIR}/ecbuild/bin/

export DR_HOOK_ASSERT_MPI_INITIALIZED=0

cd ${BASEDIR}


