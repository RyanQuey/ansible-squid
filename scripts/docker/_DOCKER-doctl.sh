#!/bin/bash +x
#  #!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export $(cat $SCRIPT_DIR/../.env)

copy_key () {
  #echo "=== about to copy ssh key for temporary use" && \
  #echo "$SSH_PRIVATE_KEY_PATH" $SCRIPT_DIR/tmp/id_rsa && \
  cp "$SSH_PRIVATE_KEY_PATH" $SCRIPT_DIR/tmp/id_rsa 
  #echo "=== copied."
}
remove_tmp_key () {
  #echo "removing tmp rsa_key for ssh..." && \
  rm $SCRIPT_DIR/tmp/id_rsa 
  #echo "done."
}

copy_key && \
docker run --rm --interactive --tty \
  --env=DIGITALOCEAN_ACCESS_TOKEN=$DO_API_KEY \
  -v $SCRIPT_DIR/tmp/id_rsa:/root/.ssh/id_rsa \
  doctl "$@" && \
remove_tmp_key

