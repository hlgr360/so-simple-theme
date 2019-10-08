---
layout: post
title: "Scripted cloning multi-repo projects"
categories: blog
excerpt: "Or what changing job and devops have in common"
tags: [development]
author: hlgr360
share: true
---

One of the under appreciated toils of changing jobs (and laptops for that matter) is the setup from scratch of my various projects. Like in DevOps, this repeated exercise every few years results in a certain discipline in and appreciation of both documentation and automation. It becomes basic hygiene like release deployment in DevOps: 'if it hurts you are not doing it often enough'.

Given the high number of repos in one of my Microservices projects, I quickly got tiered of copying and pasting the URL to the terminal to clone them to my new laptop. So I wrote a small bash script for reading the repo names from a file and cloning them in turn.

```text
#!/bin/bash
filename=$1
n=1
while read line; do
# reading each line
git clone git@bitbucket.org:<your_org_here>/`echo $line`.git
n=$((n+1))
done < $filename
```

The corresponding input file is simple enough

```text
acd-api
acd-api-backend
acd-api-queues
acd-apis-store
acd-api-topics
acd-app-api
acd-app-backend
...
````

And no, I did not crawl the web for a git voodoo magic command which would could do it for me - sometimes bash is  good enough for me. Writing bash scripts is a road down memory lane to my humble beginnings as sysadmin in the IBM Nordic Labs in Stockholm.

May the (scripting) power be strong in you. 
