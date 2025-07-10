#!/bin/bash +x
#  #!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# specify command as `ansible-playbook` then pass in whatever after that
$SCRIPT_DIR/_DOCKER-ansible.sh ansible-playbook "$@" 
