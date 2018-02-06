# **Ansible-MessageOfTheDay**

Ansible-MessageOfTheDay is an Ansible role for configuring Ubuntu-like Message Of The Day (MOTD) on Debian systems.

## **Requirements**

At the moment this role is being written for Debian (Jessie and Stretch). It may evolve to include other major distributions (except Ubuntu).

## **Role Variables**

There are 8 role variables:
```
runtime
mount_points
mount_info
network_info
figlet_hostname
display_header
memory_info
pkg_info
```
* `runtime` variable stores the date format. Default date format is `+%A %d %B, %Y @ %k:%M:%S %Z` which is passed to the date command every time a user logs in.
* `mount_points` variable will have mount poins whose storage consumption you wish to display. By default its set to `/`. You can add any other mount points you wish display on MOTD.
* `mount_info` variable is set to `True` by default. When set to `False`, it will not display information of mounted partitions and their storage consumption.
* `network_info` variable gets IP addresses on all interfaces of the system. By default its set to `False`. You canset this to `True` if you wish to see network information on MOTD. If set to `True` this will also install `moreutils` package which helps in acquiring IP addresses of all interfaces of the system.
* `figlet_hostname` is set to True by default. It will install figlet package and use it to display hostanme in MOTD.
* `display_header` shows distribution information after displaying figlet hostname. By default its set to `True`. You can set it to `False` if you do not wihs to see dsirtibution information.
* `memory_info` shows RAM and swap information. By default its set to `True`. You can set it to `False` if you do not want to see it on MOTD.
* `pkg_info` is set to `True` by default and shows package updates.

## **Dependencies**

This role doesn't depends on any other role for execution.

## **Example Playbook**

An example of running the role is as follows:

    - hosts: servers
      gather_facts: True
      roles:
         - Ansible-MessageOfTheDay

By default if will give you an output as follows:

```
 __  __            _       ____  ____         ___  _ 
|  \/  | __ _ _ __(_) __ _|  _ \| __ )       / _ \/ |
| |\/| |/ _` | '__| |/ _` | | | |  _ \ _____| | | | |
| |  | | (_| | |  | | (_| | |_| | |_) |_____| |_| | |
|_|  |_|\__,_|_|  |_|\__,_|____/|____/       \___/|_|
                                                     

Welcome to Debian GNU/Linux 8.10 (jessie) (3.16.0-5-amd64).

System Information as of Monday 29 January, 2018 @ 12:43:35 PKT

Average System Load: 0.38 0.16 0.06

Total RAM: 1503 MiB     RAM Used: 31.00%
RAM Cached: .66%        RAM Free: 68.99%
RAM Available: 11.70%   Total SWAP: 1699 MiB
SWAP Used: 0%           SWAP Free: 100.00%

Total Storage Used on /: 10%

A total of 17 are pending.
17 are security updates.
```

If, for example, you want to disaply network information and modify date format:

    - hosts: servers
      gather_facts: True
      roles:
         - { role: Ansible-MessageOfTheDay, runtime: "%k:%M:%S %Z", network_info: True }

Similarly, you may use other variables.

## **License**

This playbook is licensed under GPL License, version 2 (See the LICENSE file).

## **Author**

* Thanks to @nickcharlton for writing [this](https://nickcharlton.net/posts/debian-ubuntu-dynamic-motd.html) post.
* [Saad Ali](https://github.com/nixknight)