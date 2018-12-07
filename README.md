# SEACAS  [[Documentation](http://gsjaardema.github.io/seacas/)]
[![Build Status](https://travis-ci.org/gsjaardema/seacas.svg?branch=master)](https://travis-ci.org/gsjaardema/seacas)
[![Analysis Status](https://scan.coverity.com/projects/2205/badge.svg?flat=1)](https://scan.coverity.com/projects/gsjaardema-seacas)

* [Get the sources](#get-the-sources)
* [Build instructions](#build-instructions)
* [Configure, Build, and Install SEACAS](#configure-build-and-install-seacas)
* [Testing](#testing)
* [Exodus](#exodus)
* [Trilinos](#trilinos)
* [SPACK](#spack)
* [License](#license)
* [Ubuntu](#ubuntu)
* [Contact information](#contact-information)
* For information on building with MPI, see [README-PARALLEL.md](README-PARALLEL.md)
* NOTE: The old imake-based build has been removed.

## Get the sources
```
git clone https://github.com/gsjaardema/seacas.git
```
This will create a directory that will be referred to as _seacas_ in
the instructions that follow. You can rename this directory to any
other name you desire. Set an environment variable pointing to this
location by doing:
```
cd seacas && export ACCESS=`pwd`
```

## Build instructions

### Automatically download and build dependencies (Third-Party Libraries)

There are a few externally developed third-party libraries (TPL) that
are required to build SEACAS. You can build the libraries manually as
detailed in the following section, or you can use the `install-tpl.sh` script which will
download and install the HDF5, NetCDF, CGNS, MatIO, and (if MPI set)
PnetCDF libraries.

* To use the script, simply type `./install-tpl.sh`
* The default behavior can be modified via a few environment variables:
 
| Variable | Values | Default | Description |
|----------|:------:|:-------:|-------------|
| COMPILER | clang, gnu, intel, ibm | gnu | What compiler should be used for non-parallel build |
| JOBS     | {count}|  2      | Number of "jobs" used for simultaneous compiles |
| FORCE    | YES, NO | NO  | Force downloading and building even if lib is already installed. |
| DOWNLOAD | YES, NO | YES |  Should TPLs be downloaded. |
| BUILD    | YES, NO | YES | Should TPLs be built and installed. |
| SHARED   | YES, NO | YES | Build shared libraries is YES, archive (.a) if NO |
| MPI      | ON, OFF | OFF | If ON, then build parallel capability |
| CRAY     | YES, NO | NO | Is this a Cray system (special parallel options) |
| NEEDS_ZLIB| YES, NO| NO  | If system does not have zlib installed, download and install it. |
| CGNS     | YES, NO | YES | Should CGNS TPL be built.  |
| MATIO    | YES, NO | YES | Should matio TPL be built. |
| GNU_PARALLEL | YES, NO | YES | Should GNU parallel script be built. |
| H5VERSION | V110, V18 | V110 | Use HDF5-1.10.X or HDF5-1.8.X |
| JOBS     | # | 2 | Used in `make -j #` |
| SUDO     | "" or sudo | "" | If need to be superuser to install |
* NOTE: The `DOWNLOAD` and `BUILD` options can be used to download all TPL source; move to a system with no outside internet access and then build/install the TPLs.
* The arguments can either be set in the environment as: `export COMPILER=gnu`, or passed on the script invocation line: `COMPILER=gnu ./install-tpl.sh`
 
### Manually download and build dependencies (Third-Party Libraries)

See [TPL-Manual-Install.md](TPL-Manual-Install.md) for instructions on
how to manually download and install the third-party libraries for
SEACAS. Using the `install-tpl.sh` script described above is
preferred.

## Configure, Build, and Install SEACAS
At this time, you should have all external TPL libraries built and
installed into `${ACCESS}/lib` and `${ACCESS}/include`. You are now ready
to configure the SEACAS CMake build.

   * `cd $ACCESS`
   * `mkdir build`
   * `cd build`
   * edit the `${ACCESS}cmake-config` file and adjust compilers and
     other settings as needed. 
   * enter the command `../cmake-config` and cmake should configure everything for the build.
   * `make && make install`
   * If everything works, your applications should be in `${ACCESS}/bin`

## Testing
There are a few unit tests for zoltan, exodus, and aprepro that can be run via `make test` if you configured with `-D SEACASProj_ENABLE_TESTS=ON`.

There is also a system-level test that just verifies that the applications can read and write exodus files correctly.  This test runs off of the installed applications.  To run do:

 * `make install`
 * `cd ../SEACAS-Test`
 * `make clean; make`

This will run through several of the SEACAS applications creating a mesh (exodus file) and then performing various manipulations on the mesh.  If the test runs successfully, there is some hope that everything has built and is running correctly. 

## Exodus
If you only want the exodus library, then follow most of the above instructions with the following exceptions:

  * You can either clone entire source tree as above, or you can
	download a zip file containing only the exodus source (and
	build-related files).  The url for the zip file is
	<https://github.com/gsjaardema/seacas/archive/exodus.zip> NOTE: Probably out-of-date and better to just clone entire repository. 
  * You only need the netcdf and optionally hdf5 libraries
  * Use the `cmake-exodus` file instead of `cmake-config`.
  * This will build, by default, a shared exodus library and also install the exodus.py Python interface.

## Trilinos

Although SEACAS is included in Trilinos
(https://github.com/trilinos/Trilinos), it is also possible to use the
SEACAS code from this repository to override the possibly older SEACAS
code in Trilinos.  The steps are to directly pull SEACAS from github
under Trilinos and then build SEACAS under Trilinos with that version
using `SEACAS_SOURCE_DIR_OVERRIDE`.  Here is how you do it:
 
```
cd Trilinos/
git clone https://github.com/gsjaardema/seacas.git
cd BUILD/
cmake -DSEACAS_SOURCE_DIR_OVERRIDE:STRING=seacas/packages/seacas -DTrilinos_ENABLE_SEACAS [other options] ..
```

## SPACK

The SPACK package manager (https://spack.io/) can be used to install
SEACAS and all depedent third-party libaries.  There is currently a
pull-request to add SEACAS to the distributed packages, but until that
is applied, you can clone spack and apply two patches:

```
git clone https://github.com/spack/spack.git
cd spack
wget https://github.com/gsjaardema/seacas/raw/master/SPACK-Define-seacas-package.patch
wget https://github.com/gsjaardema/seacas/raw/master/SPACK-CGNS.patch
git apply SPACK-Define-seacas-package.patch
git apply SPACK-CGNS.patch
cd ..
. spack/share/spack/setup-env.sh
spack install seacas~mpi   # Serial build (most common)
```

Enter `spack info seacas` to see information on supported variants and other information about the SEACAS package.
## License

SEACAS is licensed under the Modified BSD License.  See the LICENSE  file for details.

The following externally-developed software routines are used in some of the SEACAS applications and are under 
a separate license:

| Routine | Where Used  | License |
|---------|-------------|:-------:|
| getline | `packages/seacas/libraries/aprepro_lib/apr_getline_int.c`  | [MIT](https://opensource.org/licenses/MIT) |
| getline | `packages/seacas/libraries/suplib_c/getline.c`             | [BSD](https://opensource.org/licenses/BSD-3-Clause) |
| [GetLongOpt](https://searchcode.com/codesearch/view/64130032/) | `packages/seacas/libraries/suplib_cpp/GetLongOpt.C` | public domain |
| [adler hash](https://en.wikipedia.org/wiki/Adler-32)	| `packages/seacas/libraries/suplib_c/adler.c` | [zlib](https://opensource.org/licenses/zlib) |
| [MurmurHash](https://github.com/aappleby/smhasher) | `packages/seacas/libraries/ioss/src/Ioss_FaceGenerator.C` | public domain |
| [json include file](http://jsoncpp.sourceforge.net) | `packages/seacas/libraries/ioss/src/visualization/` | [MIT](https://opensource.org/licenses/MIT) |
| [terminal_color](https://github.com/matovitch/trmclr) | `packages/seacas/libraries/suplib_cpp` | [zlib](https://opensource.org/licenses/zlib) |

## Ubuntu
There is a [PPA](https://launchpad.net/~nschloe/+archive/ubuntu/seacas-nightly/) available for SEACAS that is updated nightly from SEACAS `master`. Anyone using Ubuntu can now just add the PPA and do
```
sudo add-apt-repository ppa:nschloe/seacas-nightly
sudo apt-get update
```
and then
```
sudo apt-get install seacas-bin
```
to get the SEACAS binaries. You can also install 'libseacas-dev' or 'libseacas0'. This is provided by Nico Schlömer.

## Contact information

 Greg Sjaardema  (<gsjaardema@gmail.com>, <gdsjaar@sandia.gov>)
      
