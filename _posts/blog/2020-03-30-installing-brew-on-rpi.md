---
layout: post
title: "Installing brew and lazydocker on RPi"
categories: blog
excerpt: "Installing a simple terminal UI for both docker and docker-compose on RPi"
tags: [development, rpi, docker]
author: hlgr360
share: true
---

This one is a quick one. I came across a very cool project called [lazydocker](https://github.com/jesseduffield/lazydocker) which provides a simple terminal UI for both docker and docker-compose. If you remember [Norton Commander](https://en.wikipedia.org/wiki/Norton_Commander), well then you know what I am talking about ;).

Turns out, something in me does not like the idea of using a dockerized tool to manage .... docker. Always on the lookout for a quick fix I saw that I could install `lazydocker` using [brew](https://brew.sh) (which I know well enough from MacOS).

So how about installing `brew` and then install `lazydocker` using brew - should be easy enough, or? And guess what - it was.

Installing `brew` on RPi was as easy as following [the instructions](https://docs.brew.sh/Homebrew-on-Linux). And then simply follow the instructions on [lazydocker](https://github.com/jesseduffield/lazydocker) - and it all worked within 5 min.

Wow .. 