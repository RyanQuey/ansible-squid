#!/bin/bash -x

DOCKER_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DIR=$DOCKER_SCRIPT_DIR/..
PROJECT_DIR=$SCRIPT_DIR/..

# set env vars
export $(cat $SCRIPT_DIR/.env)

cd $PROJECT_DIR && \

$DOCKER_SCRIPT_DIR/_DOCKER-ansible-playbook.sh \
 $PROJECT_DIR/playbook.yml \
-i ./hosts.ini \
--private-key $SSH_PRIVATE_KEY_PATH \
-e "ansible_ssh_user=root"
