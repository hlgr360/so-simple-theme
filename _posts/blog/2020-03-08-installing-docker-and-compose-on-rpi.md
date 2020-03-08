---
layout: post
title: "Install docker and docker-compose on RPi"
categories: blog
excerpt: "Simple step-by-step recipe to install docker and docker-compose on Raspberry Pi"
tags: [development, rpi]
author: hlgr360
share: true
---

Another weekend, another project of my son. For whatever reason he has suddenly become very privacy focused and asked me to sell his Alexa and run a [pihole](https://pi-hole.net) on one of our Raspberry Pi's. Now - given that I had to reinstall the RPi multiple times after some of his other crafty experiments - this felt like a good time to use his enthusiasm and have him learn docker.

But as usual (sadly I must admit), trying to find a simple step-by-step tutorial turned into a chase of breadcrumbs across the web. So for your and my benefit, here is a summary of my steps to get `docker` and `docker-compose` up and running on a RPi. After I had finished my setup I stumbled across [Installing Docker and Docker Compose on the Raspberry Pi in 5 Simple Steps](https://dev.to/rohansawant/installing-docker-and-docker-compose-on-the-raspberry-pi-in-5-simple-steps-3mgl) which further reduces the steps needed. Your leverage might vary, but it from briefly reviewing it it might as well do the trick.

The following steps are based on [Happy Pi Day with Docker and Raspberry Pi](https://www.docker.com/blog/happy-pi-day-docker-raspberry-pi/) with the missing command for apt-key taken from [Docker Tutorial 1: Docker Installation in Ubuntu 18.04](https://medium.com/@sh.tsang/installation-of-docker-3b18d9e70bea) and [How to fix docker: Got permission denied while trying to connect to the Docker daemon socket](https://www.digitalocean.com/community/questions/how-to-fix-docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket) to allow the `pi` user to run docker.

Execute the following steps to install docker (details for each step see [here](https://www.docker.com/blog/happy-pi-day-docker-raspberry-pi/)):
* `sudo apt-get install apt-transport-https ca-certificates software-properties-common -y`
* `curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh`
* `sudo usermod -aG docker pi`
* `sudo curl https://download.docker.com/linux/raspbian/gpg | sudo apt-key add -`
* `sudo add-apt-repository "deb https://download.docker.com/linux/raspbian/ stretch stable"`
* `sudo apt-get update`
* `sudo apt-get upgrade`
* `systemctl start docker.service`
* `docker info` 

If after the last step you get the following permission problem

`> Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/json: dial unix /var/run/docker.sock: connect: permission denied`

Apply the following fix (from [here](https://www.digitalocean.com/community/questions/how-to-fix-docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket)):

* `sudo chmod 666 /var/run/docker.sock`

But installing `docker` is only half the fun without `docker-compose` (taken from (here)[https://dev.to/rohansawant/installing-docker-and-docker-compose-on-the-raspberry-pi-in-5-simple-steps-3mgl]):

* `sudo apt-get install libffi-dev libssl-dev`
* `sudo apt-get install -y python python-pip`
* `sudo apt-get remove python-configparser`
* `sudo pip install docker-compose`

To see if it all works, run yourself a [portainer](https://www.portainer.io) instance on your RPi (inspired by [this](https://blog.hypriot.com/post/new-docker-ui-portainer/)). Create a `docker-compose.yml` file with the following content

```text
dockerui:
  image: portainer/portainer:arm
  restart: always
  volumes:
    - '/var/run/docker.sock:/var/run/docker.sock'
  expose:
    - 9000
  ports:
    - 8080:9000
```
and run it in the same directory with `docker-compose up`.

To find the corresponding `docker-compose` definition for `pihole`, visit their github repo at <https://github.com/pi-hole/docker-pi-hole/>.

Docker you should, if not want in installation hell you live.
