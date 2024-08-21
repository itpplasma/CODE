#!/bin/bash

echo "Setting up GVEC..."

GIT_LFS_SKIP_SMUDGE=1 git clone --depth 1 --filter=blob:none -b feature_pygvec_f90wrap \
    git@gitlab.tugraz.at:plasma/codes/gvec.git

pushd gvec
cmake --preset gvec_config_release -B build
cmake --build build -j$(nproc)
popd
