#!/bin/bash +x
#  #!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# loads env vars
export $(cat $SCRIPT_DIR/../.env)
doctl=$SCRIPT_DIR/_DOCKER-doctl.sh

# e.g.  147.182.225.164
#  Just whatever public ip DO puts out there for you. 

# alternatively, just use ssh:
# > HOST_IP=$1
# > ssh root@$1 -i $SSH_PRIVATE_KEY_PATH
#
# for now trying this: 
# https://hub.docker.com/r/digitalocean/doctl#doctl-compute-ssh
# TODO programmatically add DROPLET-ID
  $doctl \
  compute ssh <DROPLET-ID>
