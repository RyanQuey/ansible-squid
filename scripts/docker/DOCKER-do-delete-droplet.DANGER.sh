#!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export $(cat $SCRIPT_DIR/.env)


doctl compute droplet delete \
    ubuntu-s-1vcpu-1gb-sfo3-01

# 0.5gb RAM ($4/mo) setup:
    #ubuntu-s-1vcpu-512mb-10gb-sfo3-01

watch doctl compute droplet list
