#!/usr/bin/env bash

install_flatpak() {
  echo "Flatpak is already installed"
  echo "Version: $(flatpak --version)"
  echo "Adding flatpak repo if not exists"
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  echo "Flatpak is added, please reboot your system and run the script as './spotify.sh 2'"
}

if [ ! "$(flatpak --version)" ]; then
  echo "flatpak is not installed, please use below instructions"
  echo "Go to your NixOS configuration add flatpak service"
  # I wish I could do this programmatically
  echo "services.flatpak.enable = true;"
  echo "The build your configuration"
  echo "sudo nixos-rebuild switch"
  echo "Once the build is completed pass '1' to this script as arg"
  echo "./spotify.sh 1"
else
  install_flatpak
fi

arg=$1

if [ "$arg" = "1" ]; then
  install_flatpak
elif [ "$arg" = "2" ]; then
  echo "Installing spotify from flatpak and running it"
  echo "Please approve for any prompts"
  flatpak install flathub com.spotify.Client
  flatpak run com.spotify.Client
else
  echo "Unknown arg $arg"
  echo "Options available are:"
  echo "1: to add flatpak repo if flatpak is already installed"
  echo "2: to install spotify, if flatpak is installed and repo is added"
fi