#!/bin/sh
CURRENT_DIR=$(pwd)
cd $CURRENT_DIR

if [ -d "build/" ];then
  echo "-rm build dir..."
  rm -rf build
  mkdir build
  cd build
  cmake ..
  make -j4
else
  echo "-create build dir..."
  mkdir build
  cd build
  cmake ..
  make -j4
fi
