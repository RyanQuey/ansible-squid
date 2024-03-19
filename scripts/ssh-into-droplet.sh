#!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export $(cat $SCRIPT_DIR/.env)

# e.g.  147.182.225.164
#  Just whatever public ip DO puts out there for you. 
HOST_IP=$1

ssh root@$1 -i $SSH_PRIVATE_KEY_PATH
