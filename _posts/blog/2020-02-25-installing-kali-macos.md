---
layout: post
title: "Install Kali Linux on USB with MacOS"
categories: blog
excerpt: "Simple step-by-step recipe to install Kali Linux with Persistence with MacOS"
tags: [development, security]
author: hlgr360
share: true
---

I spend a couple of hours with my oldest son to setup Kali Linux with persistence on an USB stick using MacOS. For those of you who don't know [Kali Linux](https://www.kali.org), it is a special linux distro for penetration testing and network security. Well, my son claims he needs it because he is on the hook for a graded presentation in his school about ethical hacking. But if this is his sole motivation I have my doubts - I feel an equal part in this is his desire to (a) hack my laptop and (b) to circumvent the time limits I put on his MacBook. But do I prefer him playing his brains out in Badlands or use the opportunity for him to learn a thing or two. 

I still remember - back in the 80's - the thrill of calling up an unlisted data phone line with my first modem. Back in the day my home was still called East Germany and owning a private data modem (courtesy of my father working in IT research) was somewhat unusual. I guess it was fun (and did not work) except 15 min someone called back but hang up without saying a word. Well, that certainly gave me the creeps. But nothing else happened and in the following years I graduated from a bootlegged and modded version of [CP/M](https://en.wikipedia.org/wiki/CP/M) to a East-German version of the [ZX Spectrum](https://de.wikipedia.org/wiki/Spectral_(Heimcomputer)). Oh well, down memory lane ..

Back to Kali Linux. While there are plenty of tutorials how to install a straight Kali Linux on an USB stick, there are none showing how to install Kali Linux on an USB stick with the ability to persist changes. Running Kali Linux in any meaningful way on a bootable USB stick on a MacBook requires the installation of the Broadcom network drivers to be able to connect to the network. Without [Persistence](https://www.kali.org/docs/usb/kali-linux-live-usb-persistence/) the Linux distro is pretty limited.

The biggest problems we were facing were to format a limited partition on the USB stick in FAT32. Most tutorials assume that one wants to use the entire space for a single partition - which would not allow space for a secondary partition for persistence. And my trusted friend [gparted](https://gparted.org) can not resize the active partition which leaves us between [a rock and a hard place](https://en.wikipedia.org/wiki/Between_a_Rock_and_a_Hard_Place).

So here are the steps on MacOS to get you setup (assumption is that you have access to 'sudo' from the command line):

* Download the latest 'kali-linux-2020.1-live-amd64.iso' from <https://www.kali.org/downloads/>
* Insert your USB stick and open a terminal: 
    * `diskutil list` - find the disk id of your USB stick (in the following we assume `disk2` for my 64 GB USB stick)
    * `diskutil eraseDisk FAT32 KALI MBRFormat disk2` - creates a bootable FAT32 partition across the entire USB stick
    * `diskutil list` - validate the created partition on the USB stick (for me it would be `disk2s1`)
    * `diskutil splitPartition disk2s1 FAT32 KALI 10%` - resizes the partition `disk2s1` to 10% of its original size (here = 6.3 GB)
    * Remove your USB stick
* Download and install [unetbootin](https://unetbootin.github.io) to be able to burn the iso to a single partition
    * (You will need 'sudo' rights for this tool to work)
    * Re-insert your USB stick
    * Select the downloaded iso image (or pick one of the pre-selected images for a different Linux flavor)
    * Select the above created partition on the USB stick
    * Burn away

This creates a bootable USB stick with free space for creating a new partition under Kali Linux. Reboot your MacBook with the Option key pressed to enter the boot menu (see <https://support.apple.com/en-us/HT201255>). You should now be able to boot into Kali Linux.

To add persistence open the `gparted` under Linux and add a new 'primary, ext3' partition on your USB stick. Label it as 'persistence'. After creating the new partition the only remaining task is the step 4 in <https://www.kali.org/docs/usb/kali-linux-live-usb-persistence/> and you are done (after a reboot). (Note: I had to use vi to create the file as sudo).

Enjoy .. but now I better watch out for my son's diabolical laugh when he tries to DoS me .. but guess what, it is a challenge I gladly accept.

Hacking you must, but with great power great responsibility comes.