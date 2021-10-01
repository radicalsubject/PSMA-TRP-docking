#!/bin/bash -i
source conda activate && \
    conda env create -f ./work/env.yml || \
    conda env update -f ./work/env.yml && \
    conda activate vina 