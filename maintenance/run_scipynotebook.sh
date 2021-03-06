#!/bin/bash -i

grepresponse=$(docker ps -a | grep notebook | grep -oE '[^ ]+$')
# echo $grepresponse
# string comparisons made by = and integer by -eq !!!
source ~/.bashrc
if [ "$grepresponse" = "notebook" ]
then
    docker start notebook
    echo "notebook started from previously existed cotainer"
else
    echo "im going to to create new container"
    if [ $# -eq 0 ] 
    then
        read -p "set password: " password
        hashcode=$(python ./maintenance/psswdgen.py $password)
        # echo $password
        # echo $hashcode
        echo "launching docker run"
        docker run -d -p 40001:8888 -p 40002:8889 --name notebook -e NB_USER=asya -w /home/asya -e CHOWN_HOME=yes -v "${PWD}":/home/asya/work -e GRANT_SUDO=yes --user root jupyter/scipy-notebook jupyter-notebook --NotebookApp.password=$hashcode --allow-root &> /dev/null
        # use --rm switch i.e., container gets destroyed automatically as soon as it is stopped
        # need to sleep until previous command is executed and container is booted
        sleep 10
        echo "creating vina env"
        docker exec -ti notebook sh -c "bash /home/asya/work/maintenance/env_preparations.sh"

    else
        docker run -d -p 40001:8888 -p 40002:8889 --rm --name notebook -e NB_USER=asya -w /home/asya -e CHOWN_HOME=yes -v "${PWD}":/home/asya/work -e GRANT_SUDO=yes --user root jupyter/scipy-notebook jupyter-notebook --NotebookApp.password=$1 --allow-root &> /dev/null
        # use --rm switch i.e., container gets destroyed automdcally as soon as it is stopped
                # need to sleep until previous command is executed and container is booted
        sleep 10
        docker exec -ti notebook sh -c "bash /home/asya/work/maintenance/env_preparations.sh"
    fi
fi