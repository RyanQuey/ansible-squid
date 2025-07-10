#!/bin/bash +x
#  #!/bin/bash -x

DOCKER_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DIR=$DOCKER_SCRIPT_DIR/..
PROJECT_DIR=$SCRIPT_DIR/..

doctl=$DOCKER_SCRIPT_DIR/_DOCKER-doctl.sh

# -r output strings as raw, no double quotes
#    * https://stackoverflow.com/a/44656583


set_host_ini () {
  hosts_content="[all]\n$droplet_public_ip\n"

  echo -e $hosts_content > $PROJECT_DIR/hosts.ini
}

droplet_public_ip=$($DOCKER_SCRIPT_DIR/DOCKER-do-QUERY-get-droplet-public_ip.sh)
if [[ $droplet_public_ip =~ [0-9.] ]]; then
  echo "Found public ip: $droplet_public_ip"
  echo "setting to '$PROJECT_DIR/hosts.ini':"
  set_host_ini
else
  echo "no public ip yet. It just says:"
  echo "$droplet_public_ip"
fi
