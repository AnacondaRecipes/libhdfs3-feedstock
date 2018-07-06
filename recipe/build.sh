#!/usr/bin/env bash

mkdir build
cd build
if [[ ${target_platform} == linux-ppc64le ]]; then
  cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} \
        -DCMAKE_PREFIX_PATH=${PREFIX} \
        -DENABLE_BOOST=ON \
        -DENABLE_COVERAGE=OFF \
        -DENABLE_LIBCPP=OFF \
        -DENABLE_SSE=OFF \
        ../libhdfs3
else
  ../libhdfs3/bootstrap --prefix=$PREFIX --dependency=$PREFIX
fi
make -j${CPU_COUNT} ${VERBOSE_CM}
make install
rm $PREFIX/lib/libhdfs3.a  # don't need static
