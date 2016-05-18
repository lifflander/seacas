#! /usr/bin/env sh

### Change this to point to the compilers you want to use
if [ "$MPI" == "ON" ]
then
  COMPILER = "-DCMAKE_CXX_COMPILER:FILEPATH=mpicxx -DCMAKE_C_COMPILER:FILEPATH=mpicc -DCMAKE_Fortran_COMPILER:FILEPATH=mpif77"
else
fi

cmake \
  ${COMPILER} -DBUILD_SHARED_LIBS:BOOL=ON \
  -DTPL_ENABLE_MPI=${MPI} \
  -DCMAKE_CXX_FLAGS="-Wall -pedantic" \
  -DCMAKE_C_FLAGS="-Wall -pedantic" \
  -DHDF5_ROOT:PATH=/usr/ \
  -DSEACASProj_ENABLE_ALL_PACKAGES:BOOL=ON \
  -DSEACASProj_ENABLE_SECONDARY_TESTED_CODE:BOOL=ON \
  -DSEACASProj_ENABLE_TESTS:BOOL=ON \
  -DSEACASProj_USE_GNUINSTALLDIRS:BOOL=ON \
  -DTPL_ENABLE_CGNS:BOOL=ON \
  -DTPL_ENABLE_Matio:BOOL=ON \
  -DTPL_ENABLE_METIS:BOOL=OFF \
  -DTPL_ENABLE_ParMETIS:BOOL=OFF \
  -DTPL_ENABLE_Netcdf:BOOL=ON \
  -DTPL_ENABLE_MPI:BOOL=OFF \
  -DTPL_ENABLE_Pamgen:BOOL=OFF \
  -DTPL_ENABLE_X11:BOOL=ON \
  -DTPL_ENABLE_Zlib:BOOL=ON \
  ../
