#!/bin/bash
#
# 10-sysinfo - generate the system information
# Copyright (c) 2018 Saad Ali
#
# Authors: Saad Ali <saad@nixknight.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

function pcGen() {
  echo "scale=2; $1 * 100/1" | bc -l
}

function memoryAndSwapInfo() {
  local FREE_OUTPUT="$(free -m)"
  local RAM_TOTAL=$(echo "${FREE_OUTPUT}" | awk '{print $2}'| head -2 | tail -1)
  local RAM_USED=$(echo "${FREE_OUTPUT}" | grep Mem | awk '{print $3/$2}')
  local RAM_BUFF=$(echo "${FREE_OUTPUT}" | grep Mem | awk '{print $6/$2}')
  local RAM_FREE=$(echo "${FREE_OUTPUT}" | grep Mem | awk '{print $4/$2}')
  local RAM_AVAILABLE=$(echo "${FREE_OUTPUT}" | grep Mem | awk '{print $7/$2}')
  local SWAP_TOTAL=$(free -m | grep Swap | awk '{print $2}')
  local SWAP_USED=$(free -m | grep Swap | awk '{print $3/$2}')
  local SWAP_FREE=$(free -m | grep Swap | awk '{print $4/$2}')
  echo -e "Total RAM: $RAM_TOTAL MiB\tRAM Used: $(pcGen $RAM_USED)%"
  echo -e "RAM Cached: $(pcGen $RAM_BUFF)%\tRAM Free: $(pcGen $RAM_FREE)%"
  echo -e "RAM Available: $(pcGen $RAM_AVAILABLE)%\tTotal SWAP: $SWAP_TOTAL MiB"
  echo -e "SWAP Used: $(pcGen $SWAP_USED)%\t\tSWAP Free: $(pcGen $SWAP_FREE)%"
}

function mountInfo() {
  local DF_OUTPUT="$(df -h)"
  local MOUNTPOINTS="/"
  for MOUNTPOINT in $MOUNTPOINTS ; do
    local USED_PC=$(echo "${DF_OUTPUT}" | grep "$MOUNTPOINT$" | awk '{print $5}')
    echo -e "Total Storage Used on $MOUNTPOINT: $USED_PC"
  done
}

function networkInfo() {
  local IFACES=$(ls /sys/class/net)
  for IFACE in $IFACES ; do
    local IFACE_ADDRESS=$(ifdata -pa $IFACE)
    if [[ "$IFACE_ADDRESS" != "NON-IP" ]] ; then
      echo -e "Interface $IFACE IP Address: $IFACE_ADDRESS"
    fi
  done
}

function updatesInfo() {
  local DIST_UPGRADE_OUTPUT="$(apt-get dist-upgrade -s | grep Inst)"
  local TOTAL_UPDATES=$(echo ${DIST_UPGRADE_OUTPUT} | grep -c Inst)
  local SECURITY_UPDATES=$(echo ${DIST_UPGRADE_OUTPUT} | grep Inst | grep Security -c)
  if [[ "$TOTAL_UPDATES" -gt 0 ]] ; then
    echo -e "A total of $TOTAL_UPDATES are pending."
    if [[ "$SECURITY_UPDATES" -gt 0 ]] ; then
      echo -e "$SECURITY_UPDATES are security updates."
    fi
  else
    echo -e "There are no updates available at the moment."
    echo -e "Make sure that apt cache is up-to-date."
  fi  
}