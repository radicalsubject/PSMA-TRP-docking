#!/bin/bash -i
read -p "set password: " password 
hashcode=$(python ./work/maintenance/psswdgen.py $password)
jupyter-notebook -p 40002:8889 --NotebookApp.password=$hashcode --allow-root