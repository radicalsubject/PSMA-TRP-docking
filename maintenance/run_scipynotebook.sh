#!/bin/bash -i

if [ $# -eq 0 ] 
then
    read -p "set password: " password
    hashcode=$(python ./maintenance/psswdgen.py $password)
    echo $password
    echo $hashcode
    docker run -p 40001:8888 --rm --name notebook -e NB_USER=asya -w /home/asya -e CHOWN_HOME=yes -v "${PWD}":/home/asya/work -e GRANT_SUDO=yes --user root jupyter/scipy-notebook jupyter-notebook --NotebookApp.password=$hashcode --allow-root
    # use --rm switch i.e., container gets destroyed automatically as soon as it is stopped
    docker exec -d notebook sh -c "bash /home/asya/work/maintenance/env_preparations.sh"

else
    docker run -p 40001:8888 --rm --name notebook -e NB_USER=asya -w /home/asya -e CHOWN_HOME=yes -v "${PWD}":/home/asya/work -e GRANT_SUDO=yes --user root jupyter/scipy-notebook jupyter-notebook --NotebookApp.password=$1 --allow-root
    # use --rm switch i.e., container gets destroyed automatically as soon as it is stopped
    docker exec -d notebook sh -c "bash /home/asya/work/maintenance/env_preparations.sh"
fi