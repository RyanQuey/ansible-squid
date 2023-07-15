# ansible-squid

Ansible role to install/configure Squid Proxy


## Quick start guide
0) prereqs

- doctl installed
- Ansible playbook installed
- set password (follow example in `./roles/main.yml.example`, but use real password)

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
