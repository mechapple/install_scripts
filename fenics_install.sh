#!/bin/bash

module load gcc/8.2.0
export CC=`which gcc`
export CXX=`which g++`

module load spack/python/3.8.6
module load spack/py-pip/20.2
module load spack/py-setuptools/50.3.2
module load spack/git/2.29.0
module load spack/cmake/3.18.4
module load spack/boost/1.62.0
module load spack/cgal/5.0.3
module load spack/eigen/3.3.8
module load spack/gmp/6.1.2
module load spack/metis/5.1.0
module load spack/mpfr/4.0.2
module load spack/openblas/0.3.12
module load spack/openmpi/3.1.6
module load spack/parmetis/4.0.2
module load spack/petsc/3.7.7
module load spack/slepc/3.7.4

FENICS_INSTALL_DIR=/home/apal/software/FENICS
pip3 install --prefix=$FENICS_INSTALL_DIR fenics-ffc --upgrade
#pip3 install --prefix=$FENICS_INSTALL_DIR matplotlib --upgrade
export PYTHONPATH=$PYTHONPATH:$FENICS_INSTALL_DIR/lib/python3.8/site-packages/
export PATH=$PATH:$FENICS_INSTALL_DIR/bin/
FENICS_VERSION=$(python3 -c"import ffc; print(ffc.__version__)")
echo $FENICS_VERSION

PYBIND11_VERSION=2.2.3
wget -nc --quiet https://github.com/pybind/pybind11/archive/v${PYBIND11_VERSION}.tar.gz
tar -xf v${PYBIND11_VERSION}.tar.gz && cd pybind11-${PYBIND11_VERSION}
mkdir -p build && cd build && cmake -DCMAKE_INSTALL_PREFIX=$FENICS_INSTALL_DIR -DPYBIND11_TEST=off .. 
make install && cd ../..

git clone --branch=$FENICS_VERSION https://bitbucket.org/fenics-project/dolfin
mkdir -p dolfin/build && cd dolfin/build
cmake -DCMAKE_INSTALL_PREFIX=$FENICS_INSTALL_DIR ..
make install
source dolfin.conf
cd ../python && pip3 install --prefix=$FENICS_INSTALL_DIR .
cd ../..
#cp -r ~/.local/* $FENICS_INSTALL_DIR/.
#rm -rf ~/.local

module load spack/py-matplotlib/3.3.3
module load spack/py-pyparsing/2.4.2
module load spack/py-cycler/0.10.0
module load spack/py-six/1.14.0
module load spack/py-python-dateutil/2.8.0
module load spack/py-kiwisolver/1.1.0
module load spack/py-pillow/7.2.0

#export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/home/apal/.local/lib64/pkgconfig


