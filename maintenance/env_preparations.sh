#!/bin/bash -i
source conda activate && \
    conda env create -f ./work/env.yml || \
    conda env update -f ./work/env.yml && \
    conda activate vina
    read -p "set password: " password 
    hashcode=$(python ./maintenance/psswdgen.py $password)
    jupyter-notebook --NotebookApp.password=$hashcode --allow-root