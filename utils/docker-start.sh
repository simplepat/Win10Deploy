#!/bin/bash
PROJECT_PATH=${PWD}
PROJECT_NAME=${PWD##*/}

sharedfolder_exists=`vboxmanage showvminfo default | grep "Name: '${PROJECT_NAME}'"`
if [[ -z $sharedfolder_exists ]]
then
    vboxmanage sharedfolder add default --name ${PROJECT_NAME} --hostpath ${PROJECT_PATH} --transient
    docker-machine ssh default "sudo mkdir -p ${PROJECT_PATH}"
    docker-machine ssh default "sudo mount -t vboxsf -o defaults,uid=`id -u`,gid=`id -g` ${PROJECT_NAME} ${PROJECT_PATH}"
else
    echo "INFO : Shared folder already set"
fi

docker run -p 80:80 -v /my-project/src:/usr/src/app mycontainer