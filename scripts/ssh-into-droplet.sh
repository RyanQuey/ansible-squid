#!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$SCRIPT_DIR/..
export $(cat $SCRIPT_DIR/.env)

# e.g.  147.182.225.164
#  Just whatever public ip DO puts out there for you. 
# HOST_IP=$1
HOST_IP=$(sed '2q;d' $PROJECT_DIR/hosts.ini)

# alternatively, just use doctl ssh: (doesn't require knowing the ip, for extra convenience)
# https://hub.docker.com/r/digitalocean/doctl#doctl-compute-ssh
# See my docker version of this for example

ssh root@$HOST_IP -i $SSH_PRIVATE_KEY_PATH

