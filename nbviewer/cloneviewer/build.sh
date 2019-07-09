#!/bin/bash

# Make Docker build context the repository root
export repositoryRoot=../..
cd $repositoryRoot

# If it wasn't executable before... it is now
chmod +x useful_functions.sh

# Check to see whether base image already exists; if it doesn't, then build it
./useful_functions.sh if_not_base_image_then_build_it

docker build                                \
    --file=nbviewer/Dockerfile              \
    --no-cache                              \
    --force-rm                              \
    --build-arg branch=latest               \
    --build-arg repository=krinsman         \
    --tag nbviewer_base                     \
    .

docker build                                \
    --file=nbviewer/cloneviewer/Dockerfile  \
    --force-rm                              \
    --no-cache                              \
    --tag jupyter:cloneviewer                \
    .

# Delete all intermediate images with label autodelete=true
./useful_functions.sh destroy_intermediates
