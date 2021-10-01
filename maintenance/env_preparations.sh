#!/bin/bash -i
source conda activate && \
    conda env create -f ./env.yml || \
    conda env update -f ./env.yml && \
    conda activate vina 