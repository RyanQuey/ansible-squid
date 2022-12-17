#!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export $(cat $SCRIPT_DIR/.env)

ansible-playbook ./playbook.yml \
-i hosts.ini \
--private-key $SSH_PRIVATE_KEY_PATH \
-e "ansible_ssh_user=root"
