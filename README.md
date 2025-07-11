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

#### 0.1) If doing Docker:...
- Intro
    * Some discussion on pros and cons: https://www.reddit.com/r/ansible/comments/sn3axd/running_ansible_server_in_docker_container/ (accessed July 2025)
    * Note that alternative would be ansible-builder, see this: https://www.redhat.com/en/blog/introduction-to-ansible-builder?intcmp=7015Y000003t7aWQAQ (accessed July 2025)

All the above should be accomplished by running:

```
./scripts/docker/setup/create-images.sh
```

#### 0.2) Set squid password
- Make sure to set squid password in: `roles/ansible-squid/vars/main.yml` (make a copy from `roles/ansible-squid/vars/main.yml.example`)


### 1) Spin up droplet
```
./scripts/do-create-droplet.sh
```

Mar 2024 update: didn't get it working, some sort of auth issue. Might be because of old CLI client. So just used the DO dashboard and it worked great. 

### 2) Set hosts in `hosts.ini`
#### 2.1) Get public ip of droplet
```
doctl compute droplet list
```

Or in Docker:
```
./scripts/docker/DOCKER-do-list-droplets.JSON.sh
```

If no public ip is shown, you might have to wait a few moments first for the ip to be assigned.

#### 2.2) Set in file
```
cp hosts.ini.example hosts.ini
vim hosts.ini
```

### 3) Run playbook

#### 3.1) Set vars
Edit vars, to set password and decide if you want to open up to all hosts. (which you do, or you ahve to whitelist your ip, and make sure it's a stable ip, etc)
```
vim ./roles/ansible-squid/vars/main.yml
```

NOTE make sure to set this if you do want to allow all hosts, not just a whitelisted ip.
```
squid_allow_all_hosts: true
```

#### 3.2) Run it
```
./scripts/run-playbook.sh
```
or in docker:
```
./scripts/docker/DOCKER-run-playbook.sh
```

#### DEBUGGING RUNNING PLAYBOOK
- Try SSH inside of Docker
    ```
    ./scripts/docker/DOCKER-ssh-into-droplet.sh
    ```




### 4.1) Check resulting squid server using SSH
Just to make sure files etc are in right place....

Can use script to ssh in as well: 

```
$DO_HOST=123.456.789.012
./scripts/ssh-into-droplet.sh $DO_HOST
```

- There should be a squid conf file at: `/etc/squid/squid.conf`

### 4.2) Test Using Curl
- Uses credentials from `squid_username` and `squid_password` ansible variables (NOT the password used in /etc/squid/passwords, which is just a hash or something). 
    * By default, set to whatever you have in `/roles/ansible-squid/defaults/main.yml` for username, and `roles/ansible-squid/vars/main.yml` for password. 
    * But there is a number of ways they can be overwritten in ansible.
- Also uses the public ip you used in the `hosts.ini` file.
```
curl -v -x http://${your_squid_username:-ryan}:your_squid_password@your_server_ip:3128 http://www.google.com/
```
# TODOs
- [ ] make basic auth actually work. Right now, all passwords just go through.

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

- Note that this needs to be put in *before* the `http_access deny all` line. 
- Again, make sure to restart your server before continuing after making changes to this file:


```
systemctl restart squid
```
(run this from within the server, using ssh)


### 5) Set your computer to use the proxy
Welll...assuming that's what the proxy is for. 

But if for Windows 10 for example, just open Chrome and then open computer proxy settings through that, or open directly from windows settings. Then put in the squid username and password set in the `squid_username` and `squid_password` ansible variables.


Actually it looks like you just put in the public ip of the droplet into that config, and then when you open chrome for the first time, then it will prompt you for creds. 

If you put these same creds before in this same computer, it might remember then, even months afterwards. 

You can also test to see if it's working by visiting e.g., 

https://whatismyipaddress.com/

#### Setting up proxy in MacOs:

- Just google it, their settings change location from time to time. 
    * But general idea is, turn on `Secure web proxy (HTTPS)`, for `Server` put the public IP (e.g., `143.110.158.56`, whatever your droplet's ip is) and port is 3128.
    * You have to turn on `Proxy server requires password` (since it does` and put in creds, as described above already. 

## Status

- Working as of July 2025 
    * UPDATE July 10th, it worked, but basic auth would always allow them through, regardless of right or wrong password (or none at all)

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

# TODOs
- [ ] make basic auth actually work. Right now, all passwords just go through.

# Debugging Techniques
## 1) Test out the basic auth
- I was trying out this method: 
    https://gist.github.com/jackblk/fdac4c744ddf2a0533278a38888f3caf#file-squid_proxy_tutorial-md
- If want to make sure password should work therefore, follow his advice: 
    [Optional] Test the password store
        ```
        /usr/lib/squid3/basic_ncsa_auth /etc/squid/passwords
        ```
    After executing this line the console will look like its hung, there is a prompt without any text in it. Enter USERNAME PASSWORD (replacing these with your specific username and password) and hit return. You should receive the response "OK".


# Common Errors
## 1 - WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!

For example: 
```
fatal: [146.190.52.6]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\r\n@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @\r\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\r\nIT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!\r\nSomeone could be eavesdropping on you right now (man-in-the-middle attack)!\r\nIt is also possible that a host key has just been changed.\r\nThe fingerprint for the ED25519 key sent by the remote host is\nSHA256:76Aqh29g+E5ume6RiTFKGl+tR7sFreopumsffyQU12E.\r\nPlease contact your system administrator.\r\nAdd correct host key in /home/ryan/.ssh/known_hosts to get rid of this message.\r\nOffending ECDSA key in /home/ryan/.ssh/known_hosts:205\r\n  remove with:\r\n  ssh-keygen -f \"/home/ryan/.ssh/known_hosts\" -R \"146.190.52.6\"\r\nHost key for 146.190.52.6 has changed and you have requested strict checking.\r\nHost key verification failed.", "unreachable": true}
```

Solution: Did you remember to update your `hosts.ini` file with the new ip from the new DO droplet? 

## 2 Sorry, you are not currently allowed to request http://www.google.com/ from this cache until you have authenticated yourself
- This means auth is not working. But the proxy is up at least!
