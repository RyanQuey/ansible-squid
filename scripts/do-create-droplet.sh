#!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export $(cat $SCRIPT_DIR/.env)


# using Ubuntu 20 - much easier to find guides for setting up squid, though probably 22 would work just as well. 
# using sfo3 - sfo1 and sfo2 had rules about creating new droplets in them, and west coast seems to have faster ping times than east coast from Cambodia. 

# NOTE: Can generate this doctl command from the GUI

# 1gb RAM ($6/mo) setup:
doctl compute droplet create \
    --image ubuntu-20-04-x64 \
    --size s-1vcpu-1gb \
    --region sfo3 \
    --enable-monitoring \
    --tag-names 'squid-proxy' \
    --ssh-keys $DO_FINGERPRINT \
    ubuntu-s-1vcpu-1gb-sfo3-01

# 0.5gb RAM ($4/mo) setup:
    #ubuntu-s-1vcpu-512mb-10gb-sfo3-01

doctl compute droplet list
