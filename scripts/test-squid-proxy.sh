#!/bin/bash +x
    #!/bin/bash -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$SCRIPT_DIR/..
export $(cat $SCRIPT_DIR/.env)

# e.g.  147.182.225.164
#  Just whatever public ip DO puts out there for you. 
# HOST_IP=$1
HOST_IP=$(sed '2q;d' $PROJECT_DIR/hosts.ini)
# get from line 3, then get everything after the space.
SQUID_PASSWORD=$(sed '3q;d' $PROJECT_DIR/roles//ansible-squid/vars/main.yml  | sed 's/.* //')

# alternatively, just use doctl ssh: (doesn't require knowing the ip, for extra convenience)
# https://hub.docker.com/r/digitalocean/doctl#doctl-compute-ssh
# See my docker version of this for example

target_url="http://www.google.com/"
result=$(curl -v -x http://ryan:$SQUID_PASSWORD@$HOST_IP:3128 $target_url 2>&1)

FAILURE_MSG="Failed to connect"
FAILURE_AUTH_MSG="Sorry, you are not currently allowed to request $target_url from this cache until you have authenticated yourself"

check () {
    if [[ $result == *"$FAILURE_MSG"* ]]; then
        echo "failed to connect, try again..."
        return 1
    elif [[ $result == *"$FAILURE_AUTH_MSG"* ]]; then
        echo "Failed basic auth, try another password (or need to readjust squid basic auth settings...)"
        return 1
    else
        echo "proxy is working great"
        return 0
    fi
}
check
