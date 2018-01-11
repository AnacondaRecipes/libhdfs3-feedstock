#!/usr/bin/env bash

mkdir build
cd build
../libhdfs3/bootstrap --prefix=$PREFIX --dependency=$PREFIX
make -j${CPU_COUNT}
make install
rm $PREFIX/lib/libhdfs3.a  # don't need static
