# ansible-squid

Ansible role to install/configure Squid Proxy


## Quick start guide

TODO test again, now with the basic auth settings changed. Last time I ran I did some manual command
- I did save the working squid.conf file here though: `./squid.working-example.conf`

### 0) prereqs

- doctl installed
- Ansible playbook installed
- htpassword module (https://docs.ansible.com/ansible/latest/collections/community/general/htpasswd_module.html): 
    ```
    ansible-galaxy collection install community.general
    ```

- There are also others listed in ./roles/ansible-squid/requirements.in 
- Make sure to set squid password in: `roles/ansible-squid/vars/main.yml` (make a copy from `roles/ansible-squid/vars/main.yml.example`)

### 1) Spin up droplet
```
./scripts/do-create-droplet.sh
```

### 2) Get public ip of droplet
```
doctl compute droplet list
```
If no public ip is shown, you might have to wait a few moments first for the ip to be assigned

### 3) Run playbook
```
./scripts/run-playbook.sh
```

### 4.1) Check resulting squid server using SSH
Just to make sure files etc are in right place....

- There should be a squid conf file at: `/etc/squid/squid.conf`

### 4.2) Test Using Curl
- Uses credentials from `squid_username` and `squid_password` ansible variables (NOT the password used in /etc/squid/passwords, which is just a hash or something)
- Also uses the public ip you used in the `hosts.ini` file.
```
curl -v -x http://your_squid_username:your_squid_password@your_server_ip:3128 http://www.google.com/
```

##### Possible results
- Failed to connect
    ```
    curl: (7) Failed to connect to 146.190.52.6 port 3128 after 211 ms: Connection refused
    ```

    This means squid service is down. Droplet is probably up, but need to either wait for the systemctl service to finish restarting or it went down.

- HTTP returned, including message: `Access control configuration prevents your request from being allowed at this time`
    - Something is wrong with your `squid.conf` file.
    - Try commenting out all the `http_access deny...` lines and add a `http_access allow all` to confirm this is what's going on. 


Note that one possible reason why it's failing is that your squid.conf file is only allowing access from whitelisted ips. If you are working with a stable ip, or within the local network, then this is doable...if you're not, then add: 
```
acl other_allowed_hosts src 0.0.0.0/0
http_access allow other_allowed_hosts
```
(https://serverfault.com/a/1008074/458928)
## Build Status

### GitHub Actions

![Molecule Test](https://github.com/mrlesmithjr/ansible-squid/workflows/Molecule%20Test/badge.svg)

### Travis CI

[![Build Status](https://travis-ci.org/mrlesmithjr/ansible-squid.svg?branch=master)](https://travis-ci.org/mrlesmithjr/ansible-squid)

## Requirements

For any required Ansible roles, review:
[requirements.yml](requirements.yml)

## Role Variables

[defaults/main.yml](defaults/main.yml)

## Dependencies

## Example Playbook

[playbook.yml](playbook.yml)

## License

MIT

## Based on work by:

Larry Smith Jr.

- [@mrlesmithjr](https://twitter.com/mrlesmithjr)
- [mrlesmithjr@gmail.com](mailto:mrlesmithjr@gmail.com)
- [http://everythingshouldbevirtual.com](http://everythingshouldbevirtual.com)

> NOTE: Repo has been created/updated using [https://github.com/mrlesmithjr/cookiecutter-ansible-role](https://github.com/mrlesmithjr/cookiecutter-ansible-role) as a template.
