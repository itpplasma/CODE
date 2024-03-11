#!/bin/bash

echo "Fetching and building HDF5..."
curl -L https://github.com/HDFGroup/hdf5/releases/download/hdf5-1_14_3/hdf5-1_14_3.tar.gz -o - | tar xzv
cd hdfsrc
./configure --enable-fortran --enable-hl --prefix="$(pwd)/build"
make -j$(nproc)
make install
cd ..

echo "Fetching and building NetCDF..."
curl -L https://github.com/Unidata/netcdf-c/archive/refs/tags/v4.9.2.tar.gz -o - | tar xzv
cd netcdf-c-4.9.2
CPPFLAGS="-I$(pwd)/../hdfsrc/build/include" LDFLAGS="-L$(pwd)/../hdfsrc/build/lib" ./configure --prefix="$(pwd)/build"
make -j$(nproc)
make install
cd ..

curl -L https://github.com/Unidata/netcdf-fortran/archive/refs/tags/v4.6.1.tar.gz -o - | tar xzv
cd netcdf-fortran-4.6.1
CPPFLAGS="-I$(pwd)/../hdfsrc/build/include -I$(pwd)/../netcdf-c-4.9.2/build/include" LDFLAGS="-L$(pwd)/../hdfsrc/build/lib -L$(pwd)/../netcdf-c-4.9.2/build/lib" ./configure --prefix=$(pwd)/build
make -j$(nproc)
make install
cd ..