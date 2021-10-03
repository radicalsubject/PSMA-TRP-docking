#!/bin/bash -i

read -p "set password: " password 
hashcode=$(python ./work/maintenance/psswdgen.py $password)
jupyter-notebook --port=8889 --NotebookApp.password=$hashcode --allow-root