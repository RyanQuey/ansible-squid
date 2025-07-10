#!/bin/bash +x
#  #!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export $(cat $SCRIPT_DIR/../.env)
doctl=$SCRIPT_DIR/_DOCKER-doctl.sh


# using Ubuntu 20 - much easier to find guides for setting up squid, though probably 22 would work just as well. 
# using sfo3 - sfo1 and sfo2 had rules about creating new droplets in them, and west coast seems to have faster ping times than east coast from Cambodia. 

# NOTE: Can generate this doctl command from the GUI

# Mar 2024 update: didn't get it working, some sort of auth issue. Might be because of old CLI client. So just used the DO dashboard and it worked great. 
#
# NOTE I think it's not necessary for docker...since it only updates stuff in the container anyways

$doctl auth init

$doctl auth list
