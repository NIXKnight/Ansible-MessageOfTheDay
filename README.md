# **Ansible-MessageOfTheDay**

Ansible-MessageOfTheDay is an Ansible role for configuring Ubuntu-like Message Of The Day (MOTD) on Debian systems.

## **Requirements**

At the moment this role is being written for Debian (Jessie and Stretch). It may evolve to include other major distributions (except Ubuntu).

## **Role Variables**

There are 8 role variables:
```
runtime
mount_points
network_info
mount_info
figlet_hostname
display_header
memory_info
pkg_info
```
## **Dependencies**

This role doesn't depends on any other role for execution.

## **Example Playbook**

Examples will be included later on how to use role variables.

## **License**

This playbook is licensed under GPL License, version 2 (See the LICENSE file).

## **Author**

[Saad Ali](https://github.com/nixknight)