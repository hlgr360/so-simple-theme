---
layout: post
title: "Running pihole on RPi at startup"
categories: blog
excerpt: "How to run services on Raspberry Pi at startup"
tags: [development, rpi]
author: hlgr360
share: true
---

Another weekend, and this time we will take a crack at running services like the [pihole](https://pi-hole.net) not from the command line, but at startup. 

This is kind of a hygiene task from our last project of running [pihole](https://pi-hole.net) using [docker and docker-compose on RPi](https://hlgr360.github.io/blog/blog/installing-docker-and-compose-on-rpi/). Back then I gave him a link to [Five Ways To Run a Program On Your Raspberry Pi At Startup](https://www.dexterindustries.com/howto/run-a-program-on-your-raspberry-pi-at-startup/) and asked him to implement the [systemd](https://www.dexterindustries.com/howto/run-a-program-on-your-raspberry-pi-at-startup/#systemd) approach. And while it took him a few tries he was able to get a first version to work. With that in place I was willing to reconfigure our Wifi router to use the 'pihole' as primary DNS server. 

Fast forward a couple of days and I noticed a lack of network activity on the pi - and after some more digging it turned out that the 'pihole' service was not longer running. But only this time the response of my son to my request of him debugging his solution was - how can I say - less than enthusiastic. He had already moved on and much rather annoyed his mother to install a 3D scanning app on her iPhone for him to be able to generate 3D models in [blender](https://www.blender.org) for his next 'Unity' project. 

Oh well, so much for trying to teach him persistence and pride in 'a job well done'. But I was also curious myself why it stopped working. So the old man got to work.

If you need a refresher on how to use 'systemctl' command I can highly recommend [How to use systemctl](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units).

So `sudo systemctl status pihole.service` to the rescue. A noticed quickly that he had simply copied the `sudo` CLI command to into the service definition and called it day. Well, there are a few things wrong with that - systemd is running as root at startup and therefor does not need `sudo`, plus not using absolute file paths pretty much invites problems since startup services like `systemd` has no home directory and path settings like the `pi` user. Also he did not set the proper dependencies to run the `pihole` after the `docker.service`.

But I would lie to say that I am all up on the latest on how to run docker as part of a `systemd` service. But this query on [How to make a Systemd Unit for docker-compose](https://github.com/docker/compose/issues/4266) gave me most of what I needed, in particular [this response](https://github.com/docker/compose/issues/4266#issuecomment-302813256). While playing around I did run into the problem of [docker run --> 'name is already in use by container'](https://stackoverflow.com/questions/31697828/docker-run-name-is-already-in-use-by-container) which did explain to me the cleanup commands prior to executing the service start.

Without much ado, here is my `pihole` service definition.

```text
# See https://github.com/docker/compose/issues/4266#issuecomment-302813256
[Unit]
Description=Starts pihole (an network wide ad blocker)
Requires=docker.service
After=docker.service

[Service]
Restart=always
WorkingDirectory=/lib/systemd/system/pihole.service.d

# Remove old containers, images and volumes
ExecStartPre=/usr/local/bin/docker-compose down -v
ExecStartPre=/usr/local/bin/docker-compose rm -fv
#ExecStartPre=-/bin/bash -c '/usr/bin/docker volume ls -qf "name=pihole*" | xargs docker volume rm'
ExecStartPre=-/bin/bash -c '/usr/bin/docker network ls -qf "name=piholeserviced_default" | xargs docker network rm'
ExecStartPre=-/bin/bash -c '/usr/bin/docker ps -aqf "name=pihole" | xargs docker rm'

# Compose up
ExecStart=/usr/local/bin/docker-compose up

# Compose down, remove containers and volumes
ExecStop=/usr/local/bin/docker-compose down -v

[Install]
WantedBy=multi-user.target
```

I placed the above file `pihole.service` in `/lib/systemd/system` and created a directory `/lib/systemd/system/pihole.-service.d` (set as workdirectory above). I placed the 'pihole' `docker-compose.yml` file into that directory - which saved me from having to specify the compose file via the `-f` command line parameter (remember that you can not assume to know from where the `systemd` process is running - so explicitly specifying absolute paths is a must).

All what was then left to do was the following commands:

* `sudo sudo systemctl daemon-reload` # to reload the changed definition
* `sudo systemctl start pihole.service` 
* `sudo systemctl status pihole.service`

On that note - I guess what I still need to teach my son that a job is only done when its done. 
