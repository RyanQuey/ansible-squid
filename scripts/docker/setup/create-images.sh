#!/bin/bash +x
#  #!/bin/bash -x

DOCKER_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/..
SCRIPT_DIR=$DOCKER_SCRIPT_DIR/..
PROJECT_DIR=$SCRIPT_DIR/..

cd $PROJECT_DIR

test_doctl () {
  docker image inspect doctl && return 0
}
test_doctl


if [ $? -ne 0 ]; then
  # Latest doctl as of July 2025. Alternatively, can do e.g., digitalocean/doctl:1-latest if I want something newer and don't want to be so specific
  echo "=== doctl image needs to be build. Building now...==="
  DO_TAG=1.132.0
  docker pull digitalocean/doctl:$DO_TAG
  docker image tag digitalocean/doctl:$DO_TAG doctl
else
  echo "doctl image already exists, skipping"
fi

test_ansible () {
  docker image inspect ansible && return 0
}
test_ansible
if [ $? -ne 0 ]; then
  echo "=== ansible image needs to be build. Building now...==="
  docker build . -f Dockerfile.ansible -t ansible
else
  echo "ansible image already exists, skipping"
fi
