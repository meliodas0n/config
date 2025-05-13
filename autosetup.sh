#!/bin/env bash
set -e

CONFIG_FOLDER=$HOM/config

ubuntu_install() {
  echo "Updating the System First"
  sudo apt-get update && sudo apt full-upgrade && sudo apt dist-upgrade -y
  echo "System upgrade completed"

  . install/nvim_install
  . install/tmux_install
}

arch_install() {
  echo "Arch install started $(date)"
}

install() {
  echo "Starting auto setup of the tools"
  echo "passed distro is $DISTRO"
  if [ "$DISTRO"  = "Ubuntu" ]; then
    ubuntu_install
  elif [ "$DISTRO" = 'Arch' ]; then
    arch_install
  fi
}

if [ $# -ne 1 ]; then
  echo "Invalid distribution or wrong arguments"
else
  DISTRO=$1
  install
fi