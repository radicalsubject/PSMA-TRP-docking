#!/bin/bash -i
conda env create -f ./work/env.yml || \
    conda env update -f ./work/env.yml

