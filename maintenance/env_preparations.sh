#!/bin/bash -i
source /home/ofedorov/anaconda3/etc/profile.d/conda.sh && \
    conda activate && \
    conda env create -f env.yml || \
    conda env update -f env.yml && \
    conda activate vina 