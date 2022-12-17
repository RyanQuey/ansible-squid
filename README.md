# ansible-squid

Ansible role to install/configure Squid Proxy


## Quick start guide

TODO test again, now with the basic auth settings changed. Last time I ran I did some manual command
- I did save the working squid.conf file here though: `./squid.working-example.conf`

0) prereqs

- doctl installed
- Ansible playbook installed
- htpassword module (https://docs.ansible.com/ansible/latest/collections/community/general/htpasswd_module.html): 
    ```
    ansible-galaxy collection install community.general
    ```

- There are also others listed in ./roles/ansible-squid/requirements.in 
1) Spin up droplet
```
./scripts/do-create-droplet.sh
```

2) Get public ip of droplet
```
doctl compute droplet list
```
If no public ip is shown, you might have to wait a few moments first for the ip to be assigned

3) Run playbook
```
./scripts/run-playbook.sh
```

4) Test Using Curl
```
curl -v -x http://your_squid_username:your_squid_password@your_server_ip:3128 http://www.google.com/
```

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

## Author Information

Larry Smith Jr.

- [@mrlesmithjr](https://twitter.com/mrlesmithjr)
- [mrlesmithjr@gmail.com](mailto:mrlesmithjr@gmail.com)
- [http://everythingshouldbevirtual.com](http://everythingshouldbevirtual.com)

> NOTE: Repo has been created/updated using [https://github.com/mrlesmithjr/cookiecutter-ansible-role](https://github.com/mrlesmithjr/cookiecutter-ansible-role) as a template.
