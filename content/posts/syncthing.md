---
layout: post
title:  "Installing Syncthing alongside Nextcloud"
date:   2021-03-09 20:21:37
categories: [tutorial]
comments: false
share: true
showDate: true
draft: true
tags: [cloud, server]
---

I've been using a self-hosted solution for my Nextcloud for quite some time now. I always felt like the performance was not up to par, especially on my lower end devices. My MacBook almost reached 100% CPU usage just by using the synchronization tool from the official Nextcloud client. This does not usually appear to a problem, but in my particular scenario, I have to synchronize a lot of small files due to very fragmented project structures, which seem very demanding for the indexing algorithm. 

In need for a more lightweight solution a friend of mine recommended to use [Syncthing](https://syncthing.net/). Instead of focusing on all the different aspects of a complete cloud solution, Syncthing just tries to do one thing, and seems to do it just right. For me it is a lot more usable as it allows me to sync individual folders in my home directory with ease. When using the Nextcloud client it is required to have all the files in one folder. Of course you can just create a lot of symlinks, but just syncing to the real folders in the home directory just makes way more sense to me.

Depending on the type of files you can add different versioning systems for each folder respectively. This way you can avoid unnecessary overhead. Furthermore it is also a very easy to install. One possible downside is that it only works locally. But keep in mind the Nextcloud can also keep track of all the files. Keep in mind that the Nextcoud still needs to keep a watchdog on the original folder structures. This only seems to work out of the box when using external storage, since the Nextcloud initiates a watchdog here by default. Hence I would  highly recommend the use of external storage here, but keep in mind there come many factors into play when considering an adequate solution here.

On [Raspbian](https://www.raspbian.org/), you can just run

```shell 
sudo apt-get install syncthing
```
to install the latest version.


Now you need to locate the storage folder of your Nextcloud, which will also be become the root directory of all the folder we want to add to synchting. It is important here, that the user that executes syncthing also has to be the owner of the directory. Check by using `ls -l`. Use 

```shell
chown -R user:user foldername
```
for all the folders you want to sync.

Now we want to enable the systemd service for syncthing. In case of Debian based distros the service files should be already installed, on other distros there might be additional steps required. Now we start it as a system service.

```shell
systemctl enable syncthing@username.service
systemctl start syncthing@username.service
```

If everything was successful, you should see the service now using

```shell
systemctl status syncthing@username.service
```

As syncthing is now up and running we can setup syncthing now. By default the syncthing interface is only accessible via `localhost` on the host machine. This is easily fixed by following the recommendation from the [FAQ](https://docs.syncthing.net/users/faq.html#how-do-i-access-the-web-gui-from-another-computer).

Now you can install the Syncthing client on your other machines and replace the folders that are synchronized by the Nextcloud client. This may seem trivial to do, but for me it was the file sync solution I've always wanted.
