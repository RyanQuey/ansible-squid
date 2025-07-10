#!/bin/bash +x
#  #!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# tips:
# - can play around in bash by doing _DOCKER-ansible.sh bash
docker run --rm --interactive --tty \
  --volume .:/home/ansible/ \
  ansible "$@" 
