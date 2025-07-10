#!/bin/bash -x

DOCKER_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DIR=$DOCKER_SCRIPT_DIR/..
PROJECT_DIR=$SCRIPT_DIR/..

# set env vars
export $(cat $SCRIPT_DIR/.env)

cd $PROJECT_DIR && \

  # Path to playbook.yml (and all paths) are relative to the docker WORKDIR, which should be fine
$DOCKER_SCRIPT_DIR/_DOCKER-ansible-playbook.sh \
 ./playbook.yml \
-i ./hosts.ini \
--private-key  ./scripts/docker/tmp/id_rsa \
-e "ansible_ssh_user=root"
