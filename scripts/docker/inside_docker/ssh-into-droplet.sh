#!/bin/bash +x
#  #!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$SCRIPT_DIR/../../..

# NOTE only for running from within docker container
#
#
# > ./scripts/docker/_DOCKER-ansible.sh bash
#
#  (now within docker
# > ./scripts/docker/inside_docker/ssh-into-droplet.sh 
#
# loads env vars
export $(cat $SCRIPT_DIR/../.env)
#doctl=$SCRIPT_DIR/_DOCKER-doctl.sh

# e.g.  147.182.225.164
#  Just whatever public ip DO puts out there for you. 

# alternatively, just use ssh:
# > HOST_IP=$1
# > ssh root@$1 -i $SSH_PRIVATE_KEY_PATH
#
# Later can try this: 
# https://hub.docker.com/r/digitalocean/doctl#doctl-compute-ssh
# TODO programmatically add DROPLET-ID
#  $doctl \
#  compute ssh <DROPLET-ID>
#  But right now I'm already getting the ip address for ansible, so just use that.


# e.g.  147.182.225.164
#  Just whatever public ip DO puts out there for you. 
# HOST_IP=$1
HOST_IP=$(sed '2q;d' $PROJECT_DIR/hosts.ini)

# alternatively, just use doctl ssh: (doesn't require knowing the ip, for extra convenience)
# https://hub.docker.com/r/digitalocean/doctl#doctl-compute-ssh
# See my docker version of this for example

# relative paths are to WORK_DIR in docker
ssh root@$HOST_IP -i $SCRIPT_DIR/../tmp/id_rsa 
