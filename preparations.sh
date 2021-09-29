#!/bin/bash -i
source ~/.bashrc &&  conda env create -f env.yml || conda env update -f env.yml && conda activate vina
