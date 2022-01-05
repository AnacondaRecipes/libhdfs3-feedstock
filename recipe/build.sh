#!/bin/bash -e

mkdir build
cd build

CMAKE_RECIPE_ARGS=""

case ${target_platform} in
  linux-ppc64le)
    CMAKE_RECIPE_ARGS="
      -DENABLE_BOOST=ON
      -DENABLE_COVERAGE=OFF
      -DENABLE_LIBCPP=OFF
      -DENABLE_SSE=OFF
    "
    ;;
  linux-aarch64)
    CMAKE_RECIPE_ARGS="
      -DENABLE_SSE=OFF
    "
    ;;
esac

if [ -n "${CMAKE_RECIPE_ARGS}" ]; then
  cmake \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_PREFIX_PATH="${PREFIX}" \
    ${CMAKE_ARGS} \
    ${CMAKE_RECIPE_ARGS} \
    ../libhdfs3
else
  ../libhdfs3/bootstrap --prefix="${PREFIX}" --dependency="${PREFIX}"
fi

make -j${CPU_COUNT} ${VERBOSE_CM}
make install

rm "${PREFIX}/lib/libhdfs3.a"  # don't need static
