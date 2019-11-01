---
layout: post
title: "Minecraft Forge install on MacOS"
categories: blog
excerpt: "Simple step-by-step recipe to install Minecraft Forge on MacOS"
tags: [development, minecraft]
author: hlgr360
share: true
---

Setting up a Minecraft Forge environment for my youngest one to get into programming, I keep being reminded that there are almost no simple step-by-step recipes to install Minecraft Forge on MacOS:

* If needed, download and install Java JDK 1.8 from our friends at Oracle at <https://www.oracle.com/java/technologies/jdk8-downloads.html>
  * If you want to avoid having to register, follow the suggestion in [this thread](https://gist.github.com/wavezhang/ba8425f24a968ec9b2a8619d7c2d86a6#gistcomment-3019424)
* Download and install Eclipse from <https://www.eclipse.org/downloads/>
* Download and install GIMP from <https://www.gimp.org/downloads>
* Download Forge 1.12 from <https://files.minecraftforge.net/maven/net/minecraftforge/forge/index_1.12.html> (pick the Mdk download option)
  * Move the  'forge' directory in 'Downloads' to a folder of your choice, i.e. `Documents`
  * Create a new directory 'eclipse' inside the 'forge' directory
  * Open a terminal and navigate to the 'forge' directory, i.e. `cd Documents/forge`
  * Execute the following command inside of 'forge' directory: `./gradlew setupDecompWorkspace --refresh-dependencies`
  * Upon successful build, execute the following command: `./gradlew setupDecompWorkspace eclipse`
* Open eclipse and select the 'eclipse' directory inside your 'forge' directory as workspace
  * You should now see the MDKExample mod inside the package explorer

The above versions are tailored to be used with the [Minecraft Modding Course](https://www.udemy.com/course/minecraft-modding-java/) on [Udemy](https://udemy.com). 

#### References
* <https://techwiseacademy.com/minecraft-modding-setting-up-your-environment/>
* <https://blog.usejournal.com/a-beginners-guide-to-modding-minecraft-9a42536495f6>