#!/bin/bash
#
# 04-pkg-updates.sh - Show network information
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

function updatesInfo() {
  local DIST_UPGRADE_OUTPUT="$(apt-get dist-upgrade -s | grep Inst)"
  local TOTAL_UPDATES=$(echo "${DIST_UPGRADE_OUTPUT}" | grep -c Inst)
  local SECURITY_UPDATES=$(echo "${DIST_UPGRADE_OUTPUT}" | grep Inst | grep Security -c)
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