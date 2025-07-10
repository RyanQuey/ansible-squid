#!/bin/bash +x
#  #!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
doctl=$SCRIPT_DIR/_DOCKER-doctl.sh

$doctl compute droplet list --output json
