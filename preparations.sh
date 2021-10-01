#!/bin/bash -i
source ~/.bashrc && \
    conda activate && \
    conda env create -f env.yml || \
    conda env update -f env.yml && \
    conda activate vina && \
    docker run -p 40001:8888 -e NB_USER=asya -w /home/asya -e CHOWN_HOME=yes -v "${PWD}":/home/asya/work -e GRANT_SUDO=yes --user root jupyter/scipy-notebook jupyter-notebook --NotebookApp.password='sha1:1f44b533bdd1:34e68851b0bb05a774ed26b60f839a045f3ab022' --allow-root