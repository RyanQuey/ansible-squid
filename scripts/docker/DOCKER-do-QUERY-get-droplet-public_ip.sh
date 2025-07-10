#!/bin/bash +x
#  #!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
doctl=$SCRIPT_DIR/_DOCKER-doctl.sh

# -r output strings as raw, no double quotes
#    * https://stackoverflow.com/a/44656583


$SCRIPT_DIR/DOCKER-do-list-droplets.JSON.sh \
  | jq .[0].networks.v4 \
  | jq -r '.[] | select(.type == "public").ip_address'
