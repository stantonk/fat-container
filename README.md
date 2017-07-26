fat-container
=============
**This breaks all sorts of Docker dogma and is full of security best-practice violations.** Basically don't ever use something like this...except when you need something *like* a real-life Linux server running Ubuntu 14.04...purely as *test fixturing* for something else.

Essentially what I wanted here was something like Vagrant but isn't slow as h\*ck to spin up and provision.

```
$ docker run -d --rm -p8080:8080 -p2222:22 fat-container

$  ssh -p2222 vagrant@127.0.0.1
vagrant@127.0.0.1's password:
Welcome to Ubuntu 14.04.3 LTS (GNU/Linux 4.9.36-moby x86_64)

 * Documentation:  https://help.ubuntu.com/
Last login: Tue Jul 25 20:00:29 2017 from 172.17.0.1
vagrant@684ae3979f66:~$
```