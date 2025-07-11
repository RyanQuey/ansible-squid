#!/bin/bash +x
#  #!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export $(cat $SCRIPT_DIR/../.env)

$SCRIPT_DIR/DOCKER-do-create-droplet.sh && \
  $SCRIPT_DIR/DOCKER-do-set-droplet-public_ip.sh && \
  $SCRIPT_DIR/DOCKER-run-playbook.sh && \
  $SCRIPT_DIR/../test-squid-proxy.WATCH.sh
